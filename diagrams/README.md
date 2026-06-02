# Diagrams — enterprise-document-treesearch

Architecture and design diagrams for this repository, authored in Graphviz DOT and
rendered to PNG (140 dpi) and SVG. Sources are version-controlled so the diagrams can be
regenerated and reviewed in diffs.

## Index

| # | Diagram | What it shows |
|---|---------|---------------|
| 01 | [Architecture](01_architecture.png) | Build/CI, interface, binaries, algorithm core, platform layers |
| 02 | [Algorithm comparison](02_algorithm_comparison.png) | IDDFS vs BFS — memory, revisits, when each wins |
| 03 | [IDDFS control flow](03_iddfs_control_flow.png) | Depth-limited DFS repeated with increasing limit |
| 04 | [Variant progression](04_variant_progression.png) | The six programs as a deliberate evolution |
| 05 | [Concurrency model](05_concurrency_model.png) | Parallel subtree search + the I/O-contention caveat |
| 06 | [Disk I/O handling](06_disk_io_handling.png) | Disk selection → traversal → kernel/storage path |
| 07 | [Build & CI pipeline](07_build_ci_pipeline.png) | Local make flow + GitHub Actions |
| 08 | [Lessons learned](08_lessons_learned.png) | Observations mapped to concrete lessons |
| 09 | [Future directions](09_future_directions.png) | Consolidate / capability / performance / credibility |
| 10 | [Runtime data flow](10_runtime_data_flow.png) | One search invocation, end to end |

## Regenerate

```bash
# Requires graphviz (apt-get install graphviz)
for f in *.dot; do
  dot -Tpng -Gdpi=140 "$f" -o "${f%.dot}.png"
  dot -Tsvg          "$f" -o "${f%.dot}.svg"
done
```

> Note: diagrams describe the algorithmic/design model. Concurrency and data-flow are shown
> at the conceptual level; verify against the source before citing exact implementation details.
