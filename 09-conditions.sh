#!bin/bash

Number=1

# -gt --> greater than
# -lt --> less than
# -eq --> equal
# -ne --> not equal

if [ $Number -lt 100 ]
then
    echo "given $Number is lessthan 100"
else
    ech0 "given $Number is greater thean 100"
fi