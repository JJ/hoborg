#!/bin/bash

for i in $(seq $1 $2)
do
    travis logs $i > log-$i.log
done
