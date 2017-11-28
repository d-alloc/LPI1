#!/usr/bin/env bash
#Author: Roei Kessler - D-Alloc
#Description: Waits for 2.8 seconds and create a file from a to z <example file_a>
#Version: 1
#Date: 28-11-17
for i in {a..z}
do
	sleep 2.8
	touch file_$i
done
ls -l

