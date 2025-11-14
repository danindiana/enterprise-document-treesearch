# Makefile for GPT Enterprise Tree Search
# Compiler settings
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
THREAD_FLAGS = -pthread

# Chapel compiler
CHPL = chpl

# Target executables
TARGETS = IDDFileSearch \
          IDDFileSearch_ExceptionHandled \
          IDDFileSearch_CmdLine \
          IDDFileSearch_Extension \
          IDDFileSearch_Extension_Concurrent \
          BFSFileSearch

# Chapel target
CHAPEL_TARGET = IterativeDeepening

# Default target
all: $(TARGETS)

# Individual targets
IDDFileSearch: IDDFileSearch.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

IDDFileSearch_ExceptionHandled: IDDFileSearch_ExceptionHandled.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

IDDFileSearch_CmdLine: IDDFileSearch_CmdLine.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

IDDFileSearch_Extension: IDDFileSearch_Extension.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

IDDFileSearch_Extension_Concurrent: IDDFileSearch_Extension_Concurrent.cpp
	$(CXX) $(CXXFLAGS) $(THREAD_FLAGS) $< -o $@

BFSFileSearch: BFSFileSearch.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Chapel compilation (optional, requires Chapel compiler)
chapel: $(CHAPEL_TARGET)

$(CHAPEL_TARGET): IterativeDeepening.chpl
	@if command -v $(CHPL) >/dev/null 2>&1; then \
		$(CHPL) $< -o $@; \
	else \
		echo "Chapel compiler not found. Skipping Chapel compilation."; \
	fi

# Build only the most useful versions
quick: IDDFileSearch_Extension IDDFileSearch_Extension_Concurrent BFSFileSearch

# Clean build artifacts
clean:
	rm -f $(TARGETS) $(CHAPEL_TARGET)
	rm -f *.o *.obj
	rm -f core core.*
	rm -f *~

# Install targets to /usr/local/bin (requires sudo)
install: all
	@echo "Installing to /usr/local/bin (requires sudo privileges)"
	sudo cp $(TARGETS) /usr/local/bin/
	@echo "Installation complete"

# Uninstall from /usr/local/bin
uninstall:
	@echo "Removing from /usr/local/bin (requires sudo privileges)"
	sudo rm -f $(addprefix /usr/local/bin/,$(TARGETS))
	@echo "Uninstallation complete"

# Test compilation (compile but don't install)
test: all
	@echo "Testing IDDFileSearch_Extension..."
	@./IDDFileSearch_Extension 2>&1 | grep -q "Usage:" && echo "✓ IDDFileSearch_Extension OK" || echo "✗ IDDFileSearch_Extension failed"
	@echo "Testing BFSFileSearch..."
	@./BFSFileSearch 2>&1 | grep -q "Usage:" && echo "✓ BFSFileSearch OK" || echo "✗ BFSFileSearch failed"

# Make shell scripts executable
scripts:
	chmod +x diskSelectSearch.sh robustDiskSelectSearch.sh

# Help target
help:
	@echo "GPT Enterprise Tree Search - Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all      - Build all C++ implementations (default)"
	@echo "  quick    - Build only the most useful versions"
	@echo "  chapel   - Compile Chapel implementation (requires chpl)"
	@echo "  clean    - Remove all built executables and object files"
	@echo "  install  - Install executables to /usr/local/bin (requires sudo)"
	@echo "  uninstall- Remove executables from /usr/local/bin (requires sudo)"
	@echo "  test     - Compile and run basic tests"
	@echo "  scripts  - Make shell scripts executable"
	@echo "  help     - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make           # Build all C++ programs"
	@echo "  make quick     # Build only main versions"
	@echo "  make clean     # Clean build artifacts"
	@echo "  make scripts   # Make shell scripts executable"

.PHONY: all quick chapel clean install uninstall test scripts help
