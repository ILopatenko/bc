#!/bin/bash
#Private MENU MODULE

source ./_files/helpers/questions.sh
source ./_files/helpers/actions.sh

privateMain(){

   for i in {1..2}; do
      renderPrivateMenu $i
   done
}

#MAIN MENU TITLES
mtT="                     "
mt50="PRIVATE MENU${resUnd}         "
mt51="CONNECT DISKS        "
mt52="INSTALL KEYBOARD SOFT"
mt53="SETUP DESKTOP/LAPTOP "
mt54="DOCKER STACK AND APPS"
mt55="MY PERSONAL SETTINGS "

res="${GrayDT}       RESERVED      "

#MAIN MENU QUESTIONS
Q51="connect disks"
Q511="connect all the disks: local + NFS"
Q512="connect all the local disks"
Q513="connect all the LAN NFS shares"
Q514="connect ryzen2ter as shared storage"

Q52="install openRGB for EVGA Z15 keyboard"
Q53="install openRGB for EVGA Z15 keyboard"
Q54="setup your desktop/laptop"
Q55="setup VPN Netmaker"
Q56="install Docker Stack"
Q57="install Docker Apps"

#MAIN MENU QUESTION MODULES
QM51(){
   askYesNoQuestionWithActions "1." "$Q51" QMDisks
}

QMDisks(){
   askYesNoQuestionWithActions "1.1." "$Q511" allTheStorages
   askYesNoQuestionWithActions "1.2." "$Q512" localDisks
   askYesNoQuestionWithActions "1.3." "$Q513" lanNFSAll
   askYesNoQuestionWithActions "1.4." "$Q514" lanNFSryzen2ter
}


QM52(){
   askYesNoQuestionWithActions "2." "$Q52" evgaZ15
}
QM53(){
   askYesNoQuestionWithActions "3." "$Q53" desktopMain
}
QM54(){
   askYesNoQuestionWithActions "4." "$Q54" dockerMain
}
QM55(){
   askYesNoQuestionWithActions "5." "$Q55" privateMain
}

renderPrivateMenu(){
   dropLineStyles
   declare -n activeLine=sl$1
   declare -n questionModule=QM5$1
   activeLine=${YellowB}${BlackT}${bold}
   printDefaultMenu7Lines "5." "$mt50" "$mt51" "$mt52" "$res" "$res" "$res" "$res" "$res"
   QM5$1
}