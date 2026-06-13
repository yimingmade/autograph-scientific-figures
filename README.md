# Autograph: Generate figures from data without code

A guided agentic workflow for generating publication-quality academic figures with R without coding. It gives an LLM a structured figure-generation process, visual and structural guidelines, and a thorough quality-checking protocol for creating, editing and refining figure files using R (.PNG outputs).

All data represented in figures is deterministic, originating from your source data files and called through R.

Let your team spend more time on science and less on wrangling code.

## How To Use

Once installed, use Autograph through the installed `make-figure` skill. The two main commands are:

1. `/make-figure`, for creating a new figure.
2. `/make-figure edit`, for revising an existing figure R script or export PNG.

New to R? Autograph installs all required R dependencies needed automatically on first run.

### How To `/make-figure` Effectively

Use `/make-figure` when you want to create a new figure. Give the agent:

When you start a new session, give the agent:
1. The input directory containing your data (as a pathname, or a file).
2. The desired output folder (you may suggest a project or folder name too) in which Autograph creates two folders:
```text
./fig-dhs-output-main-dir/
./fig-dhs-activesessions-dir/
```
For each figure, provide:
1. The graph type (line graph, forest plot, bar graph, percentage-change graph, age-sex graph, choropleth map, heatmap, etc)
2. Variables. Be as detailed as possible. Nevertheless, Autograph can infer filters or variables that are not directly provided based on context, but specify this to the user after output.
3. Any other style constraints.

### New Figure Example

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: burden demo
Make a line graph of AS mortality rate from 2000 to 2025, global
Use year on the x-axis, estimate on the y-axis, cause as colour, and lower/upper as uncertainty ribbons.
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
