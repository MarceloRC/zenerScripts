#!/bin/bash
now=$(date +'%Y%m%d')

while read -r line; do
    touch bucket_sizes_${now}.log
    echo "authorizing ${line}"
    b2 authorize-account $line 
    b2 list-buckets > buckets_${now}.txt
    while read -r linebucket; do
        bucket=$(echo ${linebucket} | cut -f3 -d" ")
        b2 get-bucket --showSize $bucket >> bucket_sizes_${now}.log
    done < buckets_${now}.txt

done < accounts.txt
