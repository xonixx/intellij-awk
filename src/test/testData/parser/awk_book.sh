#!/bin/bash

cd awk_book
(( n=0 ))
> ../awk_book.txt
for f in *
do
  newF="test${n}.awk"
  echo "$n;$newF;$f" >> ../awk_book.txt
  mv "$f" "$newF"
  (( n++ ))
done