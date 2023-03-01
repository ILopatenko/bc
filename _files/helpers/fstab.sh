
#!/bin/bash
#FSTAB
user=$1

localOnly(){
   echo "
#
############################
#AUTOMOUNT FOR LOCAL DRIVES#
/dev/disk/by-uuid/535AFF5B40052D09 /home/$1/Storage/860 auto nosuid,nodev,nofail,x-gvfs-show 0 0
/dev/disk/by-uuid/7A2590CDC3BE76D0 /home/$1/Storage/2TER auto nosuid,nodev,nofail,x-gvfs-show 0 0
/dev/disk/by-uuid/d6675341-6422-4c7c-afee-168440542329 /home/$1/Storage/970-rest auto nosuid,nodev,nofail,x-gvfs-show 0 0
############################
#
" >> /etc/fstab
}

nfsOnly(){
   echo "
#
###################
#AUTOMOUNT FOR NFS#
192.168.0.201:/mnt/ryzen2ter/dataSetRyzen2ter /home/$1/Storage/ryzen2ter nfs defaults 0 0
192.168.0.201:/mnt/ryzen4ter/dataSetRyzen4ter /home/$1/Storage/ryzen4ter nfs defaults 0 0
192.168.0.200:/mnt/ssd2terIT/ssd2terITdataSet /home/$1/Storage/ssdIT nfs defaults 0 0
192.168.0.200:/mnt/ssd2terVideo/ssd2terVideoDataSet /home/$1/Storage/ssdMedia nfs defaults 0 0
###################
#
" >> /etc/fstab
}

all(){
   localOnly $1
   nfsOnly $1
}

commonShare(){
   echo "
#
#######################################################
#AUTOMOUNT COMMON NFS ryzen2ter for shared docker apps#
192.168.0.201:/mnt/ryzen2ter/dataSetRyzen2ter /home/$1/Storage/ryzen2ter nfs defaults 0 0
#######################################################
#
" >> /etc/fstab
}


if [[ $2 == "all" ]]; then    
   all $user
fi

if [[ $2 == "local" ]]; then    
   localOnly $user
fi

if [[ $2 == "lanNFSAll" ]]; then    
   nfsOnly $user
fi

if [[ $2 == "ryzen2ter" ]]; then    
   commonShare $user
fi


