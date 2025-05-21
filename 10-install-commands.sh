#!bin/bash

USERID=$(id -u)

if [ $(USERID -ne 0)]
then
    echo "please run as root user"
else
    echo "running with root access"
    dnf install mysql -y
fi

dnf list installed mysql

if [ $? -ne 0]
then
    echo "mysql is not installed, goiing to install now"
else
    echo  "mysl is already installed"
fi