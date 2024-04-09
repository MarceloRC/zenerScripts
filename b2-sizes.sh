#!/bin/bash
now=$(date +'%Y%m%d')

touch /home/ubuntu/zenerScripts/buckets_${now}.txt
touch /home/ubuntu/zenerScripts/bucket_sizes_name_${now}.log

while IFS=';' read -r v1 v2 v3; do
    touch /home/ubuntu/zenerScripts/bucket_sizes_${now}.log
    echo "authorizing ${v1} ${v2} ${v3} " 
    b2 authorize-account $v1 $v2 
    b2 list-buckets > /home/ubuntu/zenerScripts/buckets_${now}.txt
    while read -r linebucket; do
        bucket=$(echo ${linebucket} | cut -f3 -d" ") 
        b2 get-bucket --showSize $bucket >> /home/ubuntu/zenerScripts/bucket_sizes_${now}.log
    done < /home/ubuntu/zenerScripts/buckets_${now}.txt

done < /home/ubuntu/zenerScripts/accounts.txt

cat /home/ubuntu/zenerScripts/bucket_sizes_${now}.log | grep -e bucketName -e totalSize >> /home/ubuntu/zenerScripts/bucket_sizes_name_${now}.log
