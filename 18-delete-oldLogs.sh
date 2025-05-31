#!bin/bash

User_id=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER="/var/log/app-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

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

mkdir -p $LOG_FOLDER

FILES_TO_DELETE=$(find . -name"*.log" -mtime +14)
VALIDATE $? "deleting old log files"

while IFS= read -r filepath
do
    rm -rf $filepath
done >>> $FILES_TO_DELETE

echo -e "$G SUCCESS:: Script executes successfully$N"
