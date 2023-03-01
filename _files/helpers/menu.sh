#!/bin/bash
#MENU SCRIPT

source ./_files/helpers/colors.sh

printDefaultMenu7Lines(){
  clear -x
   echo -e "${GrayDB}"
   echo -e "                                                   "
   echo -e "     ${BlackB}${frame}*****************************************${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}                                     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}             ${olTitle}$1 $2${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}                                     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl1} $11. $3 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl2} $12. $4 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl3} $13. $5 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl4} $14. $6 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl5} $15. $7 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl6} $16. $8 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}    ${sl7} $17. $9 ${CyanB}     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}**${CyanB}                                     ${frame}**${GrayDB}     "
   echo -e "     ${BlackB}${frame}*****************************************${GrayDB}     "
   echo -e "                                                   ${reset}"
   echo ""
   echo ""
   sleep 0.1
}
