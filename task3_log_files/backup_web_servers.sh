#!/bin/bash

# Define backup directory
BACKUP_DIR="/backups"
DATE=$(date +"%Y-%m-%d")

# Backup Apache server (Sarah)
APACHE_CONF="/etc/apache2"
APACHE_DOC_ROOT="/var/www/html"
APACHE_BACKUP_FILE="$BACKUP_DIR/apache_backup_$DATE.tar.gz"

tar -czf $APACHE_BACKUP_FILE $APACHE_CONF $APACHE_DOC_ROOT

# Backup Nginx server (Mike)
NGINX_CONF="/etc/nginx"
NGINX_DOC_ROOT="/usr/share/nginx/html"
NGINX_BACKUP_FILE="$BACKUP_DIR/nginx_backup_$DATE.tar.gz"

tar -czf $NGINX_BACKUP_FILE $NGINX_CONF $NGINX_DOC_ROOT

# Verify backup integrity
ls -lh $APACHE_BACKUP_FILE > $BACKUP_DIR/backup_verification.log
ls -lh $NGINX_BACKUP_FILE >> $BACKUP_DIR/backup_verification.log

# Print confirmation message
echo "Backup completed for Apache and Nginx servers on $DATE."
