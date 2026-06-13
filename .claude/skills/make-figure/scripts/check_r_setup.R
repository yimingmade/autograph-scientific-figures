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
      "Check R package dependencies for make-figure.",
      "",
      "Usage:",
      "  Rscript scripts/check_r_setup.R [--all] [--install-command]",
      "  Rscript scripts/check_r_setup.R --packages pkg1,pkg2 [--install-command]",
      "  Rscript scripts/check_r_setup.R --list-core",
      "  Rscript scripts/check_r_setup.R --list-optional",
      "",
      "Options:",
      "  --all              Check core and optional packages.",
      "  --packages LIST    Check a comma-separated package list.",
      "  --install-command  Print the matching install command when packages are missing.",
      "  --list-core        Print core packages and exit.",
      "  --list-optional    Print optional packages and exit.",
      "  -h, --help         Show this help.",
      sep = "\n"
    ),
    "\n"
  )
}

has_flag <- function(flag) {
  flag %in% args
}

value_after <- function(flag) {
  index <- match(flag, args)
  if (is.na(index) || index == length(args)) {
    return(NULL)
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

if (has_flag("--list-core")) {
  cat(paste(core_packages, collapse = "\n"), "\n", sep = "")
  quit(status = 0)
}

if (has_flag("--list-optional")) {
  cat(paste(optional_packages, collapse = "\n"), "\n", sep = "")
  quit(status = 0)
}

custom_packages <- value_after("--packages")
if (!is.null(custom_packages)) {
  packages <- split_packages(custom_packages)
} else if (has_flag("--all")) {
  packages <- unique(c(core_packages, optional_packages))
} else {
  packages <- core_packages
}

if (!length(packages)) {
  cat("No R packages were supplied for checking.\n")
  quit(status = 1)
}

missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]

if (!length(missing)) {
  cat("R dependency check passed. Packages available: ", paste(packages, collapse = ", "), "\n", sep = "")
  quit(status = 0)
}

cat("Missing R packages: ", paste(missing, collapse = ", "), "\n", sep = "")

if (has_flag("--install-command")) {
  cat(
    "Run: Rscript scripts/install_r_dependencies.R --packages ",
    paste(missing, collapse = ","),
    "\n",
    sep = ""
  )
  cat(
    "Equivalent R command: install.packages(c(",
    quote_packages(missing),
    "), repos = \"https://cloud.r-project.org\")\n",
    sep = ""
  )
}

quit(status = 1)

