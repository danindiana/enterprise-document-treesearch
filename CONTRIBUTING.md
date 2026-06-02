# Contributing to Enterprise Document Tree Search

Thank you for your interest in contributing to this project! This document provides guidelines and information for contributors.

## Development Setup

### Prerequisites

- C++17 compatible compiler (GCC 7+, Clang 5+, or MSVC 2017+)
- Make (optional, for using Makefile)
- Chapel compiler (optional, for Chapel implementations)
- Git for version control

### Building the Project

```bash
# Clone the repository
git clone https://github.com/yourusername/enterprise-document-treesearch.git
cd enterprise-document-treesearch

# Build all implementations
make

# Or build just the main versions
make quick

# Make scripts executable
make scripts
```

## Code Style Guidelines

### C++ Code

1. **C++ Standard**: Use C++17 features
2. **Naming Conventions**:
   - Functions: PascalCase (e.g., `DLS`, `IDDFS`)
   - Variables: camelCase (e.g., `currentPath`, `maxDepth`)
   - Constants: UPPER_SNAKE_CASE (e.g., `MAX_DEPTH`)

3. **Error Handling**:
   - Always use try-catch blocks for filesystem operations
   - Provide meaningful error messages
   - Handle edge cases (permissions, non-existent paths, etc.)

4. **Comments**:
   - Document complex algorithms
   - Explain non-obvious design decisions
   - Keep comments up-to-date with code changes

### Example Code Structure

```cpp
#include <iostream>
#include <filesystem>
#include <string>

// Brief description of function
// @param currentPath: Path to search in
// @param target: File/extension to find
// @param depth: Current search depth
// @return: true if found, false otherwise
bool DLS(const std::filesystem::path& currentPath,
         const std::string& target,
         int depth) {
    try {
        // Implementation
    }
    catch (const std::filesystem::filesystem_error& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return false;
    }
}
```

## Adding New Features

### Before Starting

1. Check existing issues and pull requests
2. Open an issue to discuss major changes
3. Fork the repository
4. Create a feature branch

### Development Process

1. **Write Tests**: If adding testable functionality
2. **Document**: Update README.md with new features
3. **Comment**: Add inline documentation
4. **Compile**: Ensure code compiles without warnings
5. **Test**: Test with various inputs and edge cases

### Example Workflow

```bash
# Create feature branch
git checkout -b feature/add-regex-support

# Make changes
# ... edit files ...

# Test compilation
make clean && make

# Test functionality
./IDDFileSearch_Extension .pdf /tmp 3

# Commit changes
git add .
git commit -m "Add regex pattern matching support"

# Push to your fork
git push origin feature/add-regex-support

# Create pull request
```

## Types of Contributions

### 1. Bug Fixes

- Fix compilation errors
- Resolve runtime errors
- Handle edge cases
- Improve error messages

### 2. Performance Improvements

- Optimize algorithms
- Reduce memory usage
- Improve multi-threading
- Add caching mechanisms

### 3. New Features

- Additional search algorithms
- New search criteria (size, date, content)
- GUI wrapper
- Result formatting options
- Progress indicators

### 4. Documentation

- Improve README
- Add usage examples
- Create tutorials
- Document algorithms
- Add code comments

### 5. Testing

- Unit tests
- Integration tests
- Performance benchmarks
- Edge case testing

## Contribution Checklist

Before submitting a pull request:

- [ ] Code compiles without errors or warnings
- [ ] Code follows project style guidelines
- [ ] New features are documented in README.md
- [ ] Error handling is implemented
- [ ] Code has been tested with various inputs
- [ ] Commit messages are clear and descriptive
- [ ] No compiled binaries are committed
- [ ] Changes are backwards compatible (or breaking changes are documented)

## Pull Request Process

1. **Update Documentation**: Ensure README.md and relevant docs are updated
2. **Test Thoroughly**: Test on different systems if possible
3. **Describe Changes**: Provide clear description in PR
4. **Link Issues**: Reference related issues
5. **Be Responsive**: Address review comments promptly

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Performance improvement
- [ ] Documentation update

## Testing
Describe how you tested the changes

## Checklist
- [ ] Code compiles without warnings
- [ ] Documentation updated
- [ ] Tested with various inputs
```

## Algorithm Implementation Guidelines

### When Adding New Search Algorithms

1. **Create Descriptive Names**: Use clear, descriptive filenames
2. **Follow Patterns**: Follow existing implementation patterns
3. **Add to Makefile**: Update Makefile with new target
4. **Document Complexity**: Include time/space complexity
5. **Provide Examples**: Add usage examples to README

### Performance Considerations

- Document algorithmic complexity
- Explain trade-offs (memory vs speed)
- Consider different filesystem types
- Test with large directory trees
- Profile performance-critical code

## Code Review Guidelines

### For Reviewers

- Be constructive and respectful
- Focus on code quality and correctness
- Check for potential bugs and edge cases
- Verify documentation is updated
- Test the changes if possible

### For Contributors

- Respond to feedback promptly
- Don't take criticism personally
- Ask for clarification if needed
- Make requested changes or explain why not

## Reporting Issues

### Bug Reports

Include:
- Operating system and version
- Compiler version
- Command used
- Expected vs actual behavior
- Error messages
- Steps to reproduce

### Feature Requests

Include:
- Use case description
- Proposed implementation approach
- Potential challenges
- Alternatives considered

## Questions?

- Open an issue for questions
- Check existing issues and documentation first
- Be specific and provide context

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

Thank you for contributing!
