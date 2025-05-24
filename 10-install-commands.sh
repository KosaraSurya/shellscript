#!bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR : Please run as root acess"
    exit 1
else
    echo "running with root access"
fi

dnf list installed mysql
if [ $? -eq 0 ]
then 
    echo "mysql is already installed in your system"
else
    echo  "mysl is goin to install"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "installed successfully"
    else   
        echo "ERROR : installaion failurre"
        exit 1
    fi 
fi