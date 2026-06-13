import os
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
TEXT_SUFFIXES = {".md", ".py", ".R", ".yaml", ".yml", ".txt", ".csv", ".json"}
BAD_EXAMPLE_DIR = "bad" + "-examples"
BAD_EXAMPLE_ASSET_REF = "/".join(("assets", BAD_EXAMPLE_DIR))


class PackagingTests(unittest.TestCase):
    def test_bad_example_assets_are_not_packaged(self):
        bad_example_paths = [
            path.relative_to(REPO_ROOT)
            for path in REPO_ROOT.rglob("*")
            if BAD_EXAMPLE_DIR in path.parts
        ]

        self.assertEqual(bad_example_paths, [])

    def test_text_files_do_not_reference_bad_example_png_assets(self):
        references = []

        for root, dirs, files in os.walk(REPO_ROOT):
            dirs[:] = [name for name in dirs if name not in {".git", "__pycache__"}]
            for filename in files:
                path = Path(root) / filename
                if path.suffix not in TEXT_SUFFIXES:
                    continue
                text = path.read_text(encoding="utf-8")
                if BAD_EXAMPLE_DIR in text or BAD_EXAMPLE_ASSET_REF in text:
                    references.append(path.relative_to(REPO_ROOT))

        self.assertEqual(references, [])


if __name__ == "__main__":
    unittest.main()
