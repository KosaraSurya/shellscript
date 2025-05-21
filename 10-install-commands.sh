#!bin/bash

USRID=(id -u)

if [ $(USRID -ne 0)]
then
    echo "please run as root user"
else
    echo "running with root access"
    dnf install mysql
fi