#!/bin/bash
FILES="/home/*"
OUTPUT=""

for dir in $FILES
do
  if [ -f $dir/.log/ssh ] && [ -f $dir/.log/bashhistory ]; then
    OUTPUT+=$(cat $dir/.log/ssh)
    OUTPUT+=$'\n'
    OUTPUT+=$(diff -u $dir/.log/bashhistory $dir/.bash_history | grep -E "^\+")
    rm -f $dir/.log/bashhistory $dir/.log/ssh
  fi
done

if [ -f /root/.log/ssh ] && [ -f /root/.log/bashhistory ]; then
  OUTPUT+=$'\n'
  OUTPUT+=$(cat /root/.log/ssh)
  OUTPUT+=$'\n'
  OUTPUT+=$(diff -u /root/.log/bashhistory /root/.bash_history | grep -E "^\+")
  rm -f /root/.log/bashhistory /root/.log/ssh
fi

if [ -n "$OUTPUT" ]; then
  echo -e "To:USER@DOMAIN\nSubject:SUBJECTLINE\n\n$OUTPUT\n" | sendmail -f USER@DOMAIN -F NAMEOFUSER -it
fi

