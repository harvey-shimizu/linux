#!/bin/zsh

total=(`find $@ -name "*.[ch]" -type f | xargs wc --total=only -l | awk '{sum+=$1} END {print sum}'`)
echo "total: " $total

files=(`find $@ -maxdepth 1 -name "*.[ch]" -type f | xargs wc --total=only -l | awk '{sum+=$1} END {print sum}'`)
percent=(`echo "scale=7; ${files}/${total}*100" | bc`)
echo "." $files "\t" $percent

dirList=(`ls -l $@ | awk '$0~/^d/ && $9~/\<[a-z]/ {print $9}'`)
for dir in ${dirList[@]}
do
    line=(`find $@/${dir} -name "*.[ch]" -type f | xargs wc --total=only -l | awk '{sum+=$1} END {print sum}'`)
    percent=(`echo "scale=7; ${line}/${total}*100" | bc`)
    echo $dir "\t" $line "\t" $percent
done
