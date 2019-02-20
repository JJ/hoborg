#!/bin/bash

for i in $(seq 1 $1)
do
    travis logs $i > log-$i.log
done
