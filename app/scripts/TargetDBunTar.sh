
#################################################
#	
#
# Script: 	Linux Migration Script
# Version:  1.0
#
################################################


#!/bin/bash


# source file to target system
# install nfs-kernel-share on source system & TargetSystem as a prerequisite


source /scripts/Parameterfile.sh

mkdir $TargetLocationBackup

mkdir $TargetLocationBackup/DB

chmod 777 -R $TargetLocationBackup


SAPMount()
{

SourceIP="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$IP")"

service nfsserver restart

mount -t nfs4 $SourceIP:$BackupLocationDB $TargetLocationBackup/DB

}



restoreUsersGroup()
{

        cd $TargetLocationBackup

		cp /etc/passwd /etc/passwd.bak
		
    upath=$(find $TargetLocationBackup -name "dbpasswd")
	cat $upath >> /etc/passwd


	if [ "$IsDBInstallonsameSAPhost" == "y" ]
	then

		echo " DB & PAS is on same VM"
	else
		cp /etc/group /etc/group.bak
		echo "Jaane"
	gpath=$(find $TargetLocationBackup -name "dbgroup")
	
	cat $gpath >> /etc/group	

		cp /etc/services /etc/services.bak
	spath=$(find $TargetLocationBackup -name "dbservices")
	cat $spath >> /etc/services
			
	fi

}

UnTarDBFileSystem()
{

	cd $TargetLocationBackup

	echo "Extracting /hana/shared"
    spath=$(find $TargetLocationBackup -name "hanashared.tgz")
	tar xpvfz $spath --directory /   > untarhanashared  2>&1
	
	echo "Extraction of /hana/shared completed"
	
	
	echo " Extracting /hana/log"
	
	lpath=$(find $TargetLocationBackup -name "hanalog.tgz")
	tar xpvfz $lpath --directory /   > untarhanalog  2>&1
	
	echo "Extraction of /hana/log completed"
	
	echo "Extracting /home<sid> "
	
	homepath=$(find $TargetLocationBackup -name "dbhomesidadm.tgz")
	tar xpvfz $homepath --directory /   > untarhome 2>&1
	
	echo "Extraction of /home/<sid> completed"
	
	echo "Extracting /var/lib/hdb/<SID> "
	
	varpath=$(find $TargetLocationBackup -name "varlibhdb.tgz")
	tar xpvfz $varpath --directory /   > untarvar 2>&1
	
	 echo "extraction of /var/lib/hdb/<SID> completed"
	 
	if [ "$IsDBInstallonsameSAPhost" == "y" ]
	then
		echo " Same SAP installation host"
	else	
	
	
	echo "Extracting /home/daasid"
	
	daapath=$(find $TargetLocationBackup -name "daadbhomesidadm.tgz")
	tar xpvfz $daapath --directory /   > untardaa 2>&1
	
	
	echo "Extraction of /home/<daasid> completed"

	 echo "unTar'ing of /etc/init.d/sapinit"

          diath=$(find $TargetLocationBackup -name "sapinit.tgz")

        tar xpvfz $dipath --directory /  > $sapinit.log  2>&1

#  mail -s "SAP Migration" 613759@cognizant.com <<< 'unTaring sapinit completed'


	
	
	echo "Extracting /usr/sap "
	
	usrpath=$(find $TargetLocationBackup -name "dbusrsap.tgz")
	tar xpvfz $usrpath --directory /   > untarvar 2>&1
	
	
	echo "Extraction of /usr/sap/ completed"
	
	fi
	
	
	echo "Extracting of /hana/data  "
	
	dpath=$(find $TargetLocationBackup -name "hanadata.tgz")
	tar xpvfz $dpath --directory /  > untarhanadata  2>&1
	
	
	echo "Extraction of /hana/data completed"
	
	mail -s "SAP Migration" 613759@cognizant.com <<< 'untaring HANA DB Completed'

}

startHANA()
{	

if [ "$IsDBInstallonsameSAPhost" == "n" ]
then
cp /scripts/starthana.sh /etc/init.d/

chmod 777 /etc/init.d/starthana.sh

chmod +x /etc/init.d/starthana.sh

ln -s /etc/init.d/starthana.sh /etc/rc3.d/S99starthana.sh

echo "VM is rebooting to finalize the migration tasks."

sleep 100

reboot


else
   
echo  "SAP on same host as of db.Importing of SAP is in Progress  "

fi 


}

echo " Do you want to Run Transfer Script to Mount the Source System Backup on TargetServer ? Please enter y- yes and n - No "

read action

if [ "$action" ==  "y" ]
then

	SAPMount

else

echo "Please Manually Copy the Files to Target Location and then ReRun the script again "

fi

restoreUsersGroup

UnTarDBFileSystem

startHANA


