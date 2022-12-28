#!/bin/bash
echo "Performing backup"
# Backup

cd /opt/minecraft/backups

# Delete file older than 30 days
find ./*.tar.gz -mtime +30 -exec rm {} \;

NOW=$(date +"%Y-%m-%d")
tar -cpvzf /opt/minecraft/backups/minecraft-$NOW.tar.gz /opt/minecraft/server/world /opt/minecraft/server/world_nether /opt/minecraft/server/world_the_end

aws s3 cp /opt/minecraft/backups/minecraft-$NOW.tar.gz s3://086133709882-minecraft-backup-1/minecraft-$NOW.tar.gz

# Done
echo "Backup complete."