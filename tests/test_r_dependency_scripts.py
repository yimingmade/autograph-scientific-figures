import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
MISSING_PACKAGE = "makefiguredefinitelymissingpkg"


def run_rscript(*args):
    return subprocess.run(
        ["Rscript", *args],
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=False,
    )


class RDependencyScriptTests(unittest.TestCase):
    def test_check_script_lists_core_packages(self):
        result = run_rscript("scripts/check_r_setup.R", "--list-core")

        self.assertEqual(result.returncode, 0, result.stderr)
        packages = set(result.stdout.splitlines())
        self.assertEqual(
            packages,
            {"data.table", "ggplot2", "patchwork", "scales"},
        )

    def test_check_script_reports_missing_package_and_install_command(self):
        result = run_rscript(
            "scripts/check_r_setup.R",
            "--packages",
            MISSING_PACKAGE,
            "--install-command",
        )

        self.assertEqual(result.returncode, 1)
        combined = result.stdout + result.stderr
        self.assertIn(MISSING_PACKAGE, combined)
        self.assertIn("scripts/install_r_dependencies.R", combined)

    def test_install_script_dry_run_prints_install_command(self):
        result = run_rscript(
            "scripts/install_r_dependencies.R",
            "--dry-run",
            "--packages",
            MISSING_PACKAGE,
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("install.packages", result.stdout)
        self.assertIn(MISSING_PACKAGE, result.stdout)
        self.assertIn("Dry run", result.stdout)


if __name__ == "__main__":
    unittest.main()
