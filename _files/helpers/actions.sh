#!/bin/bash
#ACTIONS SCRIPT
#Contains all the commands

finished(){
   echo -e "${done} DONE!"
   sleep 1
}
Green
updateUpgrade(){
   echo -e "${log}"
   sudo apt update && sudo apt upgrade -y
   finished
}

updateUpgradeSilent(){
   updateUpgrade &> /dev/null
   finished
}

generalTools(){
   sudo apt install openssh-server git nano wget tar htop nfs-common p7zip-full gpg -y
   finished
}



###ORACLE
oracleConnectSSH(){

   echo -e "${Yellow}"

   privateKeyName=$(ls ./_files/keys/$service | grep key)
   ssh -i ssh-key-2023-02-26.key ubuntu@155.248.210.125

   runuser -l username -c 'ssh ubuntu@"$serverIP"' 
}


testConnection(){


   echo -e "${Yellow}"
   echo -e "Please choose the service that you want to connect/setup:"

	select service in "Netmaker VPN Server" "NginX Reverse Proxy Server"; do
	case $REPLY in
		1)
		echo -e "${Green}OK you want to prepare SSH connection using Netmaker private key"
		serviceFolder="netmaker"
		break
		;;      
		2)
		echo -e "${Green}OK you want to prepare SSH connection using NginX private key"
		serviceFolder="nginx"
		break
		;;
		*) echo "invalid option $REPLY";;
	esac
	done
   
   echo -e "${Yellow}"
   read -p "Enter server IP: " serverIP
	echo -e "${Green}OK you want to connect to your ORACLE server using $serverIP IP address"
   privateKeyName=$(ls ./_files/keys/$serviceFolder/ | grep key)
	echo -e "${Green}OK it looks like you have $privateKeyName in keys/netmaker folder"
   keyPath="./_files/keys/$serviceFolder/$privateKeyName"
	echo -e "${Green}OK it looks like path to your private key is $keyPath"

   chmod 400 $keyPath

   ssh -i $keyPath ubuntu@$serverIP





}

oraclePrepareSSH(){
   echo -e "${Yellow}"
   read -p "Enter your current user name (linux name): " username
   read -p "Enter server IP: " serverIP
   home="/home/${username}"
   privateKeyName=$(ls | grep key)


   echo -e "${Yellow}Your workDir is $home"
   echo -e "${Yellow}Your server IP is $serverIP"
   echo -e "${Yellow}Your key is $privateKeyName"
   sleep 1

   #1 Folder /.ssh
   #Check if $home/.ssh exists
   echo ""
   if [ -d $home"/.ssh" ]; then
      #CASE when folder already exists 
      echo -e "${Yellow}Folder $home"/.ssh" exists"
   else
      #CASE when folder does not already exists
      echo -e "${Red}Folder $home"/.ssh" does not exist"
      #Create a new folder $home/.ssh
      echo -e "${Yellow}Try to create a new folder $home"/.ssh" ..."
      sudo mkdir $home/.ssh/
      #Check if a new folder was created
      if [ -d $home"/.ssh" ]; then
        echo -e "${Green}Folder $home"/.ssh" was created"
      else
        echo -e "${Red}ERROR! Can't create a folder!'"
      fi
   fi

   #2 Rename and copy private server key to a new folder
   #2.1 Check if a key exists
   echo ""
   if [ -f "$privateKeyName" ]; then 
      #CASE a key exists in start folder
      echo -e "${Green}The private key was found"
      #2.2 copy and rename a key to .ssh folder
      echo -e "${Yellow}Try to copy and rename a key file to $home"/.ssh" ..."
      sudo cp $privateKeyName $home/.ssh/id_rsa_$serverIP
      #2.3 check if a key was copied
      if [ -f $home"/.ssh/id_rsa_"$serverIP ]; then
         echo -e "${Green}The private key was copied and renamed"
      else
         echo -e "${Red}ERROR! Can't copy/rename a key file"
      fi
   else
        echo -e "${Red}The private key was not found"
   fi


   #3 Create a config file in /.ssh and add all the information
   #3.1 Check if a config file already exists
   echo ""
   if [ -f "$home/.ssh/config" ]; then
      #CASE a config file exists
      echo -e "${Green}Config file exists"
   else
      #CASE a config file DOES NOT exist
      echo -e "${Red}Config file does not exist"
      echo -e "${Yellow}Try to create a config file ... "
      sudo touch $home/.ssh/config
      if [ -f "$home/.ssh/config" ]; then
         echo -e "${Green}Config file was created"
      else 
         echo -e "${Red}ERROR! CAN NOT CREATE CONFIG FILE"
      fi
   fi
   sleep 1
   #3.2 Add information to a config file
   echo -e "${Yellow}"
   echo -e "Try to add all the information to a config file ... "
   sudo echo "Host $serverIP" >> $home/.ssh/config
   sudo echo "HostName $serverIP" >> $home/.ssh/config
   sudo echo "User git" >> $home/.ssh/config
   sudo echo "IdentityFile $home/.ssh/id_rsa_$serverIP" >> $home/.ssh/config
   sudo echo "IdentitiesOnly yes" >> $home/.ssh/config

   #4 Create a file known_hosts
   #4.1 Check if a file known_hosts already exists
   echo ""
   if [ -f "$home/.ssh/known_hosts" ]; then
      #CASE a file known_hosts exists
      echo "known_hosts file exists"
   else
      #CASE a file known_hosts DOES NOT exist
      echo -e "${Red}known_hosts file does not exist"
      echo -e "${Yellow}Try to create a known_hosts file ... "
      sudo touch $home/.ssh/known_hosts
      if [ -f "$home/.ssh/known_hosts" ]; then
         echo -e "${Green}known_hosts file was created"
         sudo chmod 777 $home/.ssh/known_hosts
      else 
      echo -e "${Red}ERROR! CAN NOT CREATE known_hosts file"
      fi
   fi 
   sleep 1
   clear -x
   echo ""
   echo -e "${Green}1. If you want to keep use my script on your ORACLE server you need to install git:"
   echo -e "${Yellow}sudo apt update && sudo apt install git -y"
   echo ""
   echo -e "${Green}2. Now you need to clone my repo with the script:"
   echo -e "${Yellow}git clone https://github.com/ilopatenko/bash-collection"
   echo ""
   echo -e "${Green}3. Run the script:"
   echo -e "${Yellow}cd bash-collection && sudo bash index.sh"
   dropLineStyles

   askYesNoQuestionWithActions "" "continue" oracleConnectSSH
}

oracleSwap(){
   sudo fallocate -l 2048M /root/swapfile && ls -lh /root/swapfile && chmod 600 /root/swapfile && mkswap /root/swapfile && swapon /root/swapfile && echo "/root/swapfile none swap sw 0 0" >> /etc/fstab
   sleep 1
}

###NETMAKER
netmakerServer(){
   sudo wget -qO /root/nm-quick-interactive.sh https://raw.githubusercontent.com/gravitl/netmaker/master/scripts/nm-quick-interactive.sh && sudo chmod +x /root/nm-quick-interactive.sh && sudo /root/nm-quick-interactive.sh
}

netmakerClient(){
   sudo curl -sL 'https://apt.netmaker.org/gpg.key' | sudo tee /etc/apt/trusted.gpg.d/netclient.asc
   sudo curl -sL 'https://apt.netmaker.org/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/netclient.list
   sudo apt update
   sudo sudo apt install netclient -y
   sudo ip -br -c a
}

###DOCKER STACK
dockerStack(){
   wget https://gitlab.com/bmcgonag/docker_installs/-/raw/main/install_docker_nproxyman.sh
   chmod +X install_docker_nproxyman.sh
   sudo bash install_docker_nproxyman.sh
}






###OTHER
nodejsInstall(){
   sudo curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs
}



mountNfs(){
if [[ "$1" == "ryzen2ter" ]]; then
  source="192.168.0.201:/mnt/ryzen2ter/dataSetRyzen2ter"

if [[ "$1" == "ryzen4ter" ]]; then
  source="192.168.0.201:/mnt/ryzen2ter/dataSetRyzen4ter"

if [[ "$1" == "ssdIT" ]]; then
  source="192.168.0.200:/mnt/ssd2terIT/ssd2terITdataSet"

if [[ "$1" == "ssdMedia" ]]; then
  source="192.168.0.200:/mnt/ssd2terVideo/ssd2terVideoDataSet"
fi
    if [ -d "/media/$1" ]
      then
         echo -e "${prt}/media/$1 exists"
      else
         echo -e "${prt}/media/$1 does not exist - trying to create ..."
         sudo mkdir /media/$1
         if [ -d "/media/$1" ]
            then
               echo -e "${don}/media/$1 was created!"
            else
               echo -e "${skp}!ERROR! /media/ryzen4ter was not created"
         fi
   fi
   sudo echo "AUTOMOUNT NFS for $1" >> /etc/fstab
   sudo echo "$source /media/$1 nfs defaults 0 0" >> /etc/fstab
   sudo echo "" >> /etc/fstab
}

mount2ter(){
   mountNfs "ryzen2ter" 
}
mount4ter(){
   mountNfs "ryzen4ter" 
}
mountSsdIT(){
   mountNfs "ssdIT" 
}
mountSsdMedia(){
   mountNfs "ssdMedia" 
}

mountAllNfs(){
   mount2ter
   mount4ter
   mountSsdIT
   mountSsdMedia
}