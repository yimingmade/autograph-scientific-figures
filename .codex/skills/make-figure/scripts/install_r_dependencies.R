#!/usr/bin/env Rscript

core_packages <- c("data.table", "ggplot2", "patchwork", "scales")
optional_packages <- c(
  "ggrepel", "showtext", "sysfonts", "sf", "rnaturalearth",
  "ragg", "magick", "png", "ggthemes", "stringr"
)

args <- commandArgs(trailingOnly = TRUE)

usage <- function() {
  cat(
    paste(
      "Install missing R package dependencies for make-figure.",
      "",
      "Usage:",
      "  Rscript scripts/install_r_dependencies.R [--core|--all] [--dry-run]",
      "  Rscript scripts/install_r_dependencies.R --packages pkg1,pkg2 [--dry-run]",
      "",
      "Options:",
      "  --core           Install missing core packages. This is the default.",
      "  --all            Install missing core and optional packages.",
      "  --packages LIST  Install missing packages from a comma-separated list.",
      "  --repos URL      CRAN repository URL. Defaults to https://cloud.r-project.org.",
      "  --dry-run        Print the install command without installing.",
      "  -h, --help       Show this help.",
      sep = "\n"
    ),
    "\n"
  )
}

has_flag <- function(flag) {
  flag %in% args
}

value_after <- function(flag, default = NULL) {
  index <- match(flag, args)
  if (is.na(index) || index == length(args)) {
    return(default)
  }
  args[[index + 1]]
}

split_packages <- function(value) {
  packages <- trimws(unlist(strsplit(value, ",", fixed = TRUE), use.names = FALSE))
  packages[nzchar(packages)]
}

quote_packages <- function(packages) {
  paste(sprintf('"%s"', packages), collapse = ", ")
}

if (has_flag("-h") || has_flag("--help")) {
  usage()
  quit(status = 0)
}

repos <- value_after("--repos", "https://cloud.r-project.org")
custom_packages <- value_after("--packages")

if (!is.null(custom_packages)) {
  packages <- split_packages(custom_packages)
} else if (has_flag("--all")) {
  packages <- unique(c(core_packages, optional_packages))
} else {
  packages <- core_packages
}

if (!length(packages)) {
  cat("No R packages were supplied for installation.\n")
  quit(status = 1)
}

missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]

if (!length(missing)) {
  cat("All requested R packages are already installed: ", paste(packages, collapse = ", "), "\n", sep = "")
  quit(status = 0)
}

install_expr <- paste0(
  "install.packages(c(",
  quote_packages(missing),
  "), repos = \"",
  repos,
  "\")"
)

if (has_flag("--dry-run")) {
  cat("Dry run. Would install missing R packages:\n")
  cat(install_expr, "\n", sep = "")
  quit(status = 0)
}

cat("Installing missing R packages: ", paste(missing, collapse = ", "), "\n", sep = "")
install.packages(missing, repos = repos)

still_missing <- missing[!vapply(missing, requireNamespace, logical(1), quietly = TRUE)]

if (length(still_missing)) {
  cat("Packages still missing after install attempt: ", paste(still_missing, collapse = ", "), "\n", sep = "")
  quit(status = 1)
}

cat("R dependency installation completed.\n")
quit(status = 0)

