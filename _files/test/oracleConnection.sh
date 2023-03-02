#ssh -i /home/slon/ <username>@<public-ip-address>


path="/home/slon/Storage/ssdIT/_SSH-keys/myOracle/test"

oracleUserName="ubuntu"

#oracleIP="192.9.232.24"

#keyName=$(find $path -name "*.key")

actions="echo $keyName"

keyName=$(find $path -name "*.key")
chmod 400 $keyName
serverIP=$(cat $path/ip.txt)

echo "THIS IS INSTRUCTION"
ssh -o StrictHostKeyChecking=no -i $keyName $oracleUserName@$serverIP


