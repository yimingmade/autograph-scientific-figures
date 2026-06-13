---
name: make-figure
description: Use when the user types /make-figure for a new figure brief, or /make-figure edit for changes to an existing figure, with axes, variables, input data, output preferences, or a reference PNG, and wants R/ggplot2 figure generation with project-specific output folders, active session folders, and iterative visual QA against the house style guidelines.
---

# make-figure

Generate a publication-style figure in R, write project-specific R code and PNG outputs into the figure-design output folders, then inspect the exported PNG visually and iterate until spacing and export flaws are resolved.

## Portable Path Convention

This is a portable copy of the skill. Resolve bundled skill files relative to the directory containing this `SKILL.md`.

Use these packaged references:

1. `references/figure_house_style_guidelines.md`
2. `references/core-colour-guidelines.md`
3. `references/checking-function.md`
4. `assets/bad-examples/`
5. `scripts/check_r_setup.R`
6. `scripts/install_r_dependencies.R`

Resolve `./fig-dhs-output-main-dir` and `./fig-dhs-activesessions-dir` relative to the current project working directory unless the user explicitly supplies an absolute output directory.

## First-Use R Dependency Setup

Before generating or rendering the first figure in a fresh environment, run the bundled R dependency checker from the directory containing this `SKILL.md`:

```bash
Rscript scripts/check_r_setup.R --install-command
```

If any core R packages are missing, install the missing core packages before writing or running figure code:

```bash
Rscript scripts/install_r_dependencies.R --core
```

Core packages are:

1. `data.table`
2. `ggplot2`
3. `patchwork`
4. `scales`

Optional packages may be required for specific figure types or export paths. Install optional packages only when the requested figure or generated R script needs them. For example:

```bash
Rscript scripts/install_r_dependencies.R --packages ggrepel,showtext,sysfonts
```

Do not install the full optional package set by default. If dependency installation fails, stop before rendering and report the missing package names and the attempted install command.

## Trigger

Trigger when the user types:

`/make-figure [brief]`

or

`/make-figure edit [changes]`

The brief may include figure type, axes, variables, stratifiers, labels, requested colours, output preferences, or an input-directory path. A PNG reference image may also be attached.

In edit mode, the request should describe the changes to an already created figure and, when possible, identify the existing R script, PNG, or figure output being revised.

## Required Preconditions

Before doing any code generation:

1. Confirm an input directory has been explicitly specified:
   - earlier in the current thread, or
   - inside the current `/make-figure ...` request
2. Confirm or determine the session project output directory.
3. Confirm or create the active session directory.
4. Confirm or create the R-code and PNG output directories.

If no input directory path is present, stop immediately and ask the user to specify it before continuing:

`Please specify the input directory for this figure session, then rerun /make-figure.`

Do not proceed until that path is present in current chat context.

## Directory Requirements

### Input Directory

The input directory is the user-specified source directory for the data and related source files used to generate the figure.

1. The user must specify the input directory.
2. If the input directory is absent, ask for it before reading data, generating code, creating output directories, or making figures.
3. Do not infer the input directory from nearby folders.

### Output Directories

Use this output root:

`./fig-dhs-output-main-dir`

The session project output directory is generated once per `/make-figure` chat session, not once per figure. All figures generated or edited within the same `/make-figure` chat session must use the same session output directory unless the user explicitly starts a new session project output directory.

If the user specifies an output directory:

1. Use the specified output directory as the session project output directory.
2. If the specified output directory is a relative name, resolve it under `./fig-dhs-output-main-dir`.
3. Create the directory if it does not exist.
4. Do not search for a same-named folder elsewhere.
5. Do not move a same-named folder from another location into `./fig-dhs-output-main-dir`.

If the user does not specify an output directory:

1. Infer a likely session project name from the explicit project name, overall project theme, input-directory basename, or figure brief, in that order.
2. Convert the project name to a filesystem-safe slug using lowercase words separated by hyphens.
3. Create the session project output directory at:
   - `./fig-dhs-output-main-dir/<project-slug>`

Inside the session project output directory:

1. Create one R-code folder:
   - `r-code`
2. Save one R script per figure in `r-code`.
3. R scripts are never versioned.
4. Use one stable, descriptive R script filename per figure, derived from the figure content.
5. During QA cycles and figure edits, edit the same figure-specific R script rather than creating a new script for each QA attempt, unless the user explicitly asks for a separate copy.
6. Create session-level versioned PNG output folders using the current date:
   - `output-DDMMYYYY-v1`
   - `output-DDMMYYYY-v2`
   - `output-DDMMYYYY-v3`
7. Start at `-v1` and use the next available version number for the session output directory and date.
8. A version folder represents the figure set at that session version, not one figure.
9. If a new version updates only some figures, copy forward unchanged PNGs from the previous version folder so the new version folder contains the complete current figure set.
10. When multiple figures are generated or edited together, all figures in that render round must share the same target version folder.
11. Do not create one version folder per figure.
12. During QA cycles, export each new rendered PNG to the next versioned output folder and copy forward unchanged figures so previous rendered versions are preserved.
13. Return the final PNG path or paths from the versioned output folder that passes visual QA.
14. Keep output filenames descriptive to the figure content.
15. If multiple agents are generating or editing figures in the same `/make-figure` chat session, explicitly instruct all agents to use the same session output directory and coordinate version allocation before any rendering begins.

### Active Session Directory

Use this active-session root:

`./fig-dhs-activesessions-dir`

For every figure session:

1. Create an active session directory with the same basename as the session project output directory plus the suffix `-session`.
2. The path must be:
   - `./fig-dhs-activesessions-dir/<project-output-basename>-session`
3. Use the active session directory for session-local guidelines, notes, references, temporary work, and figure-state discovery.
4. Do not use the active session directory as the final PNG output directory.
5. Do not use the active session directory as the R-code output directory.
6. For edit requests, use the active session directory to help identify the current figure state, but the R script remains in the session project output directory's `r-code` folder.

## Inputs To Read

1. Read the full text after `/make-figure` as the figure brief.
2. If the command is `/make-figure edit [changes]`, treat it as an edit request for an existing figure rather than a new figure build.
3. Read the user-specified input directory path.
4. Read any user-specified output directory path or project name.
5. Determine the session project output directory and active session directory using `Directory Requirements`.
6. In edit mode, read the existing figure PNG visually if it is available in the request or can be identified from the session project output directory or active session directory.
7. In edit mode, read the existing R script for that figure if it is available in the request or can be identified in the session project output directory's `r-code` folder.
8. If a PNG or other image reference is attached, read the image visually in full.
   - Do not rely on metadata-only inspection.
   - Use the actual rendered image content as evidence for layout, composition, spacing, labels, and visual hierarchy.

## Identification Of Graph Type Desired

**IMPORTANT**: After reading the input and before generating or editing any code, identify the graph type. Output one line to the user in this exact format:

`[type: XXXX]`

Replace `XXXX` with the exact graph-type heading selected from `references/figure_house_style_guidelines.md`, sections 5.1 to 5.7, BUT do not output the section number itself.

Use explicit user wording first. If the user names a graph type directly, use that graph type unless the requested data structure clearly requires a more specific section. For ambiguous inputs, choose the section by analytic geometry in this priority order: map geography, mirrored age-sex geometry, percentage-change or interval-change geometry, point estimate with uncertainty by row, matrix or ranking table, bars or composition, then temporal trend.

### 5.1 Line Graphs And Time-Series Plots

Use `5.1 Line Graphs And Time-Series Plots` if the input mentions:

1. `line graph`, `line`, `lines`.
       BUT IF the following terms are present `trend`, `trajectory`, `time-series`, `forecast`, `projection`, or `over time`, consider between this line graph type versus `5.3 General Bar Graphs`.
2. A single data value, metric, estimate, rate, count, or burden measure presented over time.
3. Fewer than three data values presented over time, especially if they do not sum to a parent whole based on the data structure.
4. Historical and forecast periods, boundary years, ribbons, uncertainty intervals over time, or continuous x-axis years.
5. Crude and age-standardised rates over years when the main comparison is temporal movement.

### 5.2 Dot Plots And Forest Plots

Use `5.2 Dot Plots And Forest Plots` if the input mentions:

1. `dot plot`, `forest plot`, `point estimate`, `estimate with CI`, `estimate with UI`, `whiskers`, `odds ratio`, `hazard ratio`, `risk ratio`, `relative risk`, or a null/reference value.
2. Estimates with uncertainty intervals across diseases, regions, risks, exposures, subgroups, or models.
3. Rows of categories where the main mark should be a point or square plus a horizontal confidence interval.
4. Comparative estimates that do not primarily represent percentage change over a fixed interval.

### 5.3 General Bar Graphs

Use `5.3 General Bar Graphs` if the input mentions:

1. `bar graph`, `bar chart`, `bars`, `bar`.
          BUT IF the following terms are present `trend`, `trajectory`, `time-series`, `forecast`, `projection`, or `over time`, consider between this line graph type versus `5.1 Line Graphs And Time-Series Plots`.
2. Burden, rates, counts, proportions, age-specific distributions, country comparisons, region comparisons, disease comparisons, risk-factor comparisons, or grouped category comparisons shown as bars.
3. Three or more components presented over time or across categories, especially if they sum to a parent whole explicity, OR reasonably sum to a parent whole based on the data context.
4. Decomposition of change into components such as population growth, population ageing, risk exposure, disease group, cause group, or other additive contributors.
5. Category rankings where the requested display is bars rather than a matrix or heatmap.

After selecting `5.3 General Bar Graphs`, infer the desired bar-graph subtype before choosing geometry. Use these subtype rules:

#### 5.3.1 Stacked Bar Graphs

Use `5.3.4 Stacked Bar Graphs` if the input mentions:

1. `stacked bar`, `stacked bars`, `stack`, `component`, `constituent`, `contribution`, `share`, `proportion`, or `breakdown`.
2. A parent whole split into child components, for example CKLM split into ASCVD and SMD, disease burden split by component causes, or risk-attributable burden split by individual risk factors.
3. Three or more components shown across years, regions, countries, SDI groups, diseases, risks, or age groups, especially if the components sum to a parent total or percentage.
4. A request for risk-factor bars over time, component bars over time, or crude-number bars where the visible question is how components make up the total.
5. Percentage composition layouts like Figure 2, including horizontal 100 percent stacked bars with rows for years or parent groups.

For stacked bars, infer orientation separately: use horizontal stacked bars for long labels, rankings, countries, regions, SDI groups, risks, or diseases; use vertical stacked bars for chronological years, age bands, or compact time-series bars.


#### 5.3.4 Simple Unstacked Bar Graphs

Use simple unstacked bars within `5.3 General Bar Graphs` if the input mentions:

1. One value per category with no component split, uncertainty interval, percentage-change axis, map, heatmap, or mirrored age-sex structure.
2. Rankings by burden, rate, count, prevalence, incidence, DALYs, mortality, or another single metric where bars are requested.
3. Country, region, disease, risk, or SDI comparisons where each category has one estimate.

Use horizontal bars for long labels, rankings, and more than eight categories. Use vertical bars for short naturally ordered x-axes such as years, forecast intervals, or age groups.

### 5.4 Percentage-Change Graphs

Use `5.4 Percentage-Change Graphs` if the input mentions:

1. `percentage change`, `percent change`, `% change`, `pct_change`, `rate of change`, `change from`, `change between`, `growth`, `decline`, `increase`, or `decrease` over a fixed interval.
2. Diverging horizontal change bars, lollipop change plots, CI-bar change plots, positive versus negative change, or a zero reference line for change.
3. Change from one year to another, such as 1990 to 2021, 2021 to 2050, or 2026 to 2050.
4. Paired disease-change panels or cause-change panels where the main measure is relative change rather than absolute burden.
5. Rank-change small multiples with chronological columns, rank boxes, and connectors.

### 5.5 Tornado And Age-Sex Pyramid Plots

Use `5.5 Tornado And Age-Sex Pyramid Plots` if the input mentions:

1. `tornado`, in any form, OR `population pyramid`, `age-sex pyramid`, `pyramid`, `mirrored bars`, `male left female right`, or `female and male`.
2. Age groups on the vertical axis with sex shown on opposite sides of a central zero line.
3. Age-and-sex stratified burden, population, deaths, DALYs, rates, or composition.
4. Mirrored horizontal bars, central age labels, or a central gutter.
5. Overlay curves on an age-sex pyramid.

### 5.6 Choropleth Maps

Use `5.6 Choropleth Maps` if the input mentions:

1. `map`, `choropleth`, `world map`, `regional map`, `APAC map`, `country map`, `spatial`, `geographic`, `geographical`, `shade countries`, or `country polygons`.
2. Geographic burden, rates, ranks, categories, SDI groups, regions, or subregions displayed as filled areas on a map.
3. A request to colour countries, territories, provinces, states, or regions by an estimate, category, rank, or class.
4. Multi-panel maps comparing years, outcomes, causes, or measures across the same geography.

### 5.7 Heatmaps And Ranking Tables

Use `5.7 Heatmaps And Ranking Tables` if the input mentions:

1. `heatmap`, `matrix`, `ranking table`, `rank table`, `tile plot`, `grid`, `cells`, `rows and columns`, or `colour-coded table`.
2. Ordinal ranks, top-N rankings, risk-ranking summaries, or matrix comparisons.
3. Many categories crossed by years, outcomes, causes, regions, diseases, risks, or models where each cell encodes a value or rank.
4. A table-like figure where colour intensity, stepped colour, or rank labels carry the main comparison.
5. Rankings that are intended to be read as a grid or table rather than as bars.

## Determination of axes variables and confidence

Before generating or editing code, inspect the data source and map every requested plot or panel to exact data fields.

For each data-bearing plot, identify:

1. x-axis variable.
2. y-axis variable.
3. value or estimate variable.
4. grouping, colour, fill, facet, or panel variables.
5. uncertainty variables, such as lower and upper confidence or uncertainty interval fields.
6. label, ordering, or rank variables.
7. filters implied by the prompt, such as year, location, cause, measure, age, sex, disease, scenario, or risk.

For hierarchical filters not explicitly specified by the user, default to the largest available aggregate level and do not show substratifications unless the user asks for them.

Apply this rule only when the hierarchy is clear from the data source, category labels, or documented schema:

1. For location hierarchies such as `Global` versus regions, subregions, or countries, default to `Global` when available.
2. For sex hierarchies such as `Both`, `Male`, and `Female`, default to `Both` when available.
3. For age hierarchies such as `All ages`, age-standardised aggregate groups, and individual age groups, default to the largest aggregate level that matches the requested measure or graph type.
4. For other hierarchical filters, choose the largest aggregate parent category when it is uniquely identifiable.

Do not facet, colour, group, or panel by a lower-level substratification unless the user explicitly requests that substratification or the graph type requires it.

For non-hierarchical filters, or for hierarchical filters where the largest aggregate level is absent or ambiguous, apply the confidence rules below.

Use exact column names from the data source. Prefer exact prompt-to-column matches, documented aliases, and uniquely matching schema patterns. Do not invent variables. Create derived variables only when the prompt explicitly asks for them or when the derivation is deterministic from available fields, such as percentage change from start and end estimates.

Assign confidence separately for each required plot role:

1. **High confidence**: the prompt maps to one exact or near-exact column, the data structure supports that mapping, and no other plausible field competes for the same role. Proceed with figure generation as planned.
2. **Moderate confidence**: one field is the most reasonable match, but the match depends on abbreviation, common domain convention, partial wording, or inferred role from the graph type. Proceed with figure generation, then after generation output the assumption in this form:
   - `Variable assumption: <plot/panel role> was assumed to be <column_name> during generation.`
3. **Low confidence**: multiple weak matches exist, the requested variable is absent, the field names conflict with the prompt, or no reasonable matching variable exists in the data source. Stop before generation and ask a clarifying question. Include possible low-confidence matches, if any, and name the role that needs clarification.

For multi-panel figures, evaluate confidence for each panel and each required role. If any required axis, estimate, grouping, or interval variable is low confidence, stop before generation. If only moderate-confidence roles exist, continue and report all variable assumptions after generation.

Use graph type to guide role assignment:

1. Line graphs: x-axis is usually year or time; y-axis is estimate, rate, count, or percentage; colour or linetype is the series variable.
2. Dot plots and forest plots: y-axis is usually the row category; x-axis is the estimate; interval variables are lower and upper bounds.
3. Bar graphs: x-axis is the displayed category or year; y-axis is value, estimate, count, rate, or percentage; fill is the component variable for stacked or composition bars.
4. Percentage-change graphs: x-axis is percentage change or interval change; y-axis is the row category; start and end years are filters or derived-value inputs.
5. Tornado and age-sex pyramid plots: y-axis is age group; x-axis is burden, rate, or population value; sex defines the mirrored side; year is a panel or filter only when requested.
6. Choropleth maps: geography is the spatial join key; fill is the mapped estimate, rate, rank, or category; panels come from requested years, measures, causes, or outcomes.
7. Heatmaps and ranking tables: rows and columns are categorical dimensions; fill is the estimate, value, percentage, or rank encoded by the cells.



## Guideline Discovery

Read design guidance in this order:

1. Global guideline:
   - `references/figure_house_style_guidelines.md`
2. Core colour guideline:
   - `references/core-colour-guidelines.md`
3. Local guideline files in the active session directory.
4. Any other figure-guideline `.md` files created in that same active session directory.

Treat the active session directory as the session-local figure folder under:

`./fig-dhs-activesessions-dir`

If multiple local guideline files exist, synthesise them into one clear design target before writing code.

## Colour System Selection

Before writing plotting code, read `references/core-colour-guidelines.md` and select one colour system for the graph or figure.

Use this strict order:

1. User request, if present.
2. Graph-type encoding.
3. Semantic palette.
4. Study-context fallback.
5. General/Tableau fallback.

Apply graph-type encoding before semantic palettes when the graph type requires a specific colour logic, such as diverging sign colours, continuous gradients, stepped ordered scales, choropleth scale logic, or heatmap/ranking encodings.

Use semantic palettes when the user's variable labels sufficiently match disease, risk-factor, regional, SDI, decomposition, or sex/age-sex systems in `core-colour-guidelines.md`.

Use Tableau palettes only when selected by the core colour guideline, requested by the user, or needed because no graph-type or semantic palette applies.

Keep colour mappings stable across panels, legends, and related figures. Use named R vectors with explicit factor levels or scale `limits` for semantic mappings. Do not rely on unnamed vector order for disease, risk-factor, regional, SDI, decomposition, or sex mappings.

If any inline colour instruction in a house-style, local, or QA file conflicts with `references/core-colour-guidelines.md`, prioritise `core-colour-guidelines.md`.

## Output Convention

1. For new figures, create one figure-specific R script in the session project output directory's `r-code` folder.
2. For edit requests, update the existing figure-specific R script when it can be identified reliably.
3. If the existing figure script cannot be identified reliably in edit mode, stop and ask the user to point to the script or figure file to edit.
4. R scripts are never versioned. Keep one stable R script per figure and edit that script in place.
5. Use a descriptive filename derived from the figure content.
6. Export each rendered PNG into the next available session-level versioned output folder under the session project output directory:
   - `output-DDMMYYYY-v1`
   - `output-DDMMYYYY-v2`
   - `output-DDMMYYYY-v3`
7. A version folder should contain the complete current figure set for the session. When only some figures are updated, copy forward unchanged PNGs from the previous version folder before returning the new version.
8. When multiple figures are generated or edited together, all figures in that render round must share the same target version folder.
9. Do not create one version folder per figure.
10. Keep each output filename descriptive to the figure content.
11. Return the final PNG path or paths from the versioned output folder that passed visual QA.

Do not overwrite unrelated figure scripts unless the user explicitly asks for that.

## Workflow

1. Parse the figure brief.
2. Run first-use R dependency setup using `scripts/check_r_setup.R`. Install missing core packages with `scripts/install_r_dependencies.R --core` before rendering.
3. Confirm the user-specified input directory. If absent, ask for it before continuing.
4. Determine the session project output directory:
   - use the user-specified output directory if present
   - otherwise infer the project name and create `./fig-dhs-output-main-dir/<project-slug>`
5. For all figures in the same `/make-figure` chat session, reuse this same session output directory.
6. If multiple agents are involved, instruct all agents to use the same session output directory and coordinate version allocation before any rendering begins.
7. Create or confirm the session project output directory's `r-code` folder.
8. Create or confirm the active session directory:
   - `./fig-dhs-activesessions-dir/<project-output-basename>-session`
9. Determine the next session-level PNG output folder for the current date:
   - `output-DDMMYYYY-v1`, then `output-DDMMYYYY-v2`, and so on
10. If multiple figures are generated or edited together, assign one shared target version folder for that render round.
11. If this is an update after an existing version folder, prepare the next version folder by copying forward unchanged PNGs from the latest previous version folder.
12. Detect whether the request is:
   - a new figure request, or
   - an edit request using `/make-figure edit`
13. In edit mode, identify the existing figure assets to revise:
   - current R script
   - current output PNG
   - any attached or referenced PNG showing the current figure state
14. If edit mode is requested but the target figure cannot be identified from the request, session project output directory, or active session context, ask the user to specify which figure script or PNG should be edited.
15. Identify:
   - figure type
   - x-axis and y-axis variables
   - grouping variables
   - labels and titles
   - requested measures, units, or years
   - any user-specified design constraints
16. Read the reference image visually if present.
17. Read the applicable guideline `.md` files.
18. For a new figure, write the R script to match the brief and the guidelines.
19. For an edit request, modify the existing R script to implement the requested changes while preserving the established figure intent unless the user asks otherwise.
20. Use R with `ggplot2`; use `patchwork` for multi-panel layouts and `ggsave()` for PNG export unless the user explicitly requests otherwise.
21. Run a syntax parse check before execution:

```bash
Rscript -e "parse(file='path/to/script.R')"
```

22. Run the script.
23. Read the generated PNG visually in full.
24. Read and apply the visual QA checking agent protocol:
   - `references/checking-function.md`
25. Run one full QA round using:
   - the rendered PNG
   - the R script
   - the original figure prompt or edit request
   - `references/figure_house_style_guidelines.md`
   - `references/core-colour-guidelines.md`
   - any applicable local session guideline files
   - the reference image, if provided
26. The internal QA round must return `QA: PASS` or `QA: FAIL`.
27. If QA fails, list all QA failure reasons found in that round, ordered by the priority list in `references/checking-function.md`.
   - Do not stop at the first failure.
   - Do not end a QA round as soon as one issue is found.
   - Identify every visible or inferable QA failure that can reasonably be found from the PNG, prompt, script, guidelines, and reference image.
28. If QA fails, edit the same figure-specific R script using all failure reasons from that QA round, create the next available `output-DDMMYYYY-vN` folder, copy forward unchanged PNGs from the previous version folder, export the rerendered PNG into the new version folder, read the new PNG visually, and run QA again.
29. Repeat the render, QA, repair, and rerender cycle until QA passes.
   - Multiple QA cycles are permitted.
   - Never ship a final output if any QA point still fails.
30. After three failed QA rounds, if the fourth QA round still fails, pause normal repair and troubleshoot why QA is repeatedly failing.
   - Check whether the wrong plot object or output file is being edited.
   - Check whether `ggsave()` is exporting a different object from the one being fixed.
   - Check whether a later `theme()`, `scale_*()`, layout, or patchwork call overwrites the repair.
   - Check whether the output dimensions make the requested layout impossible.
   - Check whether the user prompt, data, house style, and reference image conflict.
   - Decide whether a structural redesign or user clarification is needed before continuing.
31. In edit mode, also confirm that the user-requested edits are actually visible in the final PNG before returning it.
32. Once QA passes, return:
   - the final PNG path or paths
   - the R script path
   - `QA: PASS after <N> QA round(s)`
   - a brief note if visual QA iterations were needed

Keep the full QA transcript internal unless the user asks to see it. The user-facing final output must still explicitly include the concise QA status line and number of QA rounds before passing.

## VISUAL QA STANDARD

Use `references/checking-function.md` as the visual QA checking agent protocol for every generated or edited figure.

The QA checking agent must:

1. Inspect the rendered PNG in full.
2. Compare the PNG against the prompt, data-variable decisions, `references/figure_house_style_guidelines.md`, `references/core-colour-guidelines.md`, local session guidelines, and reference image if provided.
3. Return a clear `QA: PASS` or `QA: FAIL`.
4. If QA fails, give an ordered list of all failure reasons found in that round.
5. Order failure reasons according to the priority list in `references/checking-function.md`.
6. Give R, `ggplot2`, `patchwork`, or `ggsave` repair instructions for the failed QA points.

The QA checking agent must not:

1. Stop after finding only the first QA failure.
2. Return a partial QA assessment when more failures are visible.
3. Treat a figure as complete while any QA point remains failed.
4. Use `any outdated FigMirror protocol file`.
5. Convert the workflow into matplotlib, Python, PIL, or old FigMirror L1/L2/L3 terminology.

If QA fails, update the figure using the QA reasons, rerender, and call the QA checking agent again. Repeat until QA passes. After three failed QA rounds, if the fourth round still fails, troubleshoot the repeated failure before making another normal repair pass.

## Output Behaviour

When the figure passes visual QA:

1. Return the PNG path or paths first.
2. Also report the script path or paths used.
3. Include `QA: PASS after <N> QA round(s)`.
4. State briefly whether one or more visual QA iterations were needed.
5. In edit mode, state briefly that the figure was revised from an existing script/output.

If the skill cannot proceed because the input directory is missing from current chat context, do not generate code. Ask the user to specify the input directory and rerun `/make-figure`.
