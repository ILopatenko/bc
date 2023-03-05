#!/bin/bash
#MENU SCRIPT

source ./_files/helpers/questions.sh

printDefaultMenu7Lines(){
  clear -x
   echo -e "${GrayDB}"
   echo -e "                                                   "
   echo -e "     ${BlackB}${frame}*****************************************${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}                                     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}             ${olTitle}$1   ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}                                     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 1. $2 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 2. $3 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 3. $4 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 4. $5 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 5. $6 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 6. $7 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${li} 7. $8 ${CyanB}       ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}                                     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}*****************************************${GrayDB}     "
   echo -e "                                                   ${reset}"
   echo -e "${quest}"
   sleep 0.1
}

#MAIN MENU TITLES
mt0="MAIN MENU${resUnd}            "
mt1="UPDATE AND UPGRADE   "
mt2="CONNECT TO THE SERVER"
mt3="SETUP DESKTOP/LAPTOP "
mt4="DOCKER STACK AND APPS"
mt5="MY PERSONAL SETTINGS "
mt6="GITLAB SERVER        "
mt7="      Q - EXIT       "


renderMainMenu(){
   printDefaultMenu7Lines "$mt0" "$mt1" "$mt2" "$mt3" "$mt4" "$mt5" "$mt6" "$mt7"
   mainQuestions
}



#MAIN MENU TITLES
mt10="SSH TO SERVERS${resUnd}       "
mt11="LOCAL PROXMOX SERVER "
mt12="ORACLE NETMAKER SERV."
mt13="ORACLE NGINX SERVER  "
mt14="DOCKER STACK AND APPS"
mt15="MY PERSONAL SETTINGS "
mt16="COPY MY LAN KEY      "
mt17="  Q - THE MAIN MENU  "

renderServerConnectMenu(){
   printDefaultMenu7Lines "$mt10" "$mt11" "$mt12" "$mt13" "$mt14" "$mt15" "$mt16" "$mt17"
   connectToServerQuestions
}