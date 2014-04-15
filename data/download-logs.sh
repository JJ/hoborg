#!/bin/bash

for i in {1..265}
do
    travis logs $i > log-$i.log
done
