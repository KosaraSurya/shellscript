#bin/bash

Number1=$1
Number2=$2

TIMESTAMP=$(date)

echo "script bun at $TIMESTAMP"
echo "Sum = $(($Number1+$Number2))"