#!/bin/bash
FILES="/home/*"
OUTPUT=""

for dir in $FILES
do
  if [ -f $dir/.log/ssh ] && [ -f $dir/.log/bashhistory ]; then
    OUTPUT+="${dir#/*/}"$'\n'$(cat $dir/.log/ssh)$'\n'$(diff -u $dir/.log/bashhistory $dir/.bash_history | grep -E "^\+")$'\n\n'
    rm -f $dir/.log/bashhistory $dir/.log/ssh
  fi
done

if [ -f /root/.log/ssh ] && [ -f /root/.log/bashhistory ]; then
  OUTPUT+=$'\n'"root"$'\n'$(cat /root/.log/ssh)$'\n'$(diff -u /root/.log/bashhistory /root/.bash_history | grep -E "^\+")$'\n\n'
  rm -f /root/.log/bashhistory /root/.log/ssh
fi

if [ -n "$OUTPUT" ]; then
  echo -e "To:USER@DOMAIN\nSubject:SUBJECTLINE\n\n$OUTPUT\n" | sendmail -f USER@DOMAIN -F NAMEOFUSER -it
fi

