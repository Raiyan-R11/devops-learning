#!/bin/bash

if [ -d Battlefield ]; then
	rm -r Battlefield
fi
if [ -d Archive ]; then
	rm -r Archive
fi

mkdir Battlefield
cd Battlefield

touch knight.txt sorcerer.txt rogue.txt

if [ -f knight.txt ]; then
	mkdir ../Archive
	mv knight.txt ../Archive/knight.txt
fi

cd ..
echo -e "Contents of Battlefield: \n$(ls Battlefield)"
if [ -d Archive ]; then
	echo -e "Contents of Archive: \n$(ls Archive)"
fi