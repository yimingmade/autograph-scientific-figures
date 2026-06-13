# Autograph Scientific Figures

Autograph Scientific Figures is a portable agent workflow for generating publication-style academic figures in R. It gives an LLM a structured figure-generation process, bundled visual guidelines, bundled colour guidance, and a visual QA protocol for iterating on exported PNGs before returning a final figure.

The workflow is designed for researchers who want high-quality figures from their own tabular data while keeping the figure code and outputs organised in a local project folder.

## How To Use

Use Autograph Scientific Figures through the installed `make-figure` skill. The two main commands are:

1. `/make-figure`, for creating a new figure from a stated input directory.
2. `/make-figure edit`, for revising an existing figure script or exported PNG from a prior figure session.

The workflow checks R dependencies on first use, reads the bundled house-style and colour guidance, writes one stable R script per figure, exports versioned PNG outputs, visually checks the result, and iterates until the figure passes QA.

### What `/make-figure` Does

Use `/make-figure` when you want to create a new figure. Give the agent:

1. The input directory containing your data.
2. The file or files to use.
3. The graph type, such as line graph, forest plot, bar graph, percentage-change graph, age-sex pyramid, choropleth map, or heatmap.
4. The exact variables for axes, estimates, uncertainty intervals, colours, groups, panels, and filters.
5. A project name or output directory, if you want one.
6. Any style constraints or reference image.

The skill creates outputs under:

```text
./fig-dhs-output-main-dir/
./fig-dhs-activesessions-dir/
```

relative to the current project working directory, unless you provide an absolute output directory.

### New Figure Example

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example burden demo
Make a line graph of age-standardised mortality rate from 2000 to 2025 using burden_timeseries.csv.
Use year on the x-axis, estimate on the y-axis, cause as colour, and lower/upper as uncertainty ribbons.
Filter to location = Global, sex = Both, age_group = Age-standardised, measure = Mortality rate, metric = Rate per 100,000.
Use a clean publication style suitable for a manuscript figure.
```

### Stacked Bar Example

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example component demo
Make a horizontal stacked bar graph using component_composition.csv.
Show the percentage composition of total burden by component for each year.
Use year as rows, component as fill, and percent as the value.
Use direct, readable labels and keep the legend compact.
```

### Forest Plot Example

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example subgroup demo
Make a forest plot using subgroup_estimates.csv.
Filter to year = 2025.
Show estimate on the x-axis, subgroup on the y-axis, and lower/upper as confidence intervals.
Use domain as colour and include a vertical reference line at reference_value = 1.
Group related rows clearly.
```

### What `/make-figure edit` Does

Use `/make-figure edit` when a figure already exists and you want to revise it. The edit command should point to the existing R script, PNG, or session output folder whenever possible.

Good edit requests specify:

1. The input directory used for the figure.
2. The existing R script path, PNG path, or output folder.
3. The exact visual or data change requested.
4. Whether the change should preserve the current figure type and data filters.

The skill edits the same figure-specific R script, writes the next versioned output folder, copies forward unchanged PNGs when needed, and visually checks that the requested edit is actually visible.

### Edit Example

```text
/make-figure edit
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Existing script: ./fig-dhs-output-main-dir/example-burden-demo/r-code/age-standardised-mortality-line.R
Existing PNG: ./fig-dhs-output-main-dir/example-burden-demo/output-DDMMYYYY-v1/age-standardised-mortality-line.png
Please revise the figure by moving the legend below the plot, increasing the output height slightly, shortening long cause labels, and making the uncertainty ribbons lighter.
Preserve the same data filters, figure type, axes, and colour mapping.
```

If the target script or PNG cannot be identified, the skill should stop and ask you to point to the figure that should be edited.

## Installation For AI Agents

If a user asks an AI agent to install this repo, the agent should:

1. Clone or download this GitHub repository.
2. Run the installer script:

```bash
bash scripts/install.sh
```

3. If the user specifies a host, pass the relevant flag:

```bash
bash scripts/install.sh --codex
bash scripts/install.sh --claude
bash scripts/install.sh --all
```

4. Use `--dry-run` to preview the install and `--validate-only` to check packaged files:

```bash
bash scripts/install.sh --all --dry-run
bash scripts/install.sh --all --validate-only
```

5. Restart the host agent application if it only discovers skills at launch.
6. Confirm that R is available.
7. Run a first test using the synthetic example data in `examples/minimal-data/`.

Do not move files out of the skill folder during installation. The workflow resolves bundled references relative to `SKILL.md`.

## Installation For Codex

Recommended:

```bash
bash scripts/install.sh --codex
```

Manual fallback:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R .codex/skills/make-figure "${CODEX_HOME:-$HOME/.codex}/skills/make-figure"
```

Restart Codex after copying the skill.

## Installation For Claude Code

Recommended:

```bash
bash scripts/install.sh --claude
```

Manual fallback:

```bash
mkdir -p "${CLAUDE_HOME:-$HOME/.claude}/skills"
cp -R .claude/skills/make-figure "${CLAUDE_HOME:-$HOME/.claude}/skills/make-figure"
```

Restart Claude Code after copying the skill.

## R Dependencies

On first use, the skill checks core R package availability before rendering a figure. If core packages are missing, the workflow installs the missing core packages with the bundled installer script.

Minimum expected dependencies:

1. R
2. `ggplot2`
3. `patchwork`
4. `scales`
5. `data.table`

Common optional dependencies for more advanced figures:

1. `ggrepel`
2. `showtext`
3. `sysfonts`
4. `sf`
5. `rnaturalearth`
6. `ragg`
7. `magick`
8. `png`
9. `ggthemes`
10. `stringr`

Install the core R packages with:

```r
install.packages(c("ggplot2", "patchwork", "scales", "data.table"))
```

Install the extended set with:

```r
install.packages(c(
  "ggplot2", "patchwork", "scales", "data.table", "ggrepel",
  "showtext", "sysfonts", "sf", "rnaturalearth", "ragg",
  "magick", "png", "ggthemes", "stringr"
))
```

Some spatial and image packages may need system libraries depending on the operating system.

Check the current machine manually with:

```bash
Rscript scripts/check_r_setup.R --install-command
```

Preview package installation without installing anything:

```bash
Rscript scripts/install_r_dependencies.R --core --dry-run
```

Install missing core packages manually:

```bash
Rscript scripts/install_r_dependencies.R --core
```

Install selected optional packages only when a requested figure needs them:

```bash
Rscript scripts/install_r_dependencies.R --packages ggrepel,showtext,sysfonts
```

## Synthetic Example Data

The files in `examples/minimal-data/` are fully synthetic. The values were invented de novo for workflow testing. They are not patient data, do not represent real GBD estimates, and were not copied or derived from GBD or any public dataset.

The example data support:

1. Annual line graphs and time-series plots for every year from 2000 to 2025.
2. Annual stacked bar graphs for every year from 2000 to 2025.
3. Dot plots and forest plots, with subgroup estimates in both 2000 and 2025.
4. Percentage-change graphs from 2000 to 2025.

See `examples/example-briefs.md` for ready-to-use test prompts.

## Repository Notes

Generated figure outputs, active sessions, local R artefacts, and operating-system metadata should not be committed. The `.gitignore` file excludes these by default.

## Licence

This repository uses the MIT Licence. See `LICENSE`.

## What Is Included

```text
autograph-scientific-figures/
  .codex/
    skills/
      make-figure/
        SKILL.md
        agents/
          openai.yaml
        references/
        assets/
        scripts/
          check_r_setup.R
          install_r_dependencies.R
  .claude/
    skills/
      make-figure/
        SKILL.md
        references/
        assets/
        scripts/
          check_r_setup.R
          install_r_dependencies.R
  SKILL.md
  README.md
  LICENSE
  .gitignore
  references/
    figure_house_style_guidelines.md
    core-colour-guidelines.md
    checking-function.md
  assets/
    bad-examples/
      *.png
  examples/
    minimal-data/
      burden_timeseries.csv
      component_composition.csv
      percentage_change.csv
      subgroup_estimates.csv
    example-briefs.md
  scripts/
    check_r_setup.R
    install.sh
    install_codex_skill.py
    install_claude_skill.py
    install_r_dependencies.R
  tests/
    test_r_dependency_scripts.py
  DESCRIPTION
```
