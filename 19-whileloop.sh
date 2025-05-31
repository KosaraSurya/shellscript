#!bin/bash

Number=10
while [ $Number -lt 30 ]
do
    echo $Number
    Number='expr $Number+1'
done



#shvia example
# a=0

# while [ $a -lt 10 ]
# do
#    echo $a
#    a=`expr $a + 1`
# done