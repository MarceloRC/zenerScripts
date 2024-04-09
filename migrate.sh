#!/bin/bash
#options="--exclude \"Calend&AOE-rio|Itens Exclu&AO0-dos|Lixo Eletr&APQ-nico\" --notls1"
{ while IFS=';' read  h1 u1 p1 h2 u2 p2
    do
        username=$( echo $u1 | cut -d'@' -f1 )_$( echo $u1 | cut -d'@' -f2 )
        echo docker run -d --name $username gilleslamiral/imapsync imapsync --host1 $h1 --user1 $u1 --password1 $p1 --gmail2 --host2 $h2 --user2 $u2 --password2 $p2 #$options
    done
} < /home/ubuntu/zenerScripts/data.txt
