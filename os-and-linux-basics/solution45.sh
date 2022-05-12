#!/bin/bash

echo -n "Would you like to sort the processes output by memory or CPU? (mem/cpu) "
read sortby
echo -n "How many results do you want to display? "
read lines

if [ "$sortby" = "mem" ]
then
    ps aux --sort -rss | grep -i `whoami` | head -n "$lines"
elif [ "$sortby" = "cpu" ]
then
    ps aux --sort -cpu | grep -i `whoami` | head -n "$lines"
else
    echo "No input provided. Exiting"
fi
