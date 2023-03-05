
#!/usr/bin/bash
#QUESTIONS AND ANSWERS SCRIPT

source ./_files/helpers/actions.sh
source ./_files/helpers/colors.sh



ans1="update and upgrade your system"
ans2="connect to the one of youe servers"
ans6="install GitLab Server CE"

ans11="connect to your LAN ProxMox Server"
ans12="connect to your Oracle Netmaker Server"
ans13="connect to your Oracle NginX Server"





ansReturnToMainMenu="go to the Main menu"





correct(){
   declare -n prop=$1
   echo -e "${done}OK. You want to $prop!"
}


mainQuestions(){
   while true
   do
   read -p " THE NEXT ACTION IS: " answer
   case $answer in
   1) correct ans1;sleep 1;update;clear -x;renderMainMenu;;
   2) correct ans2;sleep 1;renderServerConnectMenu;clear -x;renderMainMenu;;
   6) correct ans6;sleep 1;installGitLabServer;clear -x;renderMainMenu;;
   q|Q) exit;;
   *) echo -e "${error}$answer is a wrong selection";sleep 1;clear -x;renderMainMenu;;
esac
done

}


connectToServerQuestions(){
   while true
   do
   read -p " THE NEXT ACTION IS: " answer
   case $answer in
   1) correct ans11;sleep 1;connectToLanAfterQuestion;clear -x;renderServerConnectMenu;;
   2) correct ans12;sleep 1;oracleSSHconnect netmaker;clear -x;renderServerConnectMenu;;
   3) correct ans13;sleep 1;oracleSSHconnect nginx;clear -x;renderServerConnectMenu;;
   q|Q) correct ansReturnToMainMenu;renderMainMenu;;
   *) echo -e "${error}$answer is a wrong selection";sleep 1;clear -x;renderServerConnectMenu;;
esac
done
}

connectToLanAfterQuestion(){
   echo -e "${quest}"
   read -p " ENTER THE LAST PART OF LAN IP 192.168.0." lanIP
   echo -e "${info}"
   connectToLan lanIP
}

