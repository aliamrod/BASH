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
