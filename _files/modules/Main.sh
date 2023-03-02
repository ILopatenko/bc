#!/bin/bash
#MAIN MENU MODULE

source ./_files/helpers/questions.sh
source ./_files/helpers/actions.sh
source ./_files/modules/Private.sh
source ./_files/modules/Server.sh



#MAIN MENU TITLES
mtT="                     "
mt0="MAIN MENU${resUnd}            "
mt1="UPDATE AND UPGRADE   "
mt2="SETUP UBUNTU SERVER  "
mt3="SETUP DESKTOP/LAPTOP "
mt4="DOCKER STACK AND APPS"
mt5="MY PERSONAL SETTINGS "

res="${GrayDT}       RESERVED      "

#MAIN MENU QUESTIONS
Q01="update and upgrade your system"
Q011="see the command output"
Q02="setup your ORACLE server"
Q03="setup your local server"
Q04="setup your desktop/laptop"
Q05="setup VPN Netmaker"
Q06="install Docker Stack"
Q07="install Docker Apps"

#MAIN MENU QUESTION MODULES
QM01(){
   askYesNoQuestionWithActions "1." "$Q01" QM011
}
QM011(){
   askYesNoQuestionWithActions "1.1." "$Q011" updateUpgrade updateUpgradeSilent
}
QM02(){
   askYesNoQuestionWithActions "2." "$Q02" serverMain
}
QM03(){
   askYesNoQuestionWithActions "3." "$Q03" desktopMain
}
QM04(){
   askYesNoQuestionWithActions "4." "$Q04" dockerMain
}
QM05(){
   askYesNoQuestionWithActions "5." "$Q05" privateMain
}

renderMainMenu(){
   dropLineStyles
   declare -n activeLine=sl$1
   declare -n questionModule=QM0$1
   activeLine=${YellowB}${BlackT}${bold}
   printDefaultMenu7Lines "0." "$mt0" "$mt1" "$mt2" "$mt3" "$mt4" "$mt5" "$res" "$res"
   QM0$1
}