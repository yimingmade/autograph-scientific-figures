# Example Briefs

These prompts use the fully synthetic data in `examples/minimal-data/`. Replace `/path/to/autograph-scientific-figures` with the local path to this repository.

## 1. Line Graph With Uncertainty Ribbon

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example burden demo
Make a line graph of age-standardised mortality rate from 2000 to 2025 using burden_timeseries.csv.
Use year on the x-axis, estimate on the y-axis, cause as colour, and lower/upper as uncertainty ribbons.
Filter to location = Global, sex = Both, age_group = Age-standardised, measure = Mortality rate, metric = Rate per 100,000.
Use all annual rows from 2000 to 2025.
```

## 2. Stacked Bar Graph

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example component demo
Make a horizontal stacked bar graph using component_composition.csv.
Show the percentage composition of total burden by component for each year.
Use year as rows, component as fill, and percent as the value.
Use all annual rows from 2000 to 2025.
```

## 3. Dot Plot Or Forest Plot

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example subgroup demo
Make a forest plot using subgroup_estimates.csv.
Filter to year = 2025.
Show estimate on the x-axis, subgroup on the y-axis, and lower/upper as confidence intervals.
Use domain as colour and include a vertical reference line at reference_value = 1.
```

## 4. Percentage-Change Graph

```text
/make-figure
Input directory: /path/to/autograph-scientific-figures/examples/minimal-data
Project name: example change demo
Make a percentage-change graph using percentage_change.csv.
Show percent_change on the x-axis and category on the y-axis.
Use lower and upper as uncertainty intervals and draw a zero reference line.
```
