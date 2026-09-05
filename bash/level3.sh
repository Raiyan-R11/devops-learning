#!/bin/bash

cd Arena
if [ -f hero.txt ]; then
    echo "Hero found!"
else
    echo "Hero not found!"
fi