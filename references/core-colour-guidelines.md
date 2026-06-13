# Core Colour Guidelines

This file is the colour authority for figures generated through the `make-figure` workflow. Read it before choosing graph colours.

Use these guidelines with R, `ggplot2`, `patchwork`, and `ggsave`.

## 1. Palette Selection Protocol

Select one colour system before writing plotting code, using this strict order:

1. **User request, if present.** If the user requests a specific colour system, palette, or colour choices that are clearly congruent with one of the systems below, use that system unless the user later changes the instruction.
2. **Graph-type encoding.** Use diverging, heatmap/ranking, choropleth, sex/age-sex, or continuous/stepped scale logic when the graph type requires it.
3. **Semantic palette.** Use Sections 4.4 to 4.8 and 4.11 when the user's variable labels sufficiently match those semantic systems.
4. **Study-context fallback.** If no graph-type or semantic palette applies, choose the palette that best fits the study context from Section 2.
5. **General/Tableau fallback.** As a last resort, use the general house palette or one prespecified Tableau palette from Section 3 and keep it stable for the whole figure.

Keep colour meanings stable once assigned. Do not mix colour logics in one layer. For example, do not encode both percentage-change magnitude and disease with the same fill aesthetic in one panel.

For semantic mappings in R, use named vectors and explicit scale limits or factor levels. Do not rely on unnamed vector order for disease, risk-factor, regional, SDI, decomposition, or sex mappings.

Example:

```r
disease_palette <- c(
  "Cardiovascular disease" = "#E15759",
  "Cancer" = "#4E79A7"
)

df$disease <- factor(df$disease, levels = names(disease_palette))

scale_fill_manual(values = disease_palette, limits = names(disease_palette), drop = FALSE)
```

Grey is allowed for a substantive category when that category is a reference, control, or comparative group rather than the main study result.

Headline CVD versus cancer comparisons use the priority red-blue system in Section 4.1. Disease or cause encoding uses the disease palette in Section 4.4.

## Continuous And Ordered Colour Scales

Use `scale_colour_manual()` or `scale_fill_manual()` only for unordered categorical variables.

Use `scale_fill_gradientn()`, `scale_colour_gradientn()`, `scale_fill_gradient2()`, or `scale_colour_gradient2()` when colour encodes a continuous numeric value.

Use `scale_fill_stepsn()` or `scale_colour_stepsn()` when colour encodes ordered bins, quantiles, numeric ranks, or stepped map classes.

For percentage-change figures, default to a continuous diverging gradient where colour encodes percentage-change magnitude and sign. Set the terminal negative colour to `#3078E0` and the terminal positive colour to `#F08000`. Compute the colour-scale limits from the global most negative and global most positive percentage-change values in the complete assembled figure, including every panel, facet, and subplot. Do not compute separate gradient limits for each graph inside the figure unless the user explicitly asks for independent panel scaling.

For choropleth maps, prefer stepped scales when class boundaries are analytically meaningful. Use continuous gradients only when the user asks for smooth numeric intensity or when no class boundaries are required.

For heatmaps, use:

1. `scale_fill_gradientn()` for continuous cell values.
2. `scale_fill_stepsn()` for binned continuous values.
3. `scale_fill_stepsn()` for ordered or numeric ranks.
4. `scale_fill_manual()` only for named discrete rank categories or unordered named categories.

Default choropleth red ramp:

```r
choropleth_red_ramp <- c(
  "#FFCBC1", "#FDB4A6", "#FA9D8A", "#F58576",
  "#EC6969", "#DC5363", "#C64461"
)
```

Default choropleth blue-teal ramp:

```r
choropleth_blue_teal_ramp <- c(
  "#C9E9E0", "#AAD8D8", "#8EC8D1", "#6EB7C8",
  "#5DA4BD", "#5A92AF", "#567FA1"
)
```

## 2. Study Context Palette Selection

Use these rules when the strict order reaches study-context fallback or general/Tableau fallback.

1. **Headline two-series comparisons:** use the red-blue priority system in Section 4.1.
2. **General categorical comparisons:** use the general house palette in Section 4.3, or `tableau_10` when a conventional Tableau categorical system is more suitable.
3. **Many unrelated categorical groups:** use `tableau_20` or `tableau_hue_circle`, but prefer semantic palettes if labels match Sections 4.4 to 4.8.
4. **Colourblind-sensitive categorical figures:** use `tableau_colour_blind`.
5. **Status, traffic-light, or ordered warning categories:** use `tableau_traffic`.
6. **Background, comparator, or muted context groups:** use `tableau_seattle_grays` or the neutral greys in Section 4.1.
7. **Muted academic multi-category figures:** use `tableau_miller_stone`, `tableau_superfishel_stone`, or `tableau_nuriel_stone`.
8. **High-contrast presentation-like categorical figures:** use `tableau_jewel_bright` only when strong separation is needed and the house semantic palettes do not apply.
9. **Seasonal, climate, or time-of-year contexts:** use `tableau_summer` or `tableau_winter` when semantically appropriate.
10. **Environmental, metabolic, or mixed health-system contexts:** consider `tableau_green_orange_teal`.
11. **Clinical comparisons involving cardiometabolic, oncology, or mixed organ-system contexts:** consider `tableau_red_blue_brown`.
12. **Mental health, sex/gender, psychosocial, or mixed neutral contexts:** consider `tableau_purple_pink_gray` when the specific disease or risk palette is not a better match.

## 3. Tableau Palettes For ggplot2

These palettes were extracted from the local R package `ggthemes` using `ggthemes::tableau_color_pal()`.

```r
tableau_10 <- c(
  "#4E79A7", "#F28E2B", "#E15759", "#76B7B2", "#59A14F",
  "#EDC948", "#B07AA1", "#FF9DA7", "#9C755F", "#BAB0AC"
)

tableau_20 <- c(
  "#4E79A7", "#A0CBE8", "#F28E2B", "#FFBE7D", "#59A14F",
  "#8CD17D", "#B6992D", "#F1CE63", "#499894", "#86BCB6",
  "#E15759", "#FF9D9A", "#79706E", "#BAB0AC", "#D37295",
  "#FABFD2", "#B07AA1", "#D4A6C8", "#9D7660", "#D7B5A6"
)

tableau_colour_blind <- c(
  "#1170aa", "#fc7d0b", "#a3acb9", "#57606c", "#5fa2ce",
  "#c85200", "#7b848f", "#a3cce9", "#ffbc79", "#c8d0d9"
)

tableau_traffic <- c(
  "#b60a1c", "#e39802", "#309143", "#e03531", "#f0bd27",
  "#51b364", "#ff684c", "#ffda66", "#8ace7e"
)

tableau_seattle_grays <- c(
  "#767f8b", "#b3b7b8", "#5c6068", "#d3d3d3", "#989ca3"
)

tableau_miller_stone <- c(
  "#4f6980", "#849db1", "#a2ceaa", "#638b66", "#bfbb60",
  "#f47942", "#fbb04e", "#b66353", "#d7ce9f", "#b9aa97",
  "#7e756d"
)

tableau_superfishel_stone <- c(
  "#6388b4", "#ffae34", "#ef6f6a", "#8cc2ca", "#55ad89",
  "#c3bc3f", "#bb7693", "#baa094", "#a9b5ae", "#767676"
)

tableau_nuriel_stone <- c(
  "#8175aa", "#6fb899", "#31a1b3", "#ccb22b", "#a39fc9",
  "#94d0c0", "#959c9e", "#027b8e", "#9f8f12"
)

tableau_jewel_bright <- c(
  "#eb1e2c", "#fd6f30", "#f9a729", "#f9d23c", "#5fbb68",
  "#64cdcc", "#91dcea", "#a4a4d5", "#bbc9e5"
)

tableau_summer <- c(
  "#bfb202", "#b9ca5d", "#cf3e53", "#f1788d",
  "#00a2b3", "#97cfd0", "#f3a546", "#f7c480"
)

tableau_winter <- c(
  "#90728f", "#b9a0b4", "#9d983d", "#cecb76", "#e15759",
  "#ff9888", "#6b6b6b", "#bab2ae", "#aa8780", "#dab6af"
)

tableau_green_orange_teal <- c(
  "#4e9f50", "#87d180", "#ef8a0c", "#fcc66d", "#3ca8bc",
  "#98d9e4", "#94a323", "#c3ce3d", "#a08400", "#f7d42a",
  "#26897e", "#8dbfa8"
)

tableau_red_blue_brown <- c(
  "#466f9d", "#91b3d7", "#ed444a", "#feb5a2", "#9d7660",
  "#d7b5a6", "#3896c4", "#a0d4ee", "#ba7e45", "#39b87f",
  "#c8133b", "#ea8783"
)

tableau_purple_pink_gray <- c(
  "#8074a8", "#c6c1f0", "#c46487", "#ffbed1", "#9c9290",
  "#c5bfbe", "#9b93c9", "#ddb5d5", "#7c7270", "#f498b6",
  "#b173a0", "#c799bc"
)

tableau_hue_circle <- c(
  "#1ba3c6", "#2cb5c0", "#30bcad", "#21B087", "#33a65c",
  "#57a337", "#a2b627", "#d5bb21", "#f8b620", "#f89217",
  "#f06719", "#e03426", "#f64971", "#fc719e", "#eb73b3",
  "#ce69be", "#a26dc2", "#7873c0", "#4f7cba"
)
```

## 4. House Colour Systems

### 4.1 Overall Priority Colours

Use red and blue for overall or most important trends.

1. Primary red: `#C01820`.
2. Primary blue: `#4E79A7`.
3. Alternative softer blue: `#658CBA`.
4. Secondary grey: `#B0B8B8`.
5. Dark text grey: `#2F2F2F`.
6. Tick grey: `#666666`.
7. Reference grey: `#E6E6E6`.

Use the red-blue pairing when the comparison is conceptually important, such as burden versus rate, headline CVD versus cancer, or two headline populations.

Use grey as a secondary comparator, especially for global context or background series.

### 4.2 Confidence Interval Colours

Confidence intervals should use the same hue as the main line, with opacity reduced.

Do not use a separate CI colour category.

Recommended opacity:

1. Historical uncertainty ribbon: 12 to 18 percent opacity.
2. Forecast uncertainty ribbon: 18 to 28 percent opacity.
3. Wide or overlapping ribbons: reduce to 10 to 16 percent opacity.

Flattened fallback colours, if opacity is unavailable:

1. Red ribbon: `#F8C8C0` or `#EFAAAB`.
2. Blue ribbon: `#AAC1DC` or `#A5BBD2`.
3. Grey ribbon: `#E8E8E8`.
4. Salmon ribbon: `#F3B1AF`.

### 4.3 General Palette For Categorical Series

Use these colours as the general house palette when no more specific semantic palette applies.

1. Red: `#C01820`.
2. Salmon: `#E86F6E`.
3. Coral: `#F87050`.
4. Blue: `#4E79A7`.
5. Soft blue: `#658CBA`.
6. Pale blue: `#A8D0E8`.
7. Navy: `#082060`.
8. Teal: `#6FD4C4`.
9. Cyan: `#50D0D0`.
10. Green: `#309040`.
11. Dark green: `#206840`.
12. Mint: `#B0F0C0`.
13. Olive: `#B0C058`.
14. Orange: `#E09800`.
15. Soft orange: `#F2A869`.
16. Purple: `#A050F0`.
17. Lavender: `#C28BF8`.
18. Pink: `#F86070`.
19. Grey: `#B0B8B8`.
20. Light neutral: `#EEEEEE`.

### 4.4 Disease Palette

Second-layer semantic palette. Use when the user's variable labels sufficiently match disease categories.

1. Cardiovascular disease: `#E15759`.
2. Cancer: `#4E79A7`.
3. Ischaemic heart disease: `#FFC4CA`.
4. Stroke: `#B9D8C9`.
5. Atrial fibrillation: `#9EDAE5`.
6. MASLD: `#8CAAC6`.
7. Type 2 diabetes: `#A2D89C`.
8. Obesity: `#CDB9DE`.
9. Peripheral artery disease: `#9A6B5A`.
10. Valvular disease: `#FBC890`.
11. Hepatocellular carcinoma: `#D4D4D4`.

### 4.5 Risk-Factor Palette

Second-layer semantic palette. Use when the user's variable labels sufficiently match risk-factor categories.

1. High systolic blood pressure: `#E86F6E` or `#C01820`.
2. High LDL cholesterol: `#7997EA` or `#97A9EA`.
3. Tobacco: `#C28BF8` or `#084090`.
4. High body-mass index: `#F2A869`.
5. High fasting plasma glucose: `#6FD4C4`.
6. Dietary risks: `#F9D38C`.
7. Low physical activity: `#F198A6`.
8. Kidney dysfunction: `#A6BDDC`.
9. Air pollution: `#206840`.
10. Non-optimal temperature: `#58A050`.
11. Other environmental risks: `#98D888`.

### 4.6 Regional Palette

Second-layer semantic palette. Use when the user's variable labels sufficiently match Asia-Pacific subregions or global regional comparisons.

1. Asia-Pacific: `#A8D0E8`.
2. Global: `#D0C0C0` or `#B0B8B8`.
3. Australasia: `#309040`.
4. Central Asia: `#B0C058`.
5. East Asia: `#E09800`.
6. Oceania: `#F87050`.
7. South Asia: `#A050F0`.
8. Southeast Asia: `#3098F0`.

### 4.7 SDI Palette

Second-layer semantic palette. Use when the user's variable labels sufficiently match socio-demographic index groups.

1. Asia-Pacific overall: `#082060`.
2. High SDI: `#7820E0`.
3. High-middle SDI: `#3098F0`.
4. Middle SDI: `#60A860`.
5. Low-middle SDI: `#E8B030`.
6. Low SDI: `#D84030`.

### 4.8 Decomposition Palette

Second-layer semantic palette. Use when the user's variable labels sufficiently match decomposition components.

1. Change due to risk exposures: `#E87070`.
2. Change due to population growth: `#68C0C8`.
3. Change due to population ageing: `#B0F0C0`.
4. Mean marker: `#6E6868` or `#706A6A`.

### 4.9 Diverging Percentage-Change Gradient

Use for percentage-change bars or estimate bars around zero when colour encodes change magnitude and direction. This is the default colour system for percentage-change figures.

1. Negative terminal: `#3078E0`, mapped to the global most negative percentage-change value in the complete figure.
2. Positive terminal: `#F08000`, mapped to the global most positive percentage-change value in the complete figure.
3. Neutral midpoint: use a near-white or very pale neutral at zero, for example `#F7F7F7`.
4. Pale negative support colour, if an explicit multi-stop gradient is needed: `#98B0E0`.
5. Pale positive support colour, if an explicit multi-stop gradient is needed: `#E0B888`.
6. CI whisker: `#B0B0B0`.

In R, compute limits once from the full figure dataset before splitting into panels or component plots. Use those same limits in every percentage-change layer in the figure, for example:

```r
change_limits <- range(full_figure_data$pct_change, na.rm = TRUE)

scale_fill_gradient2(
  low = "#3078E0",
  mid = "#F7F7F7",
  high = "#F08000",
  midpoint = 0,
  limits = change_limits
)
```

### 4.10 Heatmap And Ranking Palette

Use for ranking heatmaps, ordinal matrices, ordered or numeric ranks, and named rank categories. For continuous or binned heatmap values, follow `Continuous And Ordered Colour Scales`.

1. Rank 1 or highest priority: `#A00040`.
2. Strong red: `#D84050`.
3. Orange: `#F07040`.
4. Yellow: `#E8F898`.
5. Green: `#A8E0A0`.
6. Cyan-green: `#68C0A8`.
7. Blue: `#3088C0`.
8. Purple: `#6050A0`.
9. Deep purple: `#400080`.
10. Near-black purple: `#180030`.

Use white cell separators only when needed for table legibility.

### 4.11 Sex And Age-Sex Palette

Use for simple sex encoding in tornado plots, age-sex pyramids, and mirrored sex-specific bars when colour encodes sex.

1. Male bars: `#80C0F0`.
2. Female bars: `#E88080`.
3. Male overlay curves: `#084090`.
4. Female overlay curves: `#B01038`.
5. Total or background curves: `#6E737A` or `#B0B8B8`.

When age-sex pyramids are stacked by disease, risk factor, region, SDI group, or another semantic category, use the matching semantic palette for stacked segments and identify sex by side labels, axis direction, or panel labels.
