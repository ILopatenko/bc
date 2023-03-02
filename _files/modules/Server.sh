#!/bin/bash
#SERVER MENU MODULE

source ./_files/helpers/questions.sh
source ./_files/helpers/actions.sh

serverMain(){

   for i in {1..6}; do
      renderServerMenu $i
   done
}

#MAIN MENU TITLES
mtT="                     "
mt20="SERVER MENU${resUnd}          "
mt21="PREPARE ORACLE SERVER"
mt22="SSH TO ORACLE SERVER "
mt23="INSTALL INITIAL SOFT "
mt24="CONNECT COMMON SHARE "
mt25="INSTALL NETMAKER     "
mt26="INSTALL DOCKER/DAPPS "


res="${GrayDT}       RESERVED      "

#MAIN MENU QUESTIONS
Q21="prepare your new Oracle Server (check SSH keys, SSH to the server, create SWAP, update and upgrade and reboott the server)"
Q211="setup Netmaker VPN Server"
Q212="setup NginX Server"

Q22="connect to your Oracle Server"
Q221="connect to your Netmaker Oracle Server"
Q222="connect to your NginX Oracle Server"

Q23="install all the initial soft"
Q24="connect to the server common LAN NFS share ryzen2ter"
Q25="setup VPN Netmaker"
Q26="install Docker Stack and Docker Apps"


#MAIN MENU QUESTION MODULES
QM21(){
   askYesNoQuestionWithActions "2.1" "$Q21" oracleSSHprepQuesttions
}

oracleSSHprepQuesttions(){
   askYesNoQuestionWithActions "2.1.1." "$Q211" "oracleSSHprepare "netmaker""
   askYesNoQuestionWithActions "2.1.2." "$Q212" "oracleSSHprepare "nginx""
}


QM22(){
   askYesNoQuestionWithActions "2.2." "$Q22" oracleSSHconnectQuestions
}
oracleSSHconnectQuestions(){
   askYesNoQuestionWithActions "2.2.1." "$Q221" "oracleSSHconnect "netmaker""
   askYesNoQuestionWithActions "2.2.2." "$Q222" "oracleSSHconnect "nginx""
}

QM23(){
   askYesNoQuestionWithActions "2.3." "$Q23" desktopMain
}
QM24(){
   askYesNoQuestionWithActions "2.4." "$Q24" dockerMain
}
QM25(){
   askYesNoQuestionWithActions "2.5." "$Q25" privateMain
}
QM26(){
   askYesNoQuestionWithActions "2.6." "$Q26" privateMain
}

renderServerMenu(){
   dropLineStyles
   declare -n activeLine=sl$1
   declare -n questionModule=QM2$1
   activeLine=${YellowB}${BlackT}${bold}
   printDefaultMenu7Lines "2." "$mt20" "$mt21" "$mt22" "$mt23" "$mt24" "$mt25" "$mt26" "$res" 
   QM2$1
}