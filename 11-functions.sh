#!bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR : Please run with root access"
    exit 1
else
    echo "Running with root access"
fi

VALIDATE(){

    if [ $1 -eq 0 ]
    then
        echo "installation $2 was successdul"        #Here $? is 1st variable ($?) and mysql is 2nd variable ($2)
    else 
        echo "ERROR : installation  $2 was failure"
        exit 1
    fi

}


dnf list installed mysql

if [ $? -eq 0 ]
then 
    echo "mysql is already installed....no need to install now"
else
    echo "mysql is not installed....going to install now"

    dnf install mysql -y
    VALIDATE $? "mysql"         #Here $? is 1st variable ($?) and mysql is 2nd variable ($2)  
fi

dnf list installed python3

if [ $? -eq 0 ]
then
    echo "python3 is already installed"
else
    echo "python is not installed, goint to install now"

    dnf install python3 -y
    VALIDATE $? "python3"
fi
