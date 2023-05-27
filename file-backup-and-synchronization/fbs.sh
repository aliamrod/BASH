# FILE BACKUP AND SYNCHRONIZATION
# Script constructed to automate the backup and synchronization of files and directories to a remote location
# or cloud storage, with options for scheduling, incremenetal backups, and encryption.

#! /bin/bash

# Configuration variables
SOURCE_DIR="/Users/aliamahama-rodriguez/source_dir" # /path/to/source_directory
DEST_DIR="/Users/aliamahama-rodriguez/destination_dir" # /path/to/destination_directory
SCHEDULE="0 1 * * " # Cron schedule expression (every day at 1 AM)
INCREMENETAL_BACKUP=false
ENCRYPTION=false

# Function to perform backup and synchronization
perform_backup() {
  echo "Starting backup and synchronization..."
  
  if [ "$INCREMENTAL_BACKUP" = true ]; then
        rsync -avz --progress --delete --link-dest="$DEST_DIR/previous_backup" "$SOURCE_DIR" "$DEST_DIR/latest_backup"
    else
        rsync -avz --progress --delete "$SOURCE_DIR" "$DEST_DIR/latest_backup"
    fi
    
    if [ "$ENCRYPTION" = true ]; then
        # Add encryption logic here
        echo "Encrypting backup files..."
    fi
    
    # Update the previous backup to latest backup
    mv "$DEST_DIR/latest_backup" "$DEST_DIR/previous_backup"
    
    echo "Backup and synchronization completed."
}

# Check if the script is scheduled or run manually
if [ "$1" = "scheduled" ]; then
    # Check if the current time matches the schedule
    if [ "$(date +'%-M %-H %-d %-m *')" = "$SCHEDULE" ]; then
        perform_backup
    else
        echo "Scheduled backup not due yet."
    fi
else
    # Run the backup manually
    perform_backup
fi
