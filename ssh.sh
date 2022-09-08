#!/bin/bash
if [[ -n $SSH_CONNECTION ]]; then
  #echo "Welcome remote user"
  d=`date '+%D %T'`
  if [[ ! -d $HOME/.log ]]; then
    mkdir $HOME/.log
  fi
  if [[ ! -f $HOME/.log/ssh ]]; then
    echo $d$'\n'$SSH_CONNECTION > $HOME/.log/ssh
    cp $HOME/.bash_history $HOME/.log/bashhistory
  else
    echo $d$'\n'$SSH_CONNECTION >> $HOME/.log/ssh
  fi
fi

