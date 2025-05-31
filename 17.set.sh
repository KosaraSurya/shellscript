#!bin/bash

set -e  #setting error

echo "hello world"
echooooo "good morning" #generally shell script will not stop executing after error.
echo "welcome to hyderabad" #If we want to stop executing at the time of error, we have to mention set -e