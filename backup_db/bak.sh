#!/bin/sh

if [ -z "$1" ]; then
        echo usage: run with name of catalog for database backup
        exit
fi

file=$1-$(date +%Y)-$(date +%m)-$(date +%d)

mysqldump --opt $1 | gzip > $file.dump.gz
