#!bin/bash

User_id=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if DAYS are provided that will be considered, otherwise default 14 days. Here 3 is the given days.

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER="/var/log/app-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"


mkdir -p $LOG_FOLDER

if [ $User_id -ne 0 ]
then
    echo -e "$R ERROR::Root access required $N"
else
    echo -e "$Y Hello Root user, Welcome!.$N"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R $2 is failed $N"
    else
        echo -e "$G $2 is success $N"
    fi
}

USAGE(){
    echo -e "$Y ERROR::sh 20-backup.sh <source_Dir> <Destination_Dir> <Days(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
else
    echo -e "$G Having required parameters $N"
fi

if [ -d $SOURCE_DIR ]
then
    eco -e "$G source directory:$SOURCE_DIR is available"
else
    echo -e "$R ERROR::source directory:$SOURCE_DIR is not available"
    exit 1
fi

if [ -d $DEST_DIR ]
then
    eco -e "$G Destination directory:$DEST_DIR is available"
else
    echo -e "$R ERROR::Destination directory:$DEST_DIR is not available"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES" ]
then
    echo "Files to zip are: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f $ZIP_FILE ]
    then
        echo -e "Successfully created Zip file"

        while IFS= read -r filepath
        do
            echo "Deleting file: $filepath" | tee -a $LOG_FILE
            rm -rf $filepath
        done <<< $FILES
        echo -e "Log files older than $DAYS from source directory removed ... $G SUCCESS $N"
    else
        echo -e "Zip file creation ... $R FAILURE $N"
        exit 1
    fi
else
    echo -e "No log files found older than 14 days ... $Y SKIPPING $N"
fi

