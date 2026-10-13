# Makefile for converting SCAD to STL using Docker

# Current working directory and user ID/GID for Docker volume mapping
CWD := $(shell pwd)
UID := $(shell id -u)
GID := $(shell id -g)

# Find all .scad files in immediate subdirectories
SRCS := $(wildcard */*.scad)
# Exclude library files that shouldn't be built directly
EXCLUDE := disk_pair/disk_pair.scad disk_pair/ziptie.scad
SRCS := $(filter-out $(EXCLUDE), $(SRCS))
# Define corresponding .stl targets
OBJS := $(SRCS:.scad=.stl)

.PHONY: all clean

all: $(OBJS)

# Rule to convert .scad to .stl
# Only runs if the .scad file is newer than the .stl file or .stl doesn't exist
%.stl: %.scad
	@echo "converting $< to $@..."
	@docker run --rm -v "$(CWD)":/openscad -w /openscad -u $(UID):$(GID) openscad/openscad:latest openscad -o "$@" "$<"

clean:
	rm -f $(OBJS)
