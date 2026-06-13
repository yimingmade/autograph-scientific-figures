import csv
import unittest
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "examples" / "minimal-data"
YEARS = list(range(2000, 2026))


def read_csv(name):
    with (DATA_DIR / name).open(newline="") as handle:
        return list(csv.DictReader(handle))


class MinimalDataTests(unittest.TestCase):
    def test_burden_timeseries_has_every_year_for_each_series(self):
        rows = read_csv("burden_timeseries.csv")
        by_series = defaultdict(list)

        for row in rows:
            key = (
                row["location"],
                row["sex"],
                row["age_group"],
                row["cause"],
                row["measure"],
                row["metric"],
            )
            by_series[key].append(int(row["year"]))

        self.assertGreaterEqual(len(by_series), 12)
        for key, years in by_series.items():
            self.assertEqual(sorted(years), YEARS, key)

    def test_global_cause_series_are_not_straight_lines(self):
        rows = read_csv("burden_timeseries.csv")
        by_cause = defaultdict(list)

        for row in rows:
            if row["location"] == "Global":
                by_cause[row["cause"]].append(row)

        self.assertGreaterEqual(len(by_cause), 10)
        for cause, cause_rows in by_cause.items():
            ordered = sorted(cause_rows, key=lambda row: int(row["year"]))
            values = [float(row["estimate"]) for row in ordered]
            overall_direction = values[-1] - values[0]
            self.assertNotEqual(overall_direction, 0.0, cause)

            deltas = [right - left for left, right in zip(values, values[1:])]
            opposite_moves = [
                delta for delta in deltas
                if delta != 0 and (delta > 0) != (overall_direction > 0)
            ]
            self.assertGreaterEqual(len(opposite_moves), 1, cause)

            linear_step = overall_direction / (len(values) - 1)
            linear_values = [values[0] + (index * linear_step) for index in range(len(values))]
            residuals = [abs(actual - expected) for actual, expected in zip(values, linear_values)]
            self.assertGreaterEqual(max(residuals), 1.0, cause)

    def test_subgroup_estimates_have_2000_and_2025_for_each_subgroup(self):
        rows = read_csv("subgroup_estimates.csv")
        by_subgroup = defaultdict(set)

        for row in rows:
            by_subgroup[(row["domain"], row["subgroup"])].add(int(row["year"]))

        self.assertGreaterEqual(len(by_subgroup), 20)
        for subgroup, years in by_subgroup.items():
            self.assertEqual(years, {2000, 2025}, subgroup)

    def test_component_composition_has_every_year_and_sums_to_100(self):
        rows = read_csv("component_composition.csv")
        by_year = defaultdict(list)

        for row in rows:
            by_year[int(row["year"])].append(float(row["percent"]))

        self.assertEqual(sorted(by_year), YEARS)
        for year, percents in by_year.items():
            self.assertEqual(len(percents), 5, year)
            self.assertAlmostEqual(sum(percents), 100.0, places=6)


if __name__ == "__main__":
    unittest.main()
