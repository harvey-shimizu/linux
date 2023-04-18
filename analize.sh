#!/bin/sh

dirList=(`ls -lga | grep ^d | awk '{print $8}' | tail -n +6`)
#echo ${dirList[@]}

total=(`gfind . -regex \.\/.*\.[ch] -type f | xargs wc --total=only -l | awk '{x+=$1} END {print x}'`)
echo "total: " $total
for dir in ${dirList[@]}
do
    line=(`gfind . -regex \.\/\${dir}.*\.[ch] -type f | xargs wc --total=only -l | awk '{x+=$1} END {print x}'`)
    #echo $dir "\t" $line "\t" $(`awk '{print ($line/$total)}'`)
    percent=(`echo "scale=6; ${line}/${total}*100" | bc`)
    echo $dir "\t" $line "\t" $percent "%"
done
#sorted=( $( printf "%s\n"  "${line[@]}" | sort -n -r -k 2) )
#echo ${sorted[@]}
