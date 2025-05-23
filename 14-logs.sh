#!bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER=/var/log/shellpractice
SCRIPT_NAME=$(echo $0 | cut -d "." f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

if [ $USERID -ne 0 ]
then
    echo "$R ERROR : Please proceed with root acccess$N"
    exit 1
else
    echo "$G Welcome to the root user$N" &>>LOG_FILE
fi

VALIDATE(){
    if [ $1 -ne 0 ] 
    then
        echo "$R ERROR : $2 installation was failed please check $N" &>>LOG_FILE
        exit 1
    else
        echo "$G $2 installation was successful $N"
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "$Y mysql is not instlled,please proceed to install $N"
    dnf install mysql -y &>>LOG_FILE
    VALIDATE $? "MYSQL"
else
    echo "$G mysql is already installed $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "$Y python3 is not instlled,please proceed to install $N"
    dnf install python3 -y &>>LOG_FILE
    VALIDATE $? "python3"
else
    echo "$G mypython3sql is already installed $N"
fi
