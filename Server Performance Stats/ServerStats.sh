#!/bin/bash

echo "========================================"
echo "        Server Performance Stats"
echo "========================================"
echo

### CPU USAGE ###
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
printf "Total CPU Usage: %.2f%%\n\n" "$CPU_USAGE"

### MEMORY USAGE ###
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_USED_PCT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")
MEM_FREE_PCT=$(awk "BEGIN {printf \"%.2f\", ($MEM_FREE/$MEM_TOTAL)*100}")

echo "Memory Usage:"
echo "  Total: ${MEM_TOTAL} MB"
echo "  Used : ${MEM_USED} MB (${MEM_USED_PCT}%)"
echo "  Free : ${MEM_FREE} MB (${MEM_FREE_PCT}%)"
echo

### DISK USAGE ###
DISK_TOTAL=$(df -h --total | awk '/total/ {print $2}')
DISK_USED=$(df -h --total | awk '/total/ {print $3}')
DISK_FREE=$(df -h --total | awk '/total/ {print $4}')
DISK_USED_PCT=$(df -h --total | awk '/total/ {print $5}')

echo "Disk Usage:"
echo "  Total: $DISK_TOTAL"
echo "  Used : $DISK_USED ($DISK_USED_PCT)"
echo "  Free : $DISK_FREE"
echo

### TOP PROCESSES BY CPU ###
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

### TOP PROCESSES BY MEMORY ###
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

echo "========================================"
