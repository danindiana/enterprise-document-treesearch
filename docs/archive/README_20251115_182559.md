# GPT Enterprise Tree Search

A comprehensive file search toolkit implementing advanced tree search algorithms with various optimization strategies for enterprise-scale file systems.

## Overview

This repository contains multiple implementations of file search algorithms designed for efficient file discovery across large filesystems, including mounted disks and external storage devices.

## Repository Structure

```mermaid
graph TD
    A[GPT_Enterprise_Treesearch] --> B[Core Implementations]
    A --> C[Shell Scripts]
    A --> D[Alternative Languages]
    A --> E[Documentation]

    B --> B1[IDDFileSearch.cpp<br/>Basic IDDFS]
    B --> B2[IDDFileSearch_ExceptionHandled.cpp<br/>With Error Handling]
    B --> B3[IDDFileSearch_CmdLine.cpp<br/>CLI Version]
    B --> B4[IDDFileSearch_Extension.cpp<br/>Extension Search]
    B --> B5[IDDFileSearch_Extension_Concurrent.cpp<br/>Multi-threaded]
    B --> B6[BFSFileSearch.cpp<br/>Breadth-First Search]

    C --> C1[diskSelectSearch.sh<br/>Disk Selector]
    C --> C2[robustDiskSelectSearch.sh<br/>Enhanced Selector]

    D --> D1[IterativeDeepening.chpl<br/>Chapel Implementation]

    E --> E1[IDDFileSearch_Extension_Concurrent.txt<br/>Usage Examples]
```

## Algorithm Architecture

```mermaid
graph LR
    A[File Search Problem] --> B{Search Strategy}
    B -->|Depth-First| C[IDDFS]
    B -->|Breadth-First| D[BFS]

    C --> C1[Sequential IDDFS]
    C --> C2[Concurrent IDDFS]

    C1 --> E[Search by Filename]
    C1 --> F[Search by Extension]
    C2 --> F

    D --> G[BFS with Depth Limit]

    style C fill:#e1f5ff
    style D fill:#ffe1e1
    style C2 fill:#e1ffe1
```

## IDDFS Algorithm Flow

```mermaid
flowchart TD
    Start([Start IDDFS]) --> Init[Set depth = 0]
    Init --> Loop{depth <= maxDepth?}
    Loop -->|Yes| DLS[Call DLS with current depth]
    DLS --> Check{File Found?}
    Check -->|Yes| Return([Return Success])
    Check -->|No| Increment[depth++]
    Increment --> Loop
    Loop -->|No| NotFound([File Not Found])

    style Start fill:#90EE90
    style Return fill:#90EE90
    style NotFound fill:#FFB6C1
```

## DLS (Depth-Limited Search) Flow

```mermaid
flowchart TD
    Start([DLS: path, target, depth]) --> DepthCheck{depth >= 0?}
    DepthCheck -->|No| ReturnFalse([Return False])
    DepthCheck -->|Yes| Iterate[Iterate directory entries]

    Iterate --> Entry{For each entry}
    Entry --> IsFile{Is file?<br/>depth == 0?}
    IsFile -->|Yes| Match{Matches target?}
    Match -->|Yes| Found([Found! Print path])
    Match -->|No| Next1[Next entry]

    IsFile -->|No| IsDir{Is directory?}
    IsDir -->|Yes| Recurse[DLS on subdirectory<br/>depth - 1]
    IsDir -->|No| Next2[Next entry]

    Recurse --> Next3[Next entry]
    Next1 --> Entry
    Next2 --> Entry
    Next3 --> Entry
    Found --> Entry

    Entry -->|Done| ReturnFalse

    style Start fill:#87CEEB
    style Found fill:#90EE90
    style ReturnFalse fill:#FFB6C1
```

## Concurrent IDDFS Architecture

```mermaid
graph TD
    A[Main Thread] --> B[DLS Call]
    B --> C{Iterate Directories}
    C --> D1[Subdirectory 1]
    C --> D2[Subdirectory 2]
    C --> D3[Subdirectory 3]
    C --> DN[Subdirectory N]

    D1 --> T1[Thread 1<br/>DLS Recursive]
    D2 --> T2[Thread 2<br/>DLS Recursive]
    D3 --> T3[Thread 3<br/>DLS Recursive]
    DN --> TN[Thread N<br/>DLS Recursive]

    T1 --> J[Join All Threads]
    T2 --> J
    T3 --> J
    TN --> J

    J --> E[Continue to Next Depth]

    style A fill:#FFD700
    style T1 fill:#98FB98
    style T2 fill:#98FB98
    style T3 fill:#98FB98
    style TN fill:#98FB98
```

## BFS vs IDDFS Comparison

```mermaid
graph TB
    subgraph BFS["BFS Approach"]
        B1[Root] --> B2[Level 1: All Nodes]
        B2 --> B3[Level 2: All Nodes]
        B3 --> B4[Level 3: All Nodes]
        B5[Queue-based<br/>High Memory Usage<br/>Finds Shortest Path]
    end

    subgraph IDDFS["IDDFS Approach"]
        I1[Depth 0] --> I2[Depth 1]
        I2 --> I3[Depth 2]
        I3 --> I4[Depth 3]
        I5[Stack-based<br/>Low Memory Usage<br/>Revisits Nodes]
    end

    style BFS fill:#ffe1e1
    style IDDFS fill:#e1f5ff
```

## Usage Workflow

```mermaid
sequenceDiagram
    participant User
    participant Script as Shell Script
    participant Program as IDDFileSearch
    participant FS as Filesystem

    User->>Script: Run robustDiskSelectSearch.sh
    Script->>Script: Check dependencies
    Script->>Script: Compile C++ program
    Script->>User: Display disk list
    User->>Script: Select disk
    Script->>User: Prompt for extension
    User->>Script: Enter .pdf
    Script->>User: Prompt for max depth
    User->>Script: Enter 5
    Script->>Program: Execute search
    Program->>FS: IDDFS with depth 0
    Program->>FS: IDDFS with depth 1
    Program->>FS: IDDFS with depth 2
    FS-->>Program: Found matches
    Program-->>User: Display results
```

## Implementation Comparison

```mermaid
graph LR
    A[Implementation Variants] --> B[IDDFileSearch.cpp]
    A --> C[IDDFileSearch_ExceptionHandled.cpp]
    A --> D[IDDFileSearch_CmdLine.cpp]
    A --> E[IDDFileSearch_Extension.cpp]
    A --> F[IDDFileSearch_Extension_Concurrent.cpp]
    A --> G[BFSFileSearch.cpp]

    B --> B1[Hardcoded values<br/>No error handling]
    C --> C1[Exception handling<br/>Hardcoded values]
    D --> D1[CLI arguments<br/>Exception handling<br/>Filename search]
    E --> E1[CLI arguments<br/>Exception handling<br/>Extension search<br/>Sequential]
    F --> F1[CLI arguments<br/>Exception handling<br/>Extension search<br/>Multi-threaded]
    G --> G1[BFS algorithm<br/>CLI arguments<br/>Exception handling]

    style B1 fill:#ffcccc
    style C1 fill:#ffffcc
    style D1 fill:#ccffcc
    style E1 fill:#ccffff
    style F1 fill:#e1ffe1
    style G1 fill:#ffe1e1
```

## Features

### Core Algorithms

1. **IDDFS (Iterative Deepening Depth-First Search)**
   - Memory-efficient tree traversal
   - Configurable maximum search depth
   - Multiple variants with progressive enhancements

2. **BFS (Breadth-First Search)**
   - Level-by-level traversal
   - Queue-based implementation
   - Optimal for finding closest matches

### Implementation Variants

| File | Features | Use Case |
|------|----------|----------|
| `IDDFileSearch.cpp` | Basic IDDFS | Learning/Testing |
| `IDDFileSearch_ExceptionHandled.cpp` | Error handling | Production (basic) |
| `IDDFileSearch_CmdLine.cpp` | CLI arguments | Flexible usage |
| `IDDFileSearch_Extension.cpp` | Extension-based search | Finding files by type |
| `IDDFileSearch_Extension_Concurrent.cpp` | Multi-threaded | Large filesystem search |
| `BFSFileSearch.cpp` | Breadth-first approach | Alternative strategy |

## Compilation

### C++ Programs

```bash
# Standard compilation
g++ -std=c++17 IDDFileSearch_Extension.cpp -o IDDFileSearch_Extension

# Concurrent version (requires pthread)
g++ -std=c++17 -pthread IDDFileSearch_Extension_Concurrent.cpp -o IDDFileSearch_Extension_Concurrent

# BFS version
g++ -std=c++17 BFSFileSearch.cpp -o BFSFileSearch
```

### Chapel Program

```bash
chpl IterativeDeepening.chpl
```

## Usage Examples

### Using Shell Scripts (Recommended)

```bash
# Interactive disk selection with robust error checking
./robustDiskSelectSearch.sh

# Simple disk selection
./diskSelectSearch.sh
```

### Direct Command Line Usage

```bash
# Search for PDF files
./IDDFileSearch_Extension .pdf /path/to/search 5

# Search for text files with concurrent search
./IDDFileSearch_Extension_Concurrent .txt /media/disk 8

# BFS search for JPEG files
./BFSFileSearch /path/to/search target.jpg 10
```

### Usage Patterns

```bash
# Syntax
./IDDFileSearch_Extension [extension] [root_path] [max_depth]

# Examples from real usage
sudo ./IDDFileSearch_Extension .pdf /media/walter/7514e32b-65c9-4a64-a233-5db2311455f4/files/ 3
sudo ./IDDFileSearch_Extension .jpg /media/walter/462C364D2C3637EF/ 8
```

## Performance Characteristics

```mermaid
graph TD
    A[Performance Considerations] --> B[Sequential IDDFS]
    A --> C[Concurrent IDDFS]
    A --> D[BFS]

    B --> B1[✓ Low memory usage]
    B --> B2[✓ Simple implementation]
    B --> B3[✗ Slower on large trees]

    C --> C1[✓ Faster on multi-core]
    C --> C2[✓ Good for wide trees]
    C --> C3[✗ Thread overhead]
    C --> C4[✗ Many subdirectories needed]

    D --> D1[✓ Shortest path to target]
    D --> D2[✗ High memory usage]
    D --> D3[✗ Slower on deep trees]
```

## Algorithm Complexity

| Algorithm | Time Complexity | Space Complexity | Best For |
|-----------|----------------|------------------|----------|
| IDDFS (Sequential) | O(b^d) | O(d) | Deep, narrow trees |
| IDDFS (Concurrent) | O(b^d / p) | O(d * p) | Wide trees, multi-core |
| BFS | O(b^d) | O(b^d) | Shallow searches |

Where:
- `b` = branching factor (avg. subdirectories per directory)
- `d` = depth of solution
- `p` = number of processor cores

## Error Handling

All modern implementations include:
- Exception handling for filesystem errors
- Permission denied handling
- Invalid path handling
- Graceful degradation

## Dependencies

- C++17 or later
- Standard library `<filesystem>` support
- `<thread>` support for concurrent versions
- POSIX-compliant shell for scripts
- `lsblk`, `grep`, `awk` for shell scripts

## Suggested Improvements

### Structural Organization

Consider reorganizing the repository:

```
GPT_Enterprise_Treesearch/
├── README.md
├── LICENSE
├── Makefile
├── .gitignore
├── src/
│   ├── basic/
│   │   ├── IDDFileSearch.cpp
│   │   └── IDDFileSearch_ExceptionHandled.cpp
│   ├── advanced/
│   │   ├── IDDFileSearch_Extension.cpp
│   │   └── IDDFileSearch_Extension_Concurrent.cpp
│   └── algorithms/
│       └── BFSFileSearch.cpp
├── scripts/
│   ├── diskSelectSearch.sh
│   └── robustDiskSelectSearch.sh
├── chapel/
│   └── IterativeDeepening.chpl
├── docs/
│   └── usage_examples.md
└── bin/
    └── (compiled binaries)
```

### Additional Enhancements

1. **Add Makefile** for easier compilation
2. **Add .gitignore** to exclude binaries
3. **Performance benchmarking** suite
4. **Unit tests** for core functions
5. **Progress indicators** for long searches
6. **Result logging** to file
7. **Pattern matching** beyond extensions
8. **Symbolic link handling** options

## Contributing

When contributing, please:
1. Maintain C++17 compatibility
2. Include error handling
3. Document command-line arguments
4. Add usage examples
5. Update this README

## License

See LICENSE file for details.

## Future Work

- [ ] Implement result caching
- [ ] Add regex pattern support
- [ ] Create Python bindings
- [ ] Add progress bars
- [ ] Implement parallel BFS
- [ ] Add file content searching
- [ ] Create GUI wrapper
- [ ] Performance benchmarking suite
