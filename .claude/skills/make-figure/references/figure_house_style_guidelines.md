# Figure House Style Guidelines

## 1. Purpose

This document summarises the visual house style inferred from the existing figure set in the source figure set used to derive this house style.

Use it as a handoff specification for an LLM, analyst, or plotting script that needs to recreate figures in the same style.

The rules below prioritise the user-selected canonical style over incidental variation in the source figures.

## 2. Global Rules

1. Use `Roboto` only.
   - Do not use Arial, Helvetica, Tableau Book, Times New Roman, Calibri, or default plotting fonts.
   - Use Roboto Regular for most text.
   - Use Roboto Medium for axis titles, legend headers, and key labels.
   - Use Roboto Bold only for caption prefixes such as `Figure 1:` or rare section headers.

2. Use a white background.
   - Figure background: `#FFFFFF`.
   - Plot panel background: `#FFFFFF`.
   - Avoid shaded plot panels unless the figure is a heatmap or table.

3. Use no grid lines.
   - Do not use default horizontal or vertical chart grids.
   - Reserve very faint grey lines only for reference lines, separators, or forecast boundaries.
   - Acceptable reference-line greys: `#E6E6E6`, `#EEEEEE`, and, when contrast is needed, `#C8C8C8`.

4. Use dotted reference lines.
   - Forecast boundary lines should be vertical, dotted, and faint grey.
   - Zero reference lines in diverging plots should be dotted and faint grey.
   - Reference lines should guide interpretation without becoming a visual feature.

5. Use small lowercase panel labels.
   - Format: `a)`, `b)`, `c)`, `d)`.
   - Place labels at the upper-left of each panel.
   - Use Roboto Regular or Medium.
   - Use dark grey `#2F2F2F`.

6. Use restrained analytic styling.
   - No decorative backgrounds.
   - No heavy boxes around legends.
   - No unnecessary point markers on line charts.
   - No visible basemap attribution on maps when possible.

7. Use fixed large typography across all graph types.
   - Use font size `38 pt` to `42 pt` for all general graph text unless a more specific override is requested.
   - Use font size `52 px` to `62 px` for all titles unless a more specific override is requested.
   - Titles must be bolded.

8. Use 4 px line thickness for all axes and 30 px tick length.
   - Apply this to x-axes, y-axes, and visible tick marks.
   - Keep axis and tick colours restrained, following the existing grey rules.
   - Set visible axis ticks to `30 px` long.
   - Set x-axis and y-axis titles `20 px` farther from the nearest axis tick.
   - Set x-axis and y-axis numerical tick labels `30 px` closer to the axis line than the graph default.

9. Use 5 px line thickness for all line graphs.
   - Apply this to observed, projected, solid, and dotted line segments.
   - Do not add point markers unless specifically requested.

9a. Always include a reference line at the cut-off between historical and projected data.
    - Style the reference line according to the graph-specific reference-line rules.
    - Set reference-line thickness to `4 px`.

10. Always include confidence intervals for line graphs.
    - Use the existing lower and upper bound columns unless otherwise specified.
    - Use translucent ribbons as the default expression of uncertainty.

11. Always include confidence intervals for nonstacked bar graphs.
    - Use the existing lower and upper bound columns unless otherwise specified.
    - Use whiskers or equivalent interval marks.

12. Never include confidence intervals for stacked bar graphs.
    - Do not overlay whiskers, error bars, ribbons, or interval outlines on stacked bars.
    - Do not add figure disclaimers about omitted stacked-bar intervals.
    - Arrange stacked components by their size in the first year represented by the graph.
    - Place the largest first-year component at the bottom and the smallest first-year component at the top.
    - Keep this component order fixed across all stacked bars in the graph.

13. Export individual graph PNGs at fixed dimensions.
    - Each individual graph panel should export at `3090 px` wide by `1890 px` high.
    - If one figure contains two vertically stacked graphs, export the full figure at `3090 px` wide by `3780 px` high.
    - Scale multi-panel figures proportionally by panel count unless otherwise specified.
    - Allow dynamic override with the `FIGURE_SIZE` export-size setting:
      - `FIGURE_SIZE=standard` exports at `3090 px` wide by `1890 px` high.
      - `FIGURE_SIZE=double` exports at `3090 px` wide by `3780 px` high.
      - If no export-size setting is specified, use the default panel-count rule above.

14. Use compact relative legend sizing and spacing.
    - Legend text must be the same size across all legend items, strictly.
    - A coloured legend box should be at least the same height as one line of its corresponding legend text, and at most 20 percent taller than that single line.
    - Size legend boxes against a single text line, not against a wrapped or double-line label.
    - Place each coloured legend box to the left of its label text.
    - Left-align legend label text.
    - Hierarchical spacing is the main principle.
    - Spacing between a coloured box and its corresponding label must be at most one third of the legend box height.
    - Spacing between a coloured box and its corresponding label must be smaller than the spacing between two legend items, whether the legend is arranged horizontally or vertically.
    - Publication quality legends are generally tight. Default legend spacing is often too broad and should be tightened.
    - Spacing around the whole legend section may be generous, but the legend itself should remain compact.
    - A small, tightly spaced legend occupying a wide bottom strip is acceptable and often desirable.
    - Legend titles are allowed when the legend variable is hierarchical and the titles represent parent variable labels.
    - Hierarchical legend titles are allowed but not required; decide based on available space and whether they improve interpretation.
    - Do not use legend titles for non-hierarchical legends.

15. Align graph headers with the left edge of the y-axis title.
    - Apply this to panel headers and subplot titles.

16. Do not include methodological disclaimers in figure exports.
    - Keep captions factual and brief, or omit them when they do not add analytic information.

## 3. Typography

### 3.1 Font Family

Use `Roboto` throughout.

### 3.2 Font Weights

1. Main title: Roboto Regular or Medium.
2. Panel label: Roboto Regular or Medium.
3. Panel title: Roboto Regular.
4. Axis title: Roboto Medium.
5. Tick labels: Roboto Regular.
6. Legend title: Roboto Medium.
7. Legend labels: Roboto Regular.
8. Caption prefix, if included: Roboto Bold.
9. Caption body, if included: Roboto Regular.

### 3.3 Font Sizes

Use the large-format house style ranges as the default typography system.

Default typography:

1. General graph text: `38 pt` to `42 pt`.
2. Titles: `52 px` to `62 px`.
3. Use more specific overrides only when the figure type or layout clearly requires them.

For a standard single-panel figure:

1. Main title: `52 px` to `62 px`.
2. Panel title: `52 px` to `62 px`.
3. Panel label: `38 pt` to `42 pt`.
4. Axis title: `38 pt` to `42 pt`.
5. Tick labels: `38 pt` to `42 pt`.
6. Legend title: `38 pt` to `42 pt`.
7. Legend labels: `38 pt` to `42 pt`.
8. Caption: `38 pt` to `42 pt`.

For dense small multiples:

1. Keep the same default ranges where space allows.
2. Reduce text size only when needed to preserve legibility and panel alignment.
3. Use one consistent reduced size scale across comparable panels within the same figure.
4. Treat any reduced size as a layout-specific exception, not as the default house style.

For large publication figures with prominent panel headings:

1. Figure-level title: `52 px` to `62 px`.
2. Panel label: `38 pt` to `42 pt`.
3. Axis title: `38 pt` to `42 pt`.
4. Tick labels: `38 pt` to `42 pt`.
5. Increase beyond these ranges only if a specific figure brief explicitly requests a larger display treatment.

### 3.4 Text Colours

1. Main titles and panel titles: `#2F2F2F`.
2. Axis titles: `#2F2F2F`.
3. Tick labels: `#666666` to `#7A7A7A`.
4. Legend text: `#333333`.
5. Captions: `#000000`.
6. Muted annotations: `#7A7A7A`.

## 4. Colour Guidance

All graph colour decisions are governed by:

`core-colour-guidelines.md`

Read that file before choosing colours for any figure.

Use the strict order defined in `core-colour-guidelines.md`:

1. User request, if present.
2. Graph-type encoding.
3. Semantic palette.
4. Study-context fallback.
5. General/Tableau fallback.

If any inline colour guidance in this file conflicts with `core-colour-guidelines.md`, prioritise `core-colour-guidelines.md`.

Keep colour meanings stable across panels and related figures.

## 5. Figure-Type Rules

### 5.1 Line Graphs And Time-Series Plots

Use for temporal trends, burden forecasts, age-standardised rates, crude rates, projected outcomes, and paired disease trends.

#### 5.1.1 Core Style

1. Use Roboto only.
2. Use a white figure background and a white plot background.
3. Use no grid lines.
4. Use no point markers on time-series lines.
5. Use restrained axis lines, preferably absent or very light grey.
6. Keep the data region large. Avoid unused export space.
7. Use small lowercase panel labels, for example `a)`, `b)`, `c)`.
8. Use dark grey text, with panel labels and titles in `#2F2F2F`.

#### 5.1.2 Historical And Forecast Treatment

1. Historical data should be a solid line.
2. Forecast data should be a dotted line in the same colour as the historical line.
3. Historical and forecast segments should join cleanly at the boundary year.
4. Add one vertical dotted reference line at the historical-forecast boundary.
5. Use `#E6E6E6` to `#EEEEEE` for the boundary line.
6. Use `#C8C8C8` only if the line is otherwise too faint after export.
7. Reference-line width should be 0.6 to 1.0 pt.
8. Reference lines should sit behind the data.
9. Do not add extra vertical or horizontal reference lines unless they mark a necessary analytic boundary.

#### 5.1.3 Lines And Colours

1. Use red `#C01820` and blue `#4E79A7` for the overall or most important trends.
2. Use red for the focal burden, focal disease, or first headline group.
3. Use blue for the comparator, second disease group, or second headline group.
4. Use grey `#B0B8B8` when the comparator is contextual, such as a global background series.
5. Use the regional, SDI, disease, or risk-factor palette when the line colours encode those categories.
6. Main line width should be 1.5 to 2.5 pt.
7. Secondary line width in dense plots should be 1.0 to 1.5 pt.
8. Keep all series unmarked.
9. Avoid adding markers at observed years.

#### 5.1.4 Confidence Intervals

1. Use translucent ribbons as the default expression of uncertainty.
2. Use the same hue as the central line.
3. Historical ribbon opacity should be 12 to 18 percent.
4. Forecast ribbon opacity should be 18 to 28 percent.
5. Wide or overlapping ribbons should be reduced to 10 to 16 percent.
6. Do not outline ribbons.
7. Do not use hatch marks.
8. Do not use separate upper and lower bound lines unless a journal requires them.
9. Do not use error bars for time-series confidence intervals.
10. Keep the central estimate visually dominant over the ribbon.

#### 5.1.5 Axes

1. Use short axis titles.
2. Put units in the axis title or panel title, for example `per 100,000`, `%`, `DALYs`, or `Deaths`.
3. Use `K`, `M`, or `B` suffixes for large values.
4. Use muted tick labels, `#666666` to `#7A7A7A`.
5. Use Roboto Medium for axis titles.
6. Use Roboto Regular for tick labels.
7. Reduce tick density before reducing tick labels below 7 pt.
8. Avoid heavy black spines.

#### 5.1.6 Legends

1. Use one shared legend when possible.
2. Place the legend outside the plotting area, preferably top-right, right side, or below the panels.
3. Use an unboxed legend.
4. Do not use legend titles unless the legend variable is hierarchical and the title represents a parent variable label.
5. Use Roboto Regular for legend labels.
6. Use short line samples for solid versus dotted status.
7. Use square swatches for categorical colour identity.
8. Order legend entries by analytical priority.
9. Do not place legends over ribbons or lines.

#### 5.1.7 Small Multiples

1. Use equal panel dimensions.
2. Align plot areas, y-axis titles, panel titles, legends, and forecast boundary lines.
3. Use shared axes where the metric and range are comparable.
4. Use separate axes only when the measures or units differ.
5. Use concise panel titles centred or left-aligned consistently.
6. Keep panel spacing consistent.
7. Use one shared legend for the full figure.
8. Show ribbons only for selected headline series if many ribbons overlap.
9. Do not add panel borders unless separation is otherwise unclear.

#### 5.1.8 Text Defaults For Line Graphs

1. Panel label: Roboto Regular or Medium, `38 pt` to `42 pt` by default.
2. Panel title: Roboto Regular, `52 px` to `62 px` by default.
3. Axis title: Roboto Medium, `38 pt` to `42 pt` by default.
4. Tick label: Roboto Regular, `38 pt` to `42 pt` by default.
5. Legend title: Roboto Medium, `38 pt` to `42 pt` by default.
6. Legend label: Roboto Regular, `38 pt` to `42 pt` by default.
7. Dense small multiples may use a smaller consistent scale only when required by space constraints.

#### 5.1.9 Avoid

1. Do not use non-Roboto fonts.
2. Do not use uppercase panel labels.
3. Do not use grid lines.
4. Do not use point markers on time-series lines.
5. Do not use boxed legends.
6. Do not use separate colours for confidence intervals.
7. Do not use heavy axis boxes.
8. Do not let ribbons obscure the central lines.

### 5.2 Dot Plots And Forest Plots

Use for estimates with confidence intervals across diseases, regions, risks, or subgroups.

1. Use a small filled circle or square for the point estimate.
2. Use the category colour for the point estimate.
3. Use grey horizontal CI whiskers.
4. Use no caps on whiskers.
5. Use a dotted zero or null reference line when relevant.
6. Use reference-line colour `#E6E6E6` to `#EEEEEE`.
7. Use no grid lines.
8. Keep row labels left-aligned.
9. Use Roboto Regular for row labels.
10. Use Roboto Medium for group headers only.
11. Use alternating row shading only if the plot is very dense and tracking is otherwise difficult.

Recommended values:

1. Point size: 2.5 to 4.0 pt.
2. CI whisker width: 0.6 to 1.0 pt.
3. CI colour: `#B0B0B0`.
4. Null reference: `#E6E6E6`, dotted.

### 5.3 General Bar Graphs

Use for non-mirrored bars showing burden, rates, composition, ranked comparisons, grouped comparisons, age-specific distributions, or decomposition of change. Use the tornado rules in section 5.5 for age-and-sex mirrored horizontal bars.

#### 5.3.1 Shared Bar-Graph Rules

1. Use Roboto only.
2. Use a white figure background and a white plot background.
3. Use flat rectangular bars with square ends.
4. Use no grid lines.
5. Use faint dotted grey reference lines only when needed, such as zero, a forecast boundary, or a threshold.
6. Start quantitative axes at zero unless the figure is a positive-negative decomposition.
7. Use minimal spines with muted grey tick labels.
8. Put units in the axis title.
9. Use `K`, `M`, or `B` suffixes for large values.
10. Use small lowercase panel labels.
11. Use short analytical panel titles.
12. Use one shared legend unless different panels use different encodings.

#### 5.3.2 Orientation

1. Use horizontal bars for long labels, rankings, and more than 8 categories.
2. Use vertical bars for naturally ordered x-axes, such as year, age group, or forecast interval.
3. Use horizontal stacked bars for country, region, SDI, risk-factor, and disease rankings.
4. Use vertical stacked bars for time series, age-specific burden, and compact grouped comparisons.
5. Use facets instead of side-by-side stacked bars when there are many segments or groups.
6. Do not rotate long category labels. Switch to horizontal bars.
7. Rotated x-axis labels are acceptable for short age bands when needed.

#### 5.3.3 Bar Spacing And Borders

1. Use 60 to 80 percent of the category slot for vertical bar width.
2. Use 60 to 75 percent of the row slot for horizontal bar height.
3. Keep visible white space between bars.
4. Increase spacing between groups.
5. Keep bar widths consistent across comparable panels.
6. Prefer no borders.
7. Separate stacked segments through colour contrast.
8. If separation is unclear, use a thin white separator of 0.2 to 0.4 pt.
9. Do not use heavy black outlines.
10. Do not use rounded bars, shadows, gradients, hatching, or textures.

#### 5.3.4 Stacked Bar Graphs

1. Use a constant stack order across panels.
2. Put the main or largest conceptual component at the baseline.
3. Put small residual categories at the outer end.
4. Sort ranking bars by total.
5. Preserve chronological order for time and natural order for age.
6. Use the disease, risk-factor, regional, or SDI palette according to the analysis.
7. Reserve red and blue for headline comparisons or focal disease groups.
8. Use direct labels only when segments are large enough to read.
9. Do not label every segment in dense figures.
10. Use a compact unboxed legend with square swatches.
11. Match legend order to stack order.
12. Place the legend on the right for horizontal rankings and below for multi-panel or wide plots.

#### 5.3.5 Decomposition Bar Graphs

1. Use horizontal stacked bars.
2. Anchor bars at zero.
3. Place negative components to the left and positive components to the right.
4. Use a faint dotted zero line if bars cross zero.
5. Use the decomposition palette in `core-colour-guidelines.md`.
6. Keep the risk exposure, population growth, population ageing, and mean marker mappings stable across panels.
7. Keep bars borderless.
8. Use left-aligned labels.
9. Use pale grey group header strips only when hierarchy is needed.
10. Header strips should be `#F2F2F2` to `#F5F5F5`.
11. Indent subcategories under group headers.
12. Show the mean as a small dark grey square on the same x-axis.
13. Centre the mean square vertically on the row.
14. Make the mean square 15 to 25 percent of the bar height.
15. Include `Mean` as a legend item before decomposition components.

#### 5.3.6 Grouped Or Faceted Bar Graphs

1. Use grouped bars only for 2 to 4 groups per category.
2. Use facets when there are many x categories, stack segments, or more than 4 groups.
3. Use vertical panels with the same x and y scales for sex-stratified age-specific stacked bars.
4. Keep panel heights equal.
5. Share axes where possible.
6. Make different scales explicit.
7. Keep grouped bars close within each category.
8. Use larger gaps between categories.
9. Use one shared legend.
10. Do not place legends inside small panels.

#### 5.3.7 Text Defaults For Bar Graphs

1. Panel label: Roboto Regular or Medium, small lowercase.
2. Panel title: Roboto Regular.
3. Axis title: Roboto Medium.
4. Tick labels: Roboto Regular.
5. Legend title: Roboto Medium.
6. Legend labels: Roboto Regular.
7. Row labels in horizontal bars: Roboto Regular, with Roboto Medium for group headers only.

#### 5.3.8 Avoid

1. Do not use non-Roboto fonts.
2. Do not use uppercase panel labels.
3. Do not use grid lines.
4. Do not use heavy borders.
5. Do not use boxed legends.
6. Do not use unreadably compressed rankings.
7. Do not put text inside very small stacked segments.
8. Do not use percentage-change blue-orange colours for ordinary composition unless percentage-change magnitude and direction are being encoded.

### 5.4 Percentage-Change Graphs

Use for diverging horizontal percentage-change plots, lollipop or CI-bar change plots, paired disease-change panels, and rank-change small multiples.

#### 5.4.1 Common Rules

1. Use Roboto only.
2. Use small lowercase panel labels.
3. Use a white background.
4. Use no grid lines.
5. Use faint dotted grey reference lines only.
6. Keep the zero or null line clear but visually secondary.
7. Keep bars, points, and connectors flat, clean, and borderless.

#### 5.4.2 Zero Line

1. Anchor percentage-change plots at zero.
2. Draw the zero line as a vertical dotted line.
3. Use `#E6E6E6` to `#EEEEEE`, or `#C8C8C8` if contrast is needed.
4. Use 0.6 to 1.0 pt line width.
5. Place the zero line behind bars and CI whiskers.
6. Do not use a heavy black zero line.
7. Do not add additional vertical grid lines.

#### 5.4.3 Colour Magnitude And Direction

1. Default percentage-change figures to a continuous magnitude-based diverging gradient.
2. Use negative blue `#3078E0` as the terminal colour for the global most negative percentage-change value in the complete figure.
3. Use positive orange `#F08000` as the terminal colour for the global most positive percentage-change value in the complete figure.
4. Compute gradient limits once across the full assembled figure, including all panels, facets, and subplots.
5. Do not compute separate colour-gradient limits for individual graphs inside the same figure unless the user explicitly requests independent panel scaling.
6. Use a neutral near-white midpoint at zero, for example `#F7F7F7`.
7. Use muted negative `#98B0E0` and muted positive `#E0B888` only as optional intermediate stops in a multi-stop gradient.
8. For paired disease or cause comparisons, use disease colour only when disease identity is the primary colour encoding; otherwise keep percentage-change magnitude as the colour encoding.
9. For headline CVD versus cancer comparisons, use the priority red-blue system in `core-colour-guidelines.md` only when the figure is not primarily a percentage-change magnitude figure.
10. When colour encodes disease or cause categories, use the disease palette in `core-colour-guidelines.md`.
11. Use one colour logic per figure.

#### 5.4.4 Bars, Points, And CI Whiskers

1. Use horizontal bars from zero to the point estimate.
2. Make bars flat and borderless.
3. Use moderate bar thickness, approximately 55 to 70 percent of row height.
4. Reduce bar thickness before reducing text below legible size in dense panels.
5. Draw CI whiskers as horizontal grey lines over the bar centre.
6. Use CI whisker colour `#B0B0B0`.
7. Use CI whisker width 0.6 to 1.0 pt.
8. Do not use end caps on CI whiskers.
9. Do not outline CI whiskers in black.
10. In point-and-whisker variants, use a small filled circle or square for the estimate, 2.5 to 4.0 pt.
11. If a CI crosses zero, colour the bar by the central estimate.

#### 5.4.5 Row Labels

1. Keep row labels left-aligned.
2. Use Roboto Regular for row labels.
3. Use Roboto Medium only for group headers.
4. Wrap long disease names at natural spaces.
5. Keep wrapped labels to two lines where possible.
6. Show row labels only on the first facet column when all columns share the same row order.
7. Repeat row labels for separate row blocks when block membership changes.
8. Use very pale alternating row shading only when the plot is very dense.

#### 5.4.6 Facets And Small Multiples

1. Use equal panel widths within each comparable block.
2. Align zero lines across all facets in the same block.
3. Centre short facet titles above each panel.
4. Use faint grey separators between facet columns only when needed.
5. Use one shared x-axis title for a full block.
6. Repeat x-axis tick labels only at the bottom of each block unless separate row blocks need their own ticks.
7. Keep facet gutters consistent.
8. Avoid full panel boxes.
9. Avoid shaded facet headers.
10. Use one unboxed legend outside the data area.

#### 5.4.7 Axis Scales

1. Use shared x-axis limits within each analytically comparable block.
2. Use separate scales for different measures.
3. Include zero in every percentage-change axis.
4. Use simple tick intervals, commonly 50 or 100 percentage points.
5. Put `%` in the axis title, not every tick label.
6. Add enough axis padding for CI whiskers.
7. Avoid free scales across adjacent facets when the intended comparison is magnitude.

#### 5.4.8 Sorting

1. Put overall or total rows first.
2. Sort remaining rows by the central estimate in the headline column when the figure is about magnitude.
3. Use a fixed conceptual order for SDI groups, health-system groups, and GBD super-regions.
4. Keep the same row order across facets within a panel.
5. For rank-change plots, rank 1 should be at the top and larger rank numbers should proceed downward.

#### 5.4.9 Rank-Change Small Multiples

1. Use chronological columns, for example 1990, 2021, and 2050.
2. Use equal-width rank boxes.
3. Put the rank number first inside each box.
4. Colour rank boxes by risk-factor family or analytical category.
5. Use thin connectors between the same item across time points.
6. Draw connectors behind rank boxes.
7. Use connector colour from the same category family.
8. Keep connectors subtle, approximately 40 to 70 percent opacity.
9. Use an unboxed legend on the right.
10. Limit rank panels to the top 10 to 12 items unless the output size is increased.

#### 5.4.10 Uncertainty

1. Show uncertainty with grey horizontal CI whiskers.
2. Do not use ribbons for percentage-change bars.
3. Do not use caps, arrows, or significance stars unless specifically required.
4. State the interval definition in the caption or legend, for example 95 percent UI.
5. If uncertainty is omitted, keep the visual simple and avoid implying precision through excess labels.

#### 5.4.11 Text Defaults For Percentage-Change Graphs

1. Panel label: Roboto Regular or Medium, small lowercase.
2. Facet title: Roboto Regular, `52 px` to `62 px` by default, with smaller consistent overrides allowed only in dense plots when space requires them.
3. Axis title: Roboto Medium.
4. Tick label: Roboto Regular, `38 pt` to `42 pt` by default, with smaller consistent overrides allowed only in dense plots when space requires them.
5. Row label: Roboto Regular.
6. Group header: Roboto Medium.
7. Legend title: Roboto Medium.
8. Legend label: Roboto Regular.

#### 5.4.12 Avoid

1. Do not use non-Roboto fonts.
2. Do not use uppercase panel labels.
3. Do not use grid lines.
4. Do not use heavy black spines.
5. Do not use black CI whiskers.
6. Do not use capped error bars.
7. Do not mix percentage-change magnitude colours and disease colours in the same panel.
8. Do not place numeric labels on every bar in dense small multiples.
9. Do not place legends inside the data area.

### 5.5 Tornado And Age-Sex Pyramid Plots

Use for age-and-sex stratified mirrored horizontal bar charts, including population pyramids, age-specific burden pyramids, and age-sex composition plots.

#### 5.5.1 Core Geometry

1. Use mirrored horizontal bars.
2. Use male on the left and female on the right.
3. Keep sex orientation consistent across all panels and figures.
4. Use negative values only for construction; axis tick labels should show absolute positive values on both sides.
5. Use a central zero anchor.
6. Use a faint dotted vertical zero line in `#E6E6E6` to `#EEEEEE` at 0.6 to 0.8 pt when the centre is not occupied by age labels.
7. Leave the centre open when age labels occupy the central gutter.
8. Use identical x-limits on both sides when comparing sex within a panel.
9. Use identical x-limits across panels for the same metric and unit.
10. Use panel-specific x-limits only for different metrics, such as DALYs and deaths.
11. Do not show negative tick labels.
12. Use `K`, `M`, or `B` suffixes.

#### 5.5.2 Age Labels

1. Put age groups in the central gutter.
2. Use one shared age label column.
3. Order older ages at the top and younger ages at the bottom.
4. Use labels such as `95+`, `90-94`, `85-89`, and `5-9`.
5. Use the header `Age groups (years)` above the age labels.
6. Use Roboto Regular for age labels.
7. Use Roboto Medium for the age-label header.
8. Use `38 pt` to `42 pt` by default, with a smaller consistent override only when a dense pyramid layout requires it.
9. Use grey `#666666` to `#7A7A7A`.
10. Keep the centre gutter wide enough that labels do not collide with bars.

#### 5.5.3 Sex Colours

1. Use the sex and age-sex palette in `core-colour-guidelines.md` for simple sex encoding.
2. Keep male and female mappings stable across panels.
3. Use flat borderless bars.
4. Use 85 to 100 percent opacity.
5. Put sex labels below each side.
6. Use Roboto Regular or Medium for sex labels.
7. When stacked by disease or risk, use the disease or risk palette for stacked segments and keep sex identified by side labels.

#### 5.5.4 Overlay Curves

1. Use overlay curves only when adding a second metric.
2. Use the sex and age-sex overlay colours in `core-colour-guidelines.md`.
3. Use the total or background curve colours in `core-colour-guidelines.md`.
4. Use solid unmarked lines at 1.3 to 2.0 pt.
5. Do not use markers.
6. If bars and curves have different units, clearly separate their mirrored axes.
7. Use the population axis at the top when population bars are present.
8. Use burden or rate axes at the bottom.
9. Keep zero aligned at the centre.

#### 5.5.5 Bar Widths And Spacing

1. Use consistent bar height.
2. Use 70 to 85 percent of age-band spacing.
3. Use equal spacing between age groups.
4. Align bars to the central zero.
5. Do not let bars cross into the age-label gutter.
6. Keep stacked segment order the same on both sides.
7. Do not use black outlines.
8. Use colour contrast to separate segments.
9. Group very small segments as `Other` or move detail to a caption or supplement.

#### 5.5.6 Legends

1. Use an unboxed legend.
2. Use square swatches for bars.
3. Use short line samples only for overlay curves.
4. Place legends outside the plot, usually right side or below.
5. Use one shared legend unless different panels use different colour systems.
6. Order legend entries by analytical priority.
7. Use Roboto Medium for legend headers.
8. Use Roboto Regular for legend labels.
9. Omit the legend for simple male-female pyramids if side labels are clear.
10. Include a category legend for stacked disease or risk pyramids.

#### 5.5.7 Confidence Intervals

1. Do not show confidence intervals unless required.
2. For overlay curve uncertainty, use same-hue ribbons at 10 to 16 percent opacity.
3. Do not outline the ribbon.
4. For bar uncertainty, use grey whiskers `#B0B0B0` at 0.6 to 0.8 pt.
5. Do not use caps.
6. Avoid bar-level uncertainty in stacked pyramids.
7. Move dense uncertainty detail to a caption, table, or separate figure.

#### 5.5.8 Multi-Panel Pyramids

1. Use lowercase panel labels.
2. Place panel labels at the upper-left.
3. Use Roboto Regular or Medium for panel labels.
4. Use short titles such as `DALYs, 2023`.
5. Keep central gutters, bar heights, sex orientation, and typography identical.
6. Use shared legends and axis titles.
7. Repeat labels only when needed for readability.
8. Keep panel spacing consistent.
9. Use a white background and minimal axes.
10. Avoid unused export space.

#### 5.5.9 Avoid

1. Do not use non-Roboto fonts.
2. Do not use uppercase panel labels.
3. Do not use heavy outlines.
4. Do not use grid lines.
5. Do not use negative tick labels.
6. Do not change sex orientation across panels.
7. Do not duplicate age labels unnecessarily.
8. Do not place legends over bars.
9. Do not mix sex colours and disease colours in the same bar layer.

### 5.6 Choropleth Maps

Use clean, flat choropleth maps for geographic burden, rates, rankings, and regional group comparisons.

#### 5.6.1 Projection And Framing

1. Use a simple publication map projection with minimal distortion for the study geography.
2. For world maps, use an equirectangular or Natural Earth style projection.
3. For Asia-Pacific maps, frame from South Asia to Oceania, including Australia and New Zealand when relevant.
4. Keep the mapped geography large enough to read small countries and islands.
5. Avoid excessive empty ocean space unless needed for consistent multi-panel alignment.
6. Use the same projection, scale, and crop across panels in the same figure.
7. Do not rotate maps or use decorative globe views.

#### 5.6.2 Basemap And Borders

1. Use a white ocean and figure background: `#FFFFFF`.
2. Use pale neutral land for non-focal areas: `#EDEDED`.
3. Use thin country borders: `#777777` at 0.2 to 0.4 pt.
4. Use slightly lighter internal borders where many countries are visible: `#8A8A8A` at 0.2 pt.
5. Do not use heavy coastlines, black outlines, shaded relief, terrain, road layers, city labels, or tile labels.
6. Remove visible basemap attribution from final exports where licensing allows.
7. If attribution is legally required, place it outside the plotting area in small muted text rather than over the map.

#### 5.6.3 Sequential Choropleths

1. Follow the choropleth and continuous/ordered scale guidance in `core-colour-guidelines.md`.
2. Use stepped sequential palettes when class boundaries are analytically meaningful.
3. Use continuous gradients only when the user asks for smooth numeric intensity or no class boundaries are required.
4. Use 5 to 7 classes as the default for stepped burden, rate, mortality, DALY, prevalence, incidence, or percentage maps.
5. Order legend categories from lowest to highest.
6. Keep adjacent classes visually separable after export.

#### 5.6.4 Categorical Choropleths

1. Use categorical maps only for nominal groupings, such as SDI group, region, disease group, or analytic class.
2. Use square swatches in the legend.
3. Keep categorical colours distinct at small size.
4. For SDI maps, order categories from High SDI to Low SDI or from Low SDI to High SDI consistently across all panels.
5. For regional maps, use the regional palette in `core-colour-guidelines.md` rather than a sequential ramp.
6. Do not use a sequential ramp for unordered categories.

#### 5.6.5 Legends

1. Place legends on the right side when there is sufficient horizontal space.
2. Place legends below each map only in dense multi-panel world maps.
3. Use unboxed legends.
4. Do not use legend titles unless the legend variable is hierarchical and the title represents a parent variable label.
5. Use Roboto Regular for legend labels.
6. Keep legend labels concise.
7. Include uncertainty intervals in legend text when the map shows class-level or regional estimates.
8. Format uncertainty as `estimate (lower-upper)`.
9. Use consistent decimal precision within a legend.
10. Use commas for thousands.
11. Do not let legends dominate the map area.

#### 5.6.6 Multi-Panel Map Layout

1. Use equal panel widths and heights.
2. Use a shared projection, crop, and scale across all map panels.
3. Use small lowercase panel labels: `a)`, `b)`, `c)`, `d)`.
4. Place panel labels at the upper-left of each panel.
5. Use short panel titles above each map.
6. Keep legends aligned across panels.
7. Use one shared legend only when all panels use the same scale and colour meaning.
8. Use separate legends when panels show different outcomes, units, or ranges.
9. For 2 by 2 world-map figures, place each legend directly below its map or in a consistent right-side column.
10. Keep panel spacing tight enough for comparison but wide enough to prevent legends and labels from colliding.

#### 5.6.7 Labels And Annotation

1. Use Roboto only.
2. Use dark grey text `#2F2F2F` for titles.
3. Use dark grey text `#333333` for legends.
4. Avoid country labels inside the map unless essential.
5. Use callouts only for small islands or focal outliers that cannot be read otherwise.
6. Keep callout lines thin, grey, and unobtrusive.
7. Do not add gridlines, graticules, compass roses, scale bars, decorative shadows, or inset effects unless required for geographic interpretation.

#### 5.6.8 Avoid

1. Do not use visible basemap attribution inside the map panel where it can be legally removed.
2. Do not use default web-map tiles.
3. Do not use satellite, terrain, road, or city-label basemaps.
4. Do not use heavy black country borders.
5. Do not use inconsistent projection or crop across panels.
6. Do not use rainbow palettes.
7. Do not use continuous gradients when class boundaries are analytically important.
8. Do not use legends with unclear units.
9. Do not use uppercase panel labels.
10. Do not use decorative map effects.

### 5.7 Heatmaps And Ranking Tables

Use for ordinal ranks, matrix comparisons, and risk-ranking summaries.

1. Use Roboto throughout.
2. Use the heatmap and ranking palette in `core-colour-guidelines.md` for discrete ranks and named rank categories.
3. For continuous cell values, use `scale_fill_gradientn()` with the appropriate core palette.
4. For binned values, ordered bins, quantiles, numeric ranks, or stepped classes, use `scale_fill_stepsn()` with the appropriate core palette.
5. Use `scale_fill_manual()` only for named discrete rank categories or unordered named categories.
6. Use white or very pale cell separators if needed.
7. Centre text within cells.
8. Use black text on light cells.
9. Use white text on very dark cells.
10. Rotate long column labels only when necessary.
11. Keep row labels readable, even if the plot becomes taller.
12. Use no chart grid lines outside cell boundaries.
13. Add a concise legend or colour bar.

### 5.8 Tables Embedded As Figures

Use only when the figure is genuinely table-based.

1. Use Roboto throughout.
2. Use thin horizontal rules.
3. Avoid heavy boxed tables.
4. Use light shading only for headers.
5. Align numeric values by decimal point where possible.
6. Keep notes small and concise.

## 6. Layout

### 6.1 Canvas And Margins

1. Use enough white space for readability.
2. Avoid large unused export space.
3. The data region should occupy most of the canvas.
4. Keep margins consistent across related figures.
5. Align titles, panels, legends, and captions cleanly.

### 6.2 Multi-Panel Figures

1. Use consistent panel widths and heights.
2. Prefer 2 by 2, 2 by 3, or aligned vertical stacks.
3. Use shared axes where possible.
4. Use small lowercase panel labels.
5. Use one shared legend unless each panel requires a distinct scale.
6. Keep panel titles short.
7. Avoid duplicated axis titles when a shared label is clearer.

### 6.3 Legends

1. Use unboxed legends.
2. Use square swatches for categorical colours.
3. Use short line samples for line types only when needed.
4. Place legends outside the plotting area where possible.
5. Right-side legends work well for maps and multi-series lines.
6. Bottom legends work well for decomposition and stacked bar plots.
7. Keep legend order aligned with analytical priority.
8. Use Roboto Medium for legend headers.
9. Use Roboto Regular for legend labels.
10. Keep legend text the same size across all legend items.
11. Size coloured legend boxes relative to one line of corresponding legend text: at least the same height and at most 20 percent taller.
12. Keep box-label spacing at most one third of the legend box height.
13. Keep box-label spacing smaller than the spacing between adjacent legend items.
14. Keep internal legend spacing tight and publication-quality; avoid broad default spacing between legend elements.
15. Allow generous empty space around the whole legend section when the figure layout needs it.
16. The legend itself does not need to fill the full remaining width or height.
17. Use hierarchical parent labels as legend titles only when the legend variable is hierarchical and space allows.

### 6.4 Axes

1. Use minimal axis lines.
2. Use muted grey tick labels.
3. Avoid heavy black spines.
4. Use `K` and `M` suffixes where appropriate.
5. Keep units explicit, for example `per 100,000`, `%`, or `DALYs`.
6. Do not over-label dense axes.
7. Keep axis titles short and direct.

### 6.5 Captions

If captions are included in the figure export:

1. Use Roboto.
2. Make the prefix bold, for example `Figure 1:`.
3. Keep the caption body regular.
4. Use black text.
5. Place captions below the figure.
6. Avoid mixing caption typography with manuscript typography.

## 7. Figure-Type Defaults

### 7.1 Overall Trend Line Figure

Use when showing the headline burden or rate trend.

1. Red-blue palette.
2. Solid historical line.
3. Dotted forecast line.
4. Same-hue CI ribbon.
5. Dotted vertical forecast boundary.
6. No grid lines.
7. White background.
8. Roboto typography.
9. No point markers.
10. Legend outside the plotting area.

### 7.2 Multi-Series Trend Figure

Use when comparing risk factors, diseases, regions, SDI groups, or sex-specific trends.

1. Use the semantic palette for the category type.
2. Use small multiples when more than 5 lines would overlap.
3. Use same-hue CI ribbons.
4. Use no point markers.
5. Use no grid lines.
6. Use a shared legend.
7. Use dotted forecast segments where projections are present.
8. Use selective ribbons when overlap is high.
9. Order legends by analytical priority.

### 7.3 General Bar Figure

Use when showing burden, rates, composition, rankings, or grouped comparisons.

1. Use flat rectangular bars with square ends.
2. Use horizontal bars for long labels and rankings.
3. Use vertical bars for naturally ordered axes such as year or age group.
4. Start the quantitative axis at zero unless the figure is a positive-negative decomposition.
5. Use no grid lines.
6. Use borderless bars, or thin white separators for stacked bars if needed.
7. Use one shared unboxed legend with square swatches.
8. Keep row labels left-aligned in horizontal bar plots.

### 7.4 Decomposition Bar Figure

Use when decomposing change into risk exposure, population growth, and population ageing.

1. Use horizontal stacked bars anchored at zero.
2. Use the decomposition palette in `core-colour-guidelines.md`.
3. Keep component colours stable across panels.
4. Use a small dark grey square for the mean marker.
5. Use a faint dotted zero line only if bars cross zero.
6. Use pale grey group header strips only where hierarchy needs them.
7. Keep bars borderless.

### 7.5 Percentage-Change Figure

Use when showing percent change, diverging change, or paired change across diseases or groups.

1. Anchor the x-axis at zero.
2. Use a dotted vertical zero line in faint grey.
3. Default to a continuous diverging colour gradient where colour encodes percentage-change magnitude.
4. Use blue `#3078E0` as the negative terminal and orange `#F08000` as the positive terminal.
5. Set the negative and positive colour terminals from the global most negative and global most positive values in the complete assembled figure.
6. Use the same colour limits across all panels, facets, and subplots in that figure.
7. Use disease colours instead only when colour is explicitly assigned to disease or cause identity rather than percentage-change magnitude.
8. Use grey CI whiskers `#B0B0B0`, no caps.
9. Align zero lines across facets.
10. Include zero in every x-axis.
11. Avoid value labels on every bar in dense panels.

### 7.6 Tornado Or Age-Sex Pyramid Figure

Use when showing age-and-sex stratified mirrored horizontal bars.

1. Male on the left, female on the right.
2. Use absolute positive tick labels on both sides.
3. Use central age labels in the gutter.
4. Order older age groups at the top and younger age groups at the bottom.
5. Use the sex and age-sex palette in `core-colour-guidelines.md` for simple sex bars and overlay rate curves.
6. Use no grid lines.
7. Use a faint dotted central zero line only when the age-label gutter does not already define the centre.

### 7.7 Map Figure

Use when showing geographic burden.

1. Clean choropleth, no visible basemap attribution.
2. White ocean.
3. Pale non-focal land.
4. Thin grey country borders.
5. Right-side legend.
6. Sequential or categorical palette according to the variable.
7. Uncertainty in legend text where needed.
8. Shared projection, crop, and scale across panels.
9. Stepped 5 to 7 class sequential palette for burden or rate maps.
10. Square swatches for categorical maps.

### 7.8 Ranking Or Heatmap Figure

Use when showing ordinal ranking.

1. Use the heatmap and ranking palette in `core-colour-guidelines.md`.
2. Centre values in cells.
3. Use strong contrast for text.
4. Use thin white cell separators.
5. Keep row and column labels readable.
6. Avoid external chart grids.

## 8. Export Rules

1. Export at high resolution.
2. Preserve white background.
3. Use vector format where possible: PDF or SVG.
4. Use PNG at 300 dpi or higher when raster export is required.
5. Keep Roboto embedded where possible.
6. Check that CI ribbons remain visible after export.
7. Check that dotted forecast lines remain dotted after export.
8. Check that map attribution or tile labels are absent in final outputs where possible.
9. Check that all labels fit inside the canvas.

## 9. LLM Prompt Block

Use this block when asking an LLM to create a figure in this house style:

```text
Create the figure in the established house style.

Use Roboto only. Use a white background. Use no grid lines. Use small lowercase panel labels formatted as a), b), c). Use dotted faint grey reference lines only where needed, especially for the historical-forecast boundary or zero reference. Use red and blue for the overall or most important trends. Use same-hue translucent confidence ribbons for line plots. Historical lines should be solid. Forecast lines should be dotted. Use no point markers on time-series lines. Use unboxed legends outside the data area.

For all graph colours, read `core-colour-guidelines.md` and select one colour system before writing plotting code. Use this strict order: user request, graph-type encoding, semantic palette, study-context fallback, general/Tableau fallback. Use named vectors with explicit factor levels or scale limits for semantic mappings.

For graph-type details, follow sections 5.1 to 5.7 of `figure_house_style_guidelines.md` and the scale guidance in `core-colour-guidelines.md`.
```

## 10. Observed Variation To Treat As Secondary

These choices appeared in the source figures but should not override the canonical rules above.

1. Earlier source font variation should be ignored. The canonical rule is Roboto only.
2. Some figures used `(A)`, `A)`, or no panel labels. The canonical rule is small lowercase `a)`, `b)`.
3. Some figures used faint grid lines. The canonical rule is no grid lines.
4. Some maps included Mapbox or OpenStreetMap attribution. The canonical rule is clean choropleth maps without visible basemap attribution where possible.
5. Some historical bars and pyramids used black outlines. The canonical rule is borderless or minimally outlined marks unless contrast requires a thin boundary.
6. Some supplement figures used default primary colours. Treat these as secondary evidence.

## 11. Quality Checklist

Before finalising a recreated figure, verify:

1. All text is Roboto.
2. Panel labels use `a)`, `b)`, `c)`.
3. No grid lines are visible.
4. Reference lines are dotted and faint grey.
5. Historical line segments are solid.
6. Forecast line segments are dotted.
7. CI ribbons use the same hue as the corresponding line.
8. Red and blue carry the headline trends.
9. Line graphs have no point markers unless there is a specific analytic reason.
10. Bar graphs use flat borderless bars with square ends.
11. Percentage-change graphs have a dotted zero line and grey uncapped CI whiskers.
12. Tornado plots use male-left, female-right mirrored bars and absolute tick labels.
13. Maps have no visible basemap attribution where possible.
14. Legends are unboxed and compact.
15. Labels and legends fit cleanly inside the canvas.
16. Dotted lines, ribbons, and thin borders remain visible after export.
