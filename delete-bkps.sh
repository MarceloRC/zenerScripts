#!/bin/bash

# Deleter backups com mais de 5 dias criados
find /home/ubuntu/bkp/ -type f -mtime +5 -delete
