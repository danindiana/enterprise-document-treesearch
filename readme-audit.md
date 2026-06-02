# README vs. Reality Audit

This audit document details the discrepancy analysis between the claims in the `README.md` and the actual files, directories, and configuration present in the `enterprise-document-treesearch` repository.

## Discrepancy Table

| Category | Claimed in README | Actual in Repository | Status / Action Needed |
|---|---|---|---|
| **Directory Layout** | `src/` (C++ source files), `scripts/` (shell scripts), `chapel/` (Chapel implementation), `docs/` (docs + archive) | No `src/`, `scripts/`, or `chapel/` directories exist. All C++ source files, shell scripts, and Chapel files reside in the root directory (`./`). `docs/` and `docs/archive/` exist. `CONTRIBUTING.md` is in the root directory. | **Discrepancy**: Update the repository structure in the README to reflect root-level files. |
| **Six Programs** | `IDDFileSearch`, `_ExceptionHandled`, `_CmdLine`, `_Extension`, `_Extension_Concurrent`, `BFSFileSearch` | All six C++ source files exist: `IDDFileSearch.cpp`, `IDDFileSearch_ExceptionHandled.cpp`, `IDDFileSearch_CmdLine.cpp`, `IDDFileSearch_Extension.cpp`, `IDDFileSearch_Extension_Concurrent.cpp`, `BFSFileSearch.cpp`. | **Match**: No missing programs. Update references to point to `./<filename>` in the root directory. |
| **Makefile Targets** | `all`, `quick`, `clean`, `test`, `scripts`, `install`, `uninstall`, `help` | All 8 claimed targets exist. In addition, the Makefile contains a `chapel` target to build the Chapel program. | **Match**: Claimed targets are accurate. Optionally add the `chapel` target description to the README targets table. |
| **Chapel File** | `chapel/IterativeDeepening.chpl` | `IterativeDeepening.chpl` exists in the repository root (`./`). | **Discrepancy**: Correct path to `./IterativeDeepening.chpl` in the README. |
| **LICENSE File** | "See LICENSE file for details." | `LICENSE` file exists in the repository root containing GNU General Public License v3.0 (GPLv3). | **Match**: LICENSE file is present. Update references to specify it is GPL-3.0. |

## Secrets and Sensitive Information Scan
No secrets, credentials, tokens, private keys, or private IP addresses were found in any of the repository files.

## Summary of Planned Documentation Fixes
1. Correct the repo name from `GPT_Enterprise_Treesearch` to `enterprise-document-treesearch` and fix clone URLs.
2. Reframe the H1 and overview to downplay "enterprise / production-ready / document" claims and represent it as an algorithm study (Iterative Deepening DFS vs BFS in C++ and Chapel).
3. Re-structure README to lead with high-level description, code variants, and basic usage. Move build details to `BUILD.md` or a lower section.
4. Correct all file paths in tree diagrams, build instructions, and smoke tests (no `src/`, `scripts/`, or `chapel/` subfolders).
5. Add GitHub Actions CI workflow in `.github/workflows/build-test.yml`.
