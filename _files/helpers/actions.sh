#!/bin/bash
#ACTIONS SCRIPT
#Contains all the commands

finished(){
   echo -e "${done} DONE!"
   sleep 0.5
}
updateUpgrade(){
   echo -e "${log}"
   sudo apt update && sudo apt upgrade -y
   finished
}

updateUpgradeSilent(){
   updateUpgrade &> /dev/null
   finished
}


exitIfRoot(){
   if [[ $USER == "root" ]]; then
   echo -e "${error}Please run this script as non root user!"
   echo -e "${info}bash $0"
   exit
   else currentUser=$USER
   fi
}


#LOCAL DISKS
#2TER, 860, 970-rest

checkFolderStorage(){
   exitIfRoot
   if [ -d "/home/$USER/Storage" ]; then
      echo -e "${info} folder /home/$USER/Storage exists!"
   else
      echo -e "${info} trying to create /home/$USER/Storage"
      mkdir "/home/$USER/Storage"
      if [ -d "/home/$USER/Storage" ]; then
         echo -e "${done} folder /home/$USER/Storage was created!"
      else
         echo -e "${error} can not create folder /home/$USER/Storage!" 
      fi
   fi
}

createFolderForMount(){
   if [ -d "/home/$USER/Storage/$1" ]; then
   echo -e "${info} folder /home/$USER/Storage/$1 exists!"
   else
   echo -e "${info} trying to create /home/$USER/Storage/$1"
      mkdir "/home/$USER/Storage/$1"
      if [ -d "/home/$USER/Storage/$1" ]; then
         echo -e "${done} folder /home/$USER/Storage/$1 was created!"
      else
         echo -e "${error} can not create folder /home/$USER/Storage/$1!" 
      fi
   fi

}

localDisks(){
   checkFolderStorage
   createFolderForMount "2TER"
   createFolderForMount "860"
   createFolderForMount "970-rest"
   sudo bash ./_files/helpers/fstab.sh $currentUser "local"
}

lanNFSAll(){
   checkFolderStorage
   createFolderForMount "ryzen2ter"
   createFolderForMount "ryzen4ter"
   createFolderForMount "ssdIT"
   createFolderForMount "ssdMedia"
   sudo bash ./_files/helpers/fstab.sh $currentUser "lanNFSAll"
}

lanNFSryzen2ter(){
   checkFolderStorage
   createFolderForMount "ryzen2ter"
   sudo bash ./_files/helpers/fstab.sh $currentUser "ryzen2ter"
}

allTheStorages(){
   checkFolderStorage
   createFolderForMount "2TER"
   createFolderForMount "860"
   createFolderForMount "970-rest"
   createFolderForMount "ryzen2ter"
   createFolderForMount "ryzen4ter"
   createFolderForMount "ssdIT"
   createFolderForMount "ssdMedia"
   sudo bash ./_files/helpers/fstab.sh $currentUser "all"
}

evgaZ15(){
  sudo add-apt-repository ppa:thopiekar/openrgb -y && sudo apt update && sudo apt install openrgb -y
}


oracleSSHprepare(){
   type=$1
   path="/home/slon/Storage/ssdIT/_SSH-keys/myOracle/$type"
   oracleUserName="ubuntu"
   keyName=$(find $path -name "*.key")
   chmod 400 $keyName
   serverIP=$(cat $path/ip.txt)
   ssh -o StrictHostKeyChecking=no -i $keyName $oracleUserName@$serverIP "sudo apt update && sudo apt upgrade -y && sudo apt install git -y && git clone https://github.com/ilopatenko/bc && sudo fallocate -l 2048M /root/swapfile && ls -lh /root/swapfile && chmod 600 /root/swapfile && mkswap /root/swapfile && swapon /root/swapfile && echo "/root/swapfile none swap sw 0 0" >> /etc/fstab &&sudo reboot"
}


oracleSSHconnect(){
   type=$1
   path="/home/slon/Storage/ssdIT/_SSH-keys/myOracle/$type"
   oracleUserName="ubuntu"
   keyName=$(find $path -name "*.key")
   chmod 400 $keyName
   serverIP=$(cat $path/ip.txt)
   ssh -o StrictHostKeyChecking=no -i $keyName $oracleUserName@$serverIP
}



#######
generalTools(){
   sudo apt install openssh-server git nano wget tar htop nfs-common p7zip-full gpg -y
   finished
}

dockerStack(){
   wget https://gitlab.com/bmcgonag/docker_installs/-/raw/main/install_docker_nproxyman.sh
   chmod +X install_docker_nproxyman.sh
   bash install_docker_nproxyman.sh
}


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
