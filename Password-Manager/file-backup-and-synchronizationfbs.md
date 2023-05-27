```bash
#!/bin/bash

# Configuration variables
SOURCE_DIR= "/Users/aliamahama-rodriguez/source_dir"    #"/path/to/source_directory"
DEST_DIR= "/Users/aliamahama-rodriguez/destination_dir" #"/path/to/destination_directory"                                 
SCHEDULE="0 1 * * *"                                    # Cron schedule expression (every day at 1 AM)
INCREMENTAL_BACKUP=false
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


```

To use this script, the configuration variables are modified at the beginning of the script according to the requirements. Here is a brief explanation of each variable I have created:
‣ **`SOURCE_DIR`**: The directory path of the files and directories you want to back up.

‣ **`DEST_DIR`**: The destination directory where you want to store the backup.

‣ **`SCHEDULE`**: The cron schedule expression defining when the script should run automatically. The example provided is set to run every day at 1:00:00 AM. Users can modify it as per their needs.

‣ **`INCREMENTAL_BACKUP`**: Set it to **`true`** if you want to perform incremental backups, which only copy the changes since the last backup. Set it to **`false`** for full backups each time.

‣ **`ENCRYPTION`**: Set it to **`true`** if you want to encrypt the backup files. You will neeed to add the encryption logic in the **`perform_backup`** function.

Users can save the script in a file, e.g. **`backup_script.sh`**, and make it executable using the following command:
```bash
chmod +x backup_script.sh
```

To run the script manually, use:
```bash
./backup_script.sh
```

To schedule the script for automated backups, one could also implement an entry to the crontab using the **`crontab -e`** command and append the following line:
```bash
0 1 * * * /path/to/backup_script.sh scheduled
```

This will execute the script at 1:00:00 AM every day.

* Note: Make sure you have the necessary permissions to read the source directory and write to the destination directory. Additionally, if you plan to use encryption, you will need to implement the encryption logic based on your preferred method (e.g., GPG, OpenSSL).


