
#################################################
#	
# Script: 	Linux Migration Script
# Version:  1.0
#
################################################


#!/bin/bash


source /scripts/Parameterfile.sh


if [ "$IsDBInstallonsameSAPhost" == "y" ]
then

mkdir $TargetLocationBackup/App

else

mkdir $TargetLocationBackup

mkdir $TargetLocationBackup/App

chmod 777 -R $TargetLocationBackup

fi


SAPMount()
{

SourceIP="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$IP")"

service nfsserver restart

mount -t nfs4 $SourceIP:$BackupLocationSAP $TargetLocationBackup/App

}



restoreUsersGroup()
{
        cd $TargetLocationBackup
		
		cp /etc/passwd /etc/passwd.bak
    upath=$(find $TargetLocationBackup -name "passwd")
	cat $upath >> /etc/passwd

        cp /etc/group /etc/group.bak
	gpath=$(find $TargetLocationBackup -name "group")
	cat $gpath >> /etc/group
			
	cp /etc/services /etc/services.bak
	
	spath=$(find $TargetLocationBackup -name "services")
	cat $spath >> /etc/services
			

}



UnTarSAPFileSystem()
{
	 #system to be tar'ed  /sapmnt/   /usr/sap/   /home/sidadm
	
	cd $TargetLocationBackup

	if [ "$Isitglobalhost" -eq 1 ]
then
    spath=$(find $TargetLocationBackup -name "sapmnt.tgz")
	echo "UnTaring sapmnt"
	tar xpvfz $spath --directory /   > untarsapmnt  2>&1
	echo "Untaring sapmnt completed"
else
		mkdir /sapmnt/
		mkdir /sapmnt/$SAPSID/
	echo "enter the globalhost server ip"
	read action
        mount -t nfs4 $action:/sapmnt/$SAPSID /sapmnt/$SAPSID

	echo "$action:/sapmnt/$SAPSID  /sapmnt/$SAPSID nfs4 defaults 1 1 " >> /etc/fstab
fi
	echo "Untaring /usr/sap/"
	upath=$(find $TargetLocationBackup -name "usrsap.tgz")
	
	echo " Untaring /usr/sap/ completed"
	
	tar xpvfz $upath --directory /   > untarusrsap  2>&1
	
	echo "untaring /home/sidadm"
	hpath=$(find $TargetLocationBackup -name "homesidadm.tgz")
	

	tar xpvfz $hpath --directory /  > untarhomesid  2>&1
	
	echo "Untaring /home/sidadm completed"
	
	echo "Untaring daa home"
	
	dpath=$(find $TargetLocationBackup -name "daahomesidadm.tgz")
	
	tar xpvfz $dpath --directory / > untardaa 2>&1
	echo "Untaring /home/daa completed"
	
	mail -s "SAP Migration" 613759@cognizant.com <<< 'Target SAP untaring Completed'

	echo "unTar'ing of /etc/init.d/sapinit"

	  diath=$(find $TargetLocationBackup -name "sapinit.tgz")

        tar xpvfz $dipath --directory /  > $sapinit.log  2>&1

  mail -s "SAP Migration" 613759@cognizant.com <<< 'unTaring sapinit completed'

	

}

StartSAP()
{

cp /scripts/startsap.sh /etc/init.d/

chmod 777 /etc/init.d/startsap.sh

chmod +x /etc/init.d/startsap.sh

ln -s /etc/init.d/startsap.sh /etc/rc.d/rc3.d/S99startsap.sh

echo "VM is rebooting to finalize the migration tasks."

sleep 100

reboot
	 
}
echo " Do you want to Run Transfer Script to Mount the Source System Backup on TargetServer ? Please enter y - yes and n -  No "

read action

if [ "$action" ==  "y" ]
then

	SAPMount

else

echo "Please Manually Copy the Files to Target Location and then ReRun the script again "

fi


restoreUsersGroup
UnTarSAPFileSystem
StartSAP


