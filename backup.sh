#!/bin/bash

log_file="backup_log.txt"
backup_limit=5

#user inputs
echo "=== AUTOMATED BACKUP SCRIPT ==="

read -p "Enter directory to backup: " source
read -p "Enter backup destination: " dest

if [ ! -d "$source" ]; then
    echo "Error: Source directory '$source' does not exist."
    exit 1
fi

mkdir -p "$dest"

#choose type of copy
echo ""
echo "Backup Type:"
echo "1. Simple copy"
echo "2. Compressed archive (tar.gz)"
read -p "Enter choice (1 or 2): " type_choice

timestamp=$(date +%Y%m%d_%H%M%S)
backup_name="backup_$timestamp"
start_time=$(date +%s)

#displaying progress
echo ""
echo "[*] Starting backup..."
echo "[*] Source: $source"
echo "[*] Destination: $dest"

if [ "$type_choice" == "1" ]; then
    echo "[*] Performing simple copy..."
    cp -r "$source" "$dest/$backup_name"
    success=$?
    final_path="$dest/$backup_name"
elif [ "$type_choice" == "2" ]; then
    echo "[*] Creating compressed archive..."
    tar -czf "$dest/$backup_name.tar.gz" -C "$(dirname "$source")" "$(basename "$source")"
    success=$?
    final_path="$dest/$backup_name.tar.gz"
else
    echo "Invalid."
    exit 1
fi

# time calculation
end_time=$(date +%s)
duration=$((end_time - start_time))

if [ $success -eq 0 ]; then
    size=$(du -sh "$final_path" | awk '{print $1}')
    
    echo -e "\nBackup successful"
    echo "---------------------------"
    echo "Backup Details:"
    echo "File: $(basename "$final_path")"
    echo "Location: $dest"
    echo "Size: $size"
    echo "Time taken: $duration seconds"
    echo "---------------------------"

    echo "[$timestamp] SUCCESS: Source: $source | Size: $size | Duration: ${duration}s" >> "$log_file"

    echo "[*] Checking backup rotation..."
    ls -dt "$dest"/backup_* 2>/dev/null | tail -n +$((backup_limit + 1)) | xargs -r rm -rf
else
    echo -e "\nBackup failed!"
    echo "[$timestamp] FAILED: Source: $source" >> "$log_file"
fi