#!/bin/bash
#QUESTION SCRIPT
#Contains templates for questions/question modules



askYesNoQuestion(){
   echo -e "${quest}"
   while true; do
      read -p "$1" yn
      case $yn in
         [Yy]* ) return 0;;
         [Nn]* ) return 1;;
         * ) echo "Please answer Y or N.";;
      esac
   done
   echo -e "${reset}"
}

askYesNoQuestionWithActions(){
   if askYesNoQuestion "$1 Would you like to $2? [y/n] "; then
      echo -e "${done}OK. You want to $2${reset}"
      sleep 1
      $3
   else
      echo -e "${error}NO. You don't want to $2${reset}"
      sleep 1
      $4
   fi
}
