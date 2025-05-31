#!bin/bash

a=10
while [ $a -lt 30 ]
do
    echo $a
    a='expr $a + 1'
done



#shvia example
# a=0

# while [ $a -lt 10 ]
# do
#    echo $a
#    a=`expr $a + 1`
# done