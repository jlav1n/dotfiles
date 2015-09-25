#!/bin/sh

if [ -z "$1" ]; then
	echo usage: run with name of catalog and table for database backup
	exit
fi

file=$1-$2-$(date +%Y)-$(date +%m)-$(date +%d)

mysqldump --opt $1 $2 | gzip > $file.dump.gz
