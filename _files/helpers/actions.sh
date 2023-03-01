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
