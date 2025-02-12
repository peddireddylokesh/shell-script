#!/bin/bash

while read -r line;
do
	echo $line
done < delete_old_logs.sh
 ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "Successfully created zip file for files older than $DAYS"
        while read -r filepath # here filepath is the variable name, you can give any name
        do
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleted file: $filepath"
        done <<< $FILES
    else
        echo -e "$R Error:: $N Failed to create ZIP file "
        exit 1
    fi