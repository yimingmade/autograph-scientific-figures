# make-figure

`make-figure` is a portable agent workflow for generating publication-style academic figures in R. It gives an LLM a structured figure-generation process, bundled visual guidelines, bundled colour guidance, and a visual QA protocol for iterating on exported PNGs before returning a final figure.

The workflow is designed for researchers who want high-quality figures from their own tabular data while keeping the figure code and outputs organised in a local project folder.

## What Is Included

```text
make-figure/
  .codex/
    skills/
      make-figure/
        SKILL.md
        agents/
          openai.yaml
        references/
        assets/
  .claude/
    skills/
      make-figure/
        SKILL.md
        references/
        assets/
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
    install.sh
    install_codex_skill.py
    install_claude_skill.py
  DESCRIPTION
```

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
6. Confirm that R and the required R packages are available.
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

## How To Use

Start a prompt with `/make-figure` and give:

1. The input directory containing your data.
2. The desired graph type.
3. Variables, filters, groups, and output preferences.
4. Any reference image or local figure guideline file, if relevant.

Example:

```text
/make-figure
Input directory: /path/to/make-figure/examples/minimal-data
Project name: example burden demo
Make a line graph of age-standardised mortality rate from 2000 to 2025 using burden_timeseries.csv.
Use year on the x-axis, estimate on the y-axis, cause as colour, and lower/upper as uncertainty ribbons.
Filter to location = Global, sex = Both, age_group = Age-standardised, measure = Mortality rate, metric = Rate per 100,000.
```

The workflow creates outputs under:

```text
./fig-dhs-output-main-dir/
./fig-dhs-activesessions-dir/
```

relative to the current project working directory, unless the user supplies an absolute output directory.

## Synthetic Example Data

The files in `examples/minimal-data/` are fully synthetic. The values were invented de novo for workflow testing. They are not patient data, do not represent real GBD estimates, and were not copied or derived from GBD or any public dataset.

The example data support:

1. Line graphs and time-series plots.
2. Stacked bar graphs.
3. Dot plots and forest plots.
4. Percentage-change graphs.

See `examples/example-briefs.md` for ready-to-use test prompts.

## Repository Notes

Generated figure outputs, active sessions, local R artefacts, and operating-system metadata should not be committed. The `.gitignore` file excludes these by default.

## Licence

This repository uses the MIT Licence. See `LICENSE`.
