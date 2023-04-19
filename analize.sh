#!/bin/sh

dirList=(`ls -l $@ | awk '/^d/ {print $9}'`)
total=(`gfind $@ -name "*.[ch]" -type f | xargs wc --total=only -l | awk '{sum+=$1} END {print sum}'`)

echo "total: " $total

for dir in ${dirList[@]}
do
    line=(`gfind ./$@/${dir} -name "*.[ch]" -type f | xargs wc --total=only -l | awk '{sum+=$1} END {print sum}'`)
    percent=(`echo "scale=6; ${line}/${total}*100" | bc`)
    echo $dir "\t" $line "\t" $percent "%"
done
