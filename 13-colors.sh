#!bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR : Please process with root access $N"
    exit 1
else
    echo -e "$G access granted please procees $N"
fi

Validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R ERROR : installation was failed $N"
        exit 1
    else
        echo -e "$G installatio was successful $N"
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo -e "$R ERROR : mysql is not installed $N"
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo -e "$G mysql is already installled $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
     echo -e "$R ERROR : python3 is not installed $N"
     dnf install python3 -y
     VALIDATE $? "python3"
else
    echo -e "$G python3 is already installled $N"
fi
