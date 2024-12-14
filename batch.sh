#!/bin/sh

INPUT_DIR="/input"
OUTPUT_DIR="/output"

# Determine NUM_PROCESSES
if [ -z "$NUM_PROCESSES" ]; then
  CPU_QUOTA=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us 2>/dev/null || echo -1)
  CPU_PERIOD=$(cat /sys/fs/cgroup/cpu/cpu.cfs_period_us 2>/dev/null || echo 100000)

  if [ "$CPU_QUOTA" -gt 0 ]; then
    # Round up the result of CPU_QUOTA / CPU_PERIOD
    NUM_PROCESSES=$(( (CPU_QUOTA + CPU_PERIOD - 1) / CPU_PERIOD ))
  else
    # If no limits are set, use nproc
    NUM_PROCESSES=$(nproc)
  fi
fi

# Ensure NUM_PROCESSES is at least 1
if [ "$NUM_PROCESSES" -lt 1 ]; then
  NUM_PROCESSES=1
fi

# Export OUTPUT_DIR so it's accessible inside the subshell
export OUTPUT_DIR

# Find all .jpg and .jpeg files (case-insensitive), process in parallel
find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) | \
xargs -P "$NUM_PROCESSES" -I {} sh -c '
  filename="$(basename "{}")"
  cjpeg "$@" "{}" > "$OUTPUT_DIR/$filename"
' _ "$@"
