# Enterprise Document Tree Search: An Algorithmic Study

[![Build and Test](https://github.com/danindiana/enterprise-document-treesearch/actions/workflows/build-test.yml/badge.svg)](https://github.com/danindiana/enterprise-document-treesearch/actions/workflows/build-test.yml)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Language: C++](https://img.shields.io/badge/Language-C%2B%2B-orange.svg)](https://en.cppreference.com/w/cpp/17)

A hands-on algorithmic exploration of filesystem traversal techniques. This repository compares **Iterative Deepening Depth-First Search (IDDFS)** and **Breadth-First Search (BFS)** for recursive file matching by name or extension in C++17, including a concurrency experiment using standard C++ threads and a parallel reference port in Chapel.

Rather than a production utility, this project serves as a step-by-step evolutionary study showing how directory traversal algorithms scale, handle OS permissions, handle CLI parameters, and adapt to task parallelism.

---

## Why not `find`, `fd`, or `ripgrep`?

In real-world production environments, robust tools like `find`, `fd`, or `ripgrep` should be used. This project is structured as a **learning and algorithm-comparison case study**. It allows you to:
- Trace the progression from a basic file finder to exception-safe, parameter-driven, and concurrent implementations.
- Compare the space-efficiency of IDDFS (minimal stack footprints) against the path optimality of BFS (queue-based storage).
- Benchmark raw multi-threading overhead (spawning threads per subdirectory) versus sequential traversal on different filesystem layouts.
- Contrast standard C++ multi-threading with native task-parallelism in Chapel.

---

## Usage

All compiled C++ binaries accept arguments in the following format:
```bash
# General Usage:
# ./<executable> <target_extension> <root_path> <max_depth>

# Example: Search for PDF files up to depth 3 in the user documents directory
./IDDFileSearch_Extension .pdf /home/$USER/documents 3
```

### Sample Output

```
Found file: /home/user/documents/resume.pdf
Found file: /home/user/documents/projects/whitepaper.pdf
Found file: /home/user/documents/projects/deep/notes.pdf
```

---

## The Six C++ Implementations

The repository contains six distinct C++ implementations, representing a deliberate progression in features, exception safety, and algorithm choices:

| Program File | Algorithm | Purpose & Features | Traversal Pattern |
|---|---|---|---|
| [`IDDFileSearch.cpp`](./IDDFileSearch.cpp) | IDDFS | **Base implementation**: Hardcoded search for `test.txt` at depth 3. No parameter inputs or advanced error catches. | Sequential |
| [`IDDFileSearch_ExceptionHandled.cpp`](./IDDFileSearch_ExceptionHandled.cpp) | IDDFS | **Exception safety**: Introduces try-catch blocks around `std::filesystem::directory_iterator` to handle permission errors gracefully. | Sequential |
| [`IDDFileSearch_CmdLine.cpp`](./IDDFileSearch_CmdLine.cpp) | IDDFS | **Parameterization**: Adds parsing for command-line arguments (target file, search directory, maximum depth limit). | Sequential |
| [`IDDFileSearch_Extension.cpp`](./IDDFileSearch_Extension.cpp) | IDDFS | **Extension filtering**: Adapts the search from a single file name to any file matching a specified extension (e.g. `.pdf`). | Sequential |
| [`IDDFileSearch_Extension_Concurrent.cpp`](./IDDFileSearch_Extension_Concurrent.cpp) | IDDFS | **Concurrency experiment**: Spawns standard threads (`std::thread`) for concurrent search in subdirectories at each depth limit. | Parallel |
| [`BFSFileSearch.cpp`](./BFSFileSearch.cpp) | BFS | **Algorithmic alternative**: Implements queue-based Breadth-First Search up to a depth limit, comparing its memory layout and traversal order against IDDFS. | Sequential |

Additionally, [`IterativeDeepening.chpl`](./IterativeDeepening.chpl) provides a port of the IDDFS algorithm to the **Chapel parallel programming language** as a comparison point for high-level native parallelism.

---

## Repository Structure

All implementation code and execution scripts reside in the root directory.

```
enterprise-document-treesearch/
├── BFSFileSearch.cpp                    # BFS C++ implementation
├── CONTRIBUTING.md                      # Contributing guidelines
├── diskSelectSearch.sh                  # Interactive disk selection utility
├── docs/                                # Documentation folder
│   ├── ARCHITECTURE.md                  # Deep dive into IDDFS & BFS algorithms
│   └── archive/                         # Historical documentation archive
│       └── README_20251115_182559.md    # Original build/deployment guide
├── .github/workflows/
│   └── build-test.yml                   # CI build and validation workflow (GitHub Actions)
├── .gitignore                           # Git ignore rules
├── IDDFileSearch.cpp                    # Base IDDFS C++ implementation
├── IDDFileSearch_CmdLine.cpp            # IDDFS C++ with CLI arguments
├── IDDFileSearch_ExceptionHandled.cpp   # IDDFS C++ with basic exception safety
├── IDDFileSearch_Extension.cpp          # IDDFS C++ supporting extension filters
├── IDDFileSearch_Extension_Concurrent.cpp # Parallel extension-based IDDFS
├── IDDFileSearch_Extension_Concurrent.txt # Sample run logs and execution context
├── IterativeDeepening.chpl              # Chapel implementation of IDDFS
├── LICENSE                              # Project License (GNU GPL v3)
├── Makefile                             # Build configuration for make utility
├── README.md                            # This README file
└── robustDiskSelectSearch.sh            # Robust interactive disk selection utility
```

---

## System Requirements & Compiler Toolchain

- **OS**: Linux (expected to work on modern distributions including Ubuntu, Debian, RHEL, CentOS, Alpine) <!-- TODO: VERIFY -->
- **Compiler**: GCC 9+ or Clang 9+ (requires full native C++17 support for standard `<filesystem>`)
- **Build Tools**: GNU Make 4.0+
- **Chapel**: Chapel compiler (`chpl`) (optional, only needed for Chapel port)

For detailed bare-metal setup, environment configurations, manual verification tests, troubleshooting guides, and production deployment checklists, please refer to the **[BUILD.md](./BUILD.md)** guide.

---

## Documentation & Support

- **Algorithm & Complexity details**: See [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md)
- **Contributing Guidelines**: See [CONTRIBUTING.md](./CONTRIBUTING.md)
- **Bug Reports & Feedback**: Please open an issue on the [GitHub Issues](https://github.com/danindiana/enterprise-document-treesearch/issues) page or start a thread in [Discussions](https://github.com/danindiana/enterprise-document-treesearch/discussions).
