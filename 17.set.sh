#!bin/bash

#setting error, If we want to stop executing at the time of error, we have to mention set -e
set -e
#But set command will not give proper error discription to get it, we will use trap command along with set command

failure(){
    echo "failed at $1 $2"
}

trap 'failure "${LINENO}" "{BASH_COMMAND}"' ERR

#Here LINENO, BASH_COMMAND are special variables and ERR is the error signal

echo "hello world"
echooooo "good morning" #generally shell script will not stop executing after error.
echo "welcome to hyderabad" #but 