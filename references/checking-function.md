# Visual QA Checking Agent For make-figure

This file defines the mandatory visual QA checking agent used by the `make-figure` skill before any final figure output is returned to the user.

The agent checks the exported PNG, decides whether QA passed or failed, gives all visible and inferable failure reasons in priority order, and gives repair instructions suitable for R, `ggplot2`, `patchwork`, and `ggsave`. If QA fails, `make-figure` must update the figure and call this QA agent again. This repeat cycle continues until QA passes.

Use this file as a pre-output QA protocol, not as a plotting style guide on its own. The plot should already follow the user prompt, the data source, the `make-figure` skill, and the house style guidelines.

The core purpose is:

1. Prevent weak figures from being shipped after only a partial visual check.
2. Force every QA round to identify all visible failures, rather than stopping at the first failure.
3. Provide ordered repair instructions that can be applied in the next R code revision.
4. Permit repeated QA cycles until the figure passes.
5. Trigger troubleshooting after repeated failed QA cycles.

The intended workflow is house-style first and reference-image second. Reference images are used when provided, but they do not override the user prompt, verified data variables, or the house style guidelines.

## 1. Authority Order

When checking a figure, apply instructions in this order:

1. User prompt and explicit edit request.
2. Data source and variable-confidence decisions made before generation.
3. House style guidelines in `figure_house_style_guidelines.md`.
4. Core colour guidelines in `core-colour-guidelines.md`.
5. Local session guidelines in the active figure folder.
6. Reference image, if provided by the user.
7. This visual QA protocol.

If two rules conflict, preserve the higher-authority requirement and explain the trade-off in the QA result.

For colour-specific conflicts, `core-colour-guidelines.md` is the authority over inline colour wording in the house-style file, local files, or this QA protocol unless the user explicitly requested a different colour system.

## 2. Required Inputs

For every QA round, inspect:

1. The rendered PNG in full.
2. The R script that generated it.
3. The original figure prompt or edit request.
4. `figure_house_style_guidelines.md`.
5. `core-colour-guidelines.md`.
6. The relevant local session guideline sections, if present.
7. The reference image, if provided.
8. The previous QA failures, if this is not the first QA round.

The rendered PNG is the primary evidence for visual QA. Do not rely only on code inspection.

## 3. QA Output Format

Each QA round must return one of these:

```text
QA: PASS
Reasons: None.
```

or:

```text
QA: FAIL
Reasons:
1. [priority category] Specific failure visible in the PNG.
2. [priority category] Specific failure visible in the PNG.
Fixes:
1. Specific R/ggplot2 repair instruction.
2. Specific R/ggplot2 repair instruction.
```

If QA fails, give all visible and inferable reasons in that round. Do not stop at the first failure. The list must be exhaustive enough that the next edit can address all known issues together.

Order failure reasons by the priority list in Section 5.

## 4. QA Cycle Rule

The `make-figure` skill must run visual QA cyclically:

1. Render the PNG.
2. Run this QA check.
3. If QA passes, the figure may be returned.
4. If QA fails, edit the R script using all failure reasons and fixes from the QA result.
5. Rerun the script.
6. Inspect the new PNG.
7. Run QA again.
8. Repeat until QA passes.

Multiple QA cycles are permitted. Never ship a final figure if any QA point still fails.

After three failed QA rounds, if the fourth QA round still fails, troubleshoot why the same class of failure is recurring before another normal edit cycle. Check whether:

1. The R script is editing the wrong object or output path.
2. `ggsave()` is exporting a different plot than the one being fixed.
3. A theme, scale, layout, or patchwork setting is overwritten later in the script.
4. The output dimensions make the requested layout impossible.
5. The prompt, data, house style, and reference image contain conflicting requirements.
6. The figure needs a structural change rather than another spacing or theme tweak.
7. The failing issue requires explicit user clarification.

## 5. QA Failure Priority Order

Check the figure in this order. Report all failures found, but order them by these priorities.

### 5.1 Semantic Correctness

Fail QA if the figure does not show the requested graph type, variables, groups, filters, years, outcomes, labels, colours, or edit requested by the user.

Examples:

1. The wrong measure is plotted.
2. A requested panel is missing.
3. The edit request is not visible in the final PNG.
4. A grouping variable is mapped to the wrong colour or facet.
5. The figure uses a line graph when the prompt required bars, or vice versa.

Repair in R by checking the data filtering, variable mapping, `aes()`, faceting, `scale_*_manual()`, and plot assembly code.

### 5.2 Export Clipping And Canvas Boundary Failure

Fail QA if any content is cut off or touches the image boundary too closely.

Check for:

1. Cropped legends.
2. Cropped titles, subtitles, captions, labels, axis titles, or tick labels.
3. Text or marks touching the plot edge without deliberate design.
4. Long labels extending beyond the canvas.

Repair in R with `ggsave(width = ..., height = ..., dpi = ...)`, `theme(plot.margin = margin(...))`, legend placement changes, shorter labels, or adjusted `coord_cartesian(clip = "off")` when appropriate.

Bad-example reference:

`assets/bad-examples/cut-off-content.png`

### 5.3 Overlap And Collision

Fail QA if any text, legend, label, annotation, axis, panel, or mark collides with another element.

Check for:

1. Titles overlapping subtitles.
2. Subtitles overlapping marks.
3. Legends covering panels.
4. Labels colliding with bars, lines, points, or axes.
5. Tick labels colliding with neighbouring tick labels.
6. Panel labels colliding with panel titles.

Repair in R with `theme()` text margins, smaller text, label nudging, `geom_text(check_overlap = TRUE)` only when acceptable, `ggrepel` if available and suitable, legend repositioning, more output height, or more explicit patchwork layout.

Bad-example reference:

`assets/bad-examples/overlapping-items.png`

### 5.4 Variable Labels And Units

Fail QA if the plotted variables or units are not clear.

Missing variable labels are acceptable only when the variable is obvious from tick labels and context, such as an x-axis that is clearly calendar years. Missing y-axis labels are not acceptable when the axis or panel value represents a specific measure such as age-standardised DALYs, age-standardised mortality, incidence, prevalence, counts, percentages, or rates.

Check for:

1. Missing y-axis measure.
2. Missing units such as `%`, `per 100,000`, `DALYs`, `Deaths`, or `Number`.
3. Ambiguous panel titles where several measures could plausibly apply.
4. Repeated panels where row or column labels do not identify the measure.

Repair in R with `labs(x = ..., y = ...)`, shared row or column labels, subtitles, `patchwork::plot_annotation()`, or direct panel labels.

Bad-example reference:

`assets/bad-examples/no-variable-labels.png`

### 5.5 Line Continuity And Temporal Structure

Fail QA if a coherent time series is broken into disconnected line segments without an analytic reason.

Check for:

1. Separate historical and forecast lines that should read as one trajectory.
2. Repeated gaps within the same series when data are not actually missing.
3. Forecast styling that creates a visual break instead of a continuous trend.
4. Missing historical-forecast reference marker where the house style requires it.

Repair in R by keeping one grouped data frame per series, mapping forecast status to `linetype`, adding a dotted vertical reference line with `geom_vline()`, or using a forecast-region annotation without breaking the trajectory.

Bad-example reference:

`assets/bad-examples/discontinuous-line-graphs.png`

### 5.6 Hierarchical Spacing

Fail QA if spacing does not reflect the data hierarchy.

Hierarchical spacing means spacing is smaller between items or plots belonging to the same subgroup, and larger between subgroups or higher-level groups.

Check for:

1. Year pairs spaced as far apart as different parent groups.
2. Repeated panels within the same subgroup spaced as far apart as panels from different subgroups.
3. Disease, risk, age, location, or outcome blocks that are hard to read because all gaps are equal.
4. Legends whose grouped entries do not reflect the hierarchy of categories.

Repair in R with explicit y positions, ordered factors with spacer rows, `scale_y_discrete(expand = ...)`, `geom_blank()` spacers, separate patchwork blocks, `plot_spacer()`, `plot_layout(heights = ..., widths = ...)`, or `theme(panel.spacing = unit(...))`.

Bad-example reference:

`assets/bad-examples/no-hierarchical-spacing.png`

### 5.7 Compactness And Unused Space

Fail QA if the figure reads as loose, sparse, or notebook-like rather than publication-style.

Check for:

1. Excess empty margins.
2. Large unused export space.
3. Panels floating too far from one another.
4. Legends separated from the data without reason.
5. Per-point labels floating far from their marks.
6. Wide gaps inserted to avoid fixing label placement directly.

Repair in R with `plot.margin`, `panel.spacing`, `legend.box.spacing`, `legend.spacing.x`, `legend.spacing.y`, `legend.key.width`, `legend.key.height`, `patchwork::plot_layout()`, and tighter `ggsave()` dimensions.

Tight does not mean crowded. Keep enough space for labels, but remove decorative whitespace.

### 5.8 Per-Panel Aspect And Figure Aspect

Fail QA if panels look flat, squashed, or structurally unlike the intended graph type.

Check separately:

1. Whole-figure aspect ratio.
2. Per-panel data-region aspect ratio.

Most line plots should not look extremely wide and flat. Dense heatmaps may be near square. Horizontal bar charts may need taller panels. Maps need enough area to keep geography legible.

Repair in R by changing `ggsave(width = ..., height = ...)`, patchwork row or column weights, legend position, top and bottom margins, and panel spacing.

Do not force exact pixel dimensions from a reference image. Choose dimensions that preserve the data, labels, and intended comparison.

### 5.9 Alignment And Layout Balance

Fail QA if the composition is visually unbalanced or poorly aligned.

Check for:

1. Left-right imbalance.
2. Top-bottom imbalance.
3. Panel widths or heights that should match but do not.
4. Misaligned axis titles, panel titles, row labels, legends, or plotting regions.
5. Bars or legends pushed too far toward one edge without analytic reason.

Repair in R with fixed patchwork design strings, `plot_layout(widths = ..., heights = ...)`, shared guides, common axis labels, consistent plot margins, and aligned legend placement.

Bad-example reference:

`assets/bad-examples/unabalanced-spacing-l-r.png`

### 5.10 Hairlines, Axes, Gridlines, And Reference Lines

Fail QA if structural lines are either invisible or visually dominant.

Hairline elements include axis lines, tick marks, gridlines, separators, zero lines, forecast cut-off lines, and map borders.

Check for:

1. Gridlines present when the house style says no gridlines.
2. Zero or forecast reference lines that are too dark, too thick, or too pale to function.
3. Heavy black panel boxes or axis boxes.
4. Spines or borders competing with data.
5. Very pale separators that disappear at normal viewing size.

Repair in R with `theme(panel.grid = element_blank())`, `axis.line`, `axis.ticks`, `geom_hline()`, `geom_vline()`, `linewidth`, `linetype = "dotted"`, and house-style greys such as `#E6E6E6`, `#EEEEEE`, or `#C8C8C8` when stronger contrast is needed.

### 5.11 Legends And Colour Mapping

Fail QA if legends are unclear, duplicated, misordered, too large, or inconsistent with the data.

Check for:

1. Boxed legends when the house style requires unboxed legends.
2. Legend titles used for non-hierarchical variables.
3. Hierarchical legend titles that do not represent parent variable labels.
4. Missing hierarchical legend titles only when their absence makes the legend ambiguous and there is enough space to include them.
5. Legend order not matching stack order or analytic priority.
6. Legend keys too large, too small, or inconsistent.
7. Legend text differs in size across legend items.
8. Legend boxes are smaller than one line of the corresponding legend text.
9. Legend boxes are more than 20 percent taller than one line of the corresponding legend text.
10. Spacing between a coloured box and its corresponding label is more than one third of the legend box height.
11. Spacing between a coloured box and its corresponding label is equal to or larger than the spacing between two legend items.
12. Excessively broad spacing between legend elements.
13. A legend stretched across the available figure space by broad internal spacing rather than remaining compact.
14. Colour meanings changing across panels.
15. Legends placed inside small data panels.
16. Missing legend when colour or fill cannot otherwise be interpreted.

Repair in R with `guides()`, `guide_legend()`, `theme(legend.position = ...)`, `theme(legend.title = element_blank())` for non-hierarchical legends, compact hierarchical legend titles where useful, `legend.key.width`, `legend.key.height`, `legend.spacing`, `legend.spacing.x`, `legend.spacing.y`, stable named vectors, and explicit `limits` or factor levels in `scale_colour_manual()` or `scale_fill_manual()`.

Publication quality legends should be internally compact. Generous empty space around the legend section is acceptable, including a small tightly spaced legend sitting in a wide bottom strip. Excessively broad spacing between legend items, boxes, and labels must fail QA.

Bad-example reference:

`assets/bad-examples/legend-uneven.png`

Bad-example reference:

`assets/bad-examples/legend-crowded.png`

### 5.12 Typography And Text Hierarchy

Fail QA if text does not follow the house style or cannot be read comfortably.

Check for:

1. Non-Roboto fonts.
2. Uppercase panel labels when small lowercase labels are required.
3. Text too small to read.
4. Text too large for its container.
5. Weak hierarchy between title, subtitle, panel label, axis title, tick label, and legend label.
6. Font sizing that is contrary to hierarchy. Text lower in the hierarchy must not be larger than text higher in the hierarchy.
7. Main figure title, graph subtitle, axis labels, axis ticks, legend labels, and annotations should decrease in size as they move down the visual hierarchy.
8. Axis-side labels such as `Male` and `Female` must not be larger than the graph label or graph title they sit under, such as `2025`.
9. Unnecessary subtitles or long non-numerical explanatory text embedded inside the figure.
10. Subtitles whose only purpose is to explain design choices, filters, or graph structure.
11. Explanatory text such as `Bar colour encodes central percentage-change magnitude using global figure-wide limits; grey whiskers show source 95% uncertainty intervals.`
12. Filter text such as `Filters: sex = Both, age = Age-standardized, metric = Rate, cause = CKLM.`
13. Overly long labels that should be shortened or wrapped.

Repair in R with `theme(text = element_text(family = "Roboto"))`, `element_text(size = ..., face = ...)`, hierarchy-specific text sizes, concise labels, `stringr::str_wrap()`, shared labels instead of repeated labels, and removal of explanatory subtitles that belong in the manuscript text or figure footnote rather than inside the figure design.

Bad-example reference:

`assets/bad-examples/no-hierarchical-text.png`

Bad-example reference:

`assets/bad-examples/unnecessary-subtitles.png`

### 5.13 Colour, Contrast, And Palette Suitability

Fail QA if colours reduce interpretability or violate the house style.

Check for:

1. Disease, risk, region, SDI, decomposition, or diverging-change colours not following the house style when those semantics apply.
2. Too many colours for the number of categories.
3. Low contrast between adjacent stacked segments.
4. Similar colours assigned to semantically distinct high-priority groups.
5. Rainbow or decorative palettes where the house style rejects them.
6. Sequential gradients used for unordered categories.
7. Manual unordered scales used when the colour aesthetic encodes continuous numeric values, ordered bins, quantiles, numeric ranks, or stepped map classes.
8. Unnamed semantic palette vectors that depend on factor order.

Repair in R with `core-colour-guidelines.md`, named semantic palette vectors, explicit factor levels or scale limits, `scale_colour_manual()`, `scale_fill_manual()`, `scale_colour_gradientn()`, `scale_fill_gradientn()`, `scale_colour_stepsn()`, or `scale_fill_stepsn()` as appropriate to the graph type and variable scale.

### 5.14 Reference Image Fidelity, If A Reference Is Provided

Fail QA if the user supplied a reference image and the output ignores visible reference structure without reason.

Check for:

1. Different layout density.
2. Different panel arrangement.
3. Different legend placement logic.
4. Different line, bar, ribbon, or label treatment.
5. Different colour assignment logic.
6. Different spacing hierarchy.

Use the reference image as evidence only when it does not conflict with the user prompt, data, or house style. If the output intentionally deviates from the reference for a higher-authority reason, state that reason in the QA result.

### 5.15 Export Quality And Reproducibility

Fail QA if the exported file is not suitable for use.

Check for:

1. PNG not created.
2. Wrong output file path.
3. Output overwritten unexpectedly.
4. Low resolution or blurry text.
5. Export dimensions inconsistent with the requested figure.
6. R script cannot be parsed or rerun.

Repair by checking `Rscript -e "parse(file='path/to/script.R')"`, rerunning the R script, and using `ggsave()` with explicit path, width, height, units, and dpi.

## 6. Repair Guidance For R And ggplot2

Use these repair tools before inventing custom drawing systems:

1. Layout: `patchwork::wrap_plots()`, `plot_layout()`, design strings, `plot_spacer()`, `plot_annotation()`.
2. Margins: `theme(plot.margin = margin(t, r, b, l))`.
3. Panel spacing: `theme(panel.spacing = unit(..., "pt"))`, `panel.spacing.x`, `panel.spacing.y`.
4. Titles: `labs(title = ..., subtitle = ..., x = ..., y = ...)`, `element_text(margin = margin(...))`.
5. Labels: `geom_text()`, `annotate()`, `hjust`, `vjust`, `nudge_x`, `nudge_y`, `stringr::str_wrap()`.
6. Axes: `scale_x_continuous(expand = ...)`, `scale_y_discrete(expand = ...)`, `coord_cartesian(clip = "off")`.
7. Legends: `guides()`, `guide_legend()`, `theme(legend.position = ...)`, `legend.key.width`, `legend.key.height`, `legend.box.spacing`.
8. Colours: `scale_colour_manual()`, `scale_fill_manual()`, `scale_colour_gradientn()`, `scale_fill_gradientn()`, `scale_colour_stepsn()`, `scale_fill_stepsn()`, named house-style palette vectors, explicit factor levels, and explicit scale limits.
9. Reference lines: `geom_vline()`, `geom_hline()`, dotted linetypes, faint greys.
10. Export: `ggsave(filename = ..., plot = ..., width = ..., height = ..., units = "in", dpi = ...)`.

Do not convert the figure to matplotlib syntax. Do not use old reference-mirroring layer terminology. Do not require Python image-processing dependencies. Pixel-level measurement may be used only as optional support; visual inspection of the rendered PNG is the required QA evidence.

## 7. Fourth-Round Troubleshooting Template

If QA fails on the fourth round, write a short troubleshooting note before editing again:

```text
Repeated QA failure troubleshooting:
1. Repeated failure class:
2. Why prior edits did not fix it:
3. Suspected root cause:
4. Structural change now needed:
5. Whether user clarification is required:
```

Then make the smallest structural change likely to fix the repeated failure, rerender, and run QA again.
