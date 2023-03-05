#!/bin/bash
#ACTIONS SCRIPT

#1 UPDATE AND UPGRADE

update(){
  sudo apt update && sudo apt upgrade -y
}

oracleSSHconnect(){
   type=$1
   path="/home/slon/Storage/ssdIT/_SSH-keys/myOracle/$type"
   oracleUserName="ubuntu"
   keyName=$(find $path -name "*.key")
   chmod 400 $keyName
   serverIP=$(cat $path/ip.txt)
   echo -e "${info}"
   ssh -o StrictHostKeyChecking=no -i $keyName $oracleUserName@$serverIP
}

connectToLan(){
  declare -n prop=$1
  ssh test@192.168.0.$prop
}


installGitLabServer(){
  clear -x
  echo -e "${quest}"
  read -p "ENTER YOUR CUSTOM DOMAIN FOR THE GITLAB SERVER (gitlab.kitqa.com): " host
  echo -e "${info}"
  sudo apt-get update
  sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
  curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo os=ubuntu dist=trusty bash
  sudo EXTERNAL_URL="$host" apt-get install gitlab-ce
}

