#!/bin/bash

#################################################
#	Declare Variable in This file
#
# Script: 	Linux Migration Script
# Version:  1.0
#
################################################



echo "********************************************************************************"
echo "********************************************************************************"
echo "****************************  Welcome To ***************************************"
echo "*********************** SAP Migration Automation *******************************"
echo "********************************************************************************"
echo "********************************************************************************"


echo "Please Provide all the correct inputs"
	

	
echo "Please enter E - Source Export (or) I - Target Import"

	read action

	if [ "$action" == "E" ]
	then
			
echo "Enter option 1 - SAP Application, 2 - Database, 3 - Both"

			read action

	if [ "$action" -eq 3 ]
	 then
	
	echo "Please Provide all the inputs"
	
	touch /scripts/Parameterfile.sh
	chmod 777 /scripts/Parameterfile.sh
	
read -p "Enter SAP Application SID " SAPSID
echo SAPSID="${SAPSID}" >> /scripts/Parameterfile.sh

read -p "Enter SAP HANA Database SID " DBSID
echo DBSID="${DBSID}" >> /scripts/Parameterfile.sh

read -p "Enter the Instance number for Application Server/ASCS hosted on this Machine " SAPPASNR
echo SAPPASNR="${SAPPASNR}" >> /scripts/Parameterfile.sh

read -p "Enter the DAA instance SID " DAASID
echo DAASID="${DAASID}" >> /scripts/Parameterfile.sh

read -p "Enter the Database Instance number  "  dbnr
echo dbnr="${dbnr}" >> /scripts/Parameterfile.sh

read -p "Enter the Location of Source Backup file for SAP  " BackupLocationSAP
echo BackupLocationSAP="${BackupLocationSAP}" >> /scripts/Parameterfile.sh

read -p "Enter the Location of Source Backup file for DB  " BackupLocationDB
echo BackupLocationDB="${BackupLocationDB}" >> /scripts/Parameterfile.sh


read -p "Is This Server Host ASCS Instance? Enter 0 - yes & 1 - no  " Isitglobalhost
echo Isitglobalhost="${Isitglobalhost}" >> /scripts/Parameterfile.sh


echo "IsDBInstallonsameSAPhost=0" >> /scripts/Parameterfile.sh

echo "sapsid=$(echo $SAPSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh
echo "daasid=$(echo $DAASID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh
echo "dbsid=$(echo $DBSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh


	echo "Checking System Status"
	sleep 30
	
	/scripts/SourceSAPTar.sh 
	echo "Exporting DB starts"
		sleep 60
		
	/scripts/SourceDBTar.sh
		
	elif [ "$action" -eq 2 ]
	then
		
		echo "Please Provide all the inputs"
	
touch /scripts/Parameterfile.sh
chmod 777 /scripts/Parameterfile.sh
	
#read -p "Enter SAP Application SID " SAPSID
#echo SAPSID="${SAPSID}" >> /scripts/Parameterfile.sh

read -p "Enter SAP HANA Database SID " DBSID
echo DBSID="${DBSID}" >> /scripts/Parameterfile.sh

#read -p "Enter the Instance number for Application Server/ASCS hosted on this Machine " SAPPASNR
#echo SAPPASNR="${SAPPASNR}" >> /scripts/Parameterfile.sh

read -p "Enter the DAA instance SID " DAASID
echo DAASID="${DAASID}" >> /scripts/Parameterfile.sh

read -p "Enter the Database Instance number  "  dbnr
echo dbnr="${dbnr}" >> /scripts/Parameterfile.sh

#read -p "Enter the Location of Source Backup file for SAP  " BackupLocationSAP
#echo BackupLocationSAP="${BackupLocationSAP}" >> /scripts/Parameterfile.sh

read -p "Enter the Location of Source Backup file for DB  " BackupLocationDB
echo BackupLocationDB="${BackupLocationDB}" >> /scripts/Parameterfile.sh


read -p "Is This Server Host ASCS Instance? Enter 0 - yes & 1 - no  " Isitglobalhost
echo Isitglobalhost="${Isitglobalhost}" >> /scripts/Parameterfile.sh


echo "IsDBInstallonsameSAPhost=1" >> /scripts/Parameterfile.sh

#echo "sapsid=$(echo $SAPSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh
echo "daasid=$(echo $DAASID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh
echo "dbsid=$(echo $DBSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh


		echo "Exporting DB starts"
		
		/scripts/SourceDBTar.sh
	
	else

	
	echo "Please Provide all the inputs"
	
	touch /scripts/Parameterfile.sh
	chmod 777 /scripts/Parameterfile.sh
	
read -p "Enter SAP Application SID " SAPSID
echo SAPSID="${SAPSID}" >> /scripts/Parameterfile.sh

#read -p "Enter SAP HANA Database SID " DBSID
#echo DBSID="${DBSID}" >> /scripts/Parameterfile.sh

read -p "Enter the Instance number for Application Server/ASCS hosted on this Machine " SAPPASNR
echo SAPPASNR="${SAPPASNR}" >> /scripts/Parameterfile.sh

read -p "Enter the DAA instance SID " DAASID
echo DAASID="${DAASID}" >> /scripts/Parameterfile.sh

#read -p "Enter the Database Instance number  "  dbnr
#echo dbnr="${dbnr}" >> /scripts/Parameterfile.sh

read -p "Enter the Location of Source Backup file for SAP  " BackupLocationSAP
echo BackupLocationSAP="${BackupLocationSAP}" >> /scripts/Parameterfile.sh

#read -p "Enter the Location of Source Backup file for DB  " BackupLocationDB
#echo BackupLocationDB="${BackupLocationDB}" >> /scripts/Parameterfile.sh


read -p "Is This Server Host ASCS Instance? Enter 0 - yes & 1 - no  " Isitglobalhost
echo Isitglobalhost="${Isitglobalhost}" >> /scripts/Parameterfile.sh


echo "IsDBInstallonsameSAPhost=1" >> /scripts/Parameterfile.sh

echo "sapsid=$(echo $SAPSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh
#echo "daasid=$(echo $DAASID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh
echo "dbsid=$(echo $DBSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh


	echo "Exporting SAP Starts"
		
		/scripts/SourceSAPTar.sh
		
	fi
	
else
	
echo "Enter option 1 - SAP Application, 2 - Database, 3 - Both"
			
			read action

	if [ "$action" -eq 3 ]
	then	
		touch /scripts/Parameterfile.sh
		chmod 777 /scripts/Parameterfile.sh
		
read -p "Enter Source System IP Address To Mount In Target " IP
echo IP="${IP}" >> /scripts/Parameterfile.sh

read -p "Enter Target Mount Location Name " TargetLocationBackup
echo TargetLocationBackup="${TargetLocationBackup}" >> /scripts/Parameterfile.sh

read -p "Enter Source System Exported Files Location for DB " BackupLocationDB
echo BackupLocationDB="${BackupLocationDB}" >> /scripts/Parameterfile.sh

echo IsDBInstallonsameSAPhost="y" >> /scripts/Parameterfile.sh


read -p "Enter Source DB SID " DBSID
echo DBSID="${DBSID}" >> /scripts/Parameterfile.sh

read -p "Enter Source DB Instance Number  " dbnr
echo dbnr="${dbnr}" >> /scripts/Parameterfile.sh

read -p "Enter Source SAP SID " SAPSID
echo SAPSID="${SAPSID}" >> /scripts/Parameterfile.sh

read -p "Enter Source DAA SID " DAASID
echo DAASID="${DAASID}" >> /scripts/Parameterfile.sh

read -p "Enter Source System Exported Files Location for SAP " BackupLocationSAP
echo BackupLocationSAP="${BackupLocationSAP}" >> /scripts/Parameterfile.sh


read -p "Enter Option 1 - Global Host, 2 - Local Host" Isitglobalhost
echo Isitglobalhost="${Isitglobalhost}" >> /scripts/Parameterfile.sh


echo "sapsid=$(echo $SAPSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

echo "daasid=$(echo $DAASID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

echo "dbsid=$(echo $DBSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

	
	echo "Import DB starts"

		/scripts/TargetDBunTar.sh 
	
echo "Import SAP starts"
	sleep	60

		/scripts/TargetSAPunTar.sh
		
	elif [ "$action" -eq 2 ]
		then	
		
touch /scripts/Parameterfile.sh
		chmod 777 /scripts/Parameterfile.sh
		
read -p "Enter Source System IP Address To Mount In Target " IP
echo IP="${IP}" >> /scripts/Parameterfile.sh

read -p "Enter Target Mount Location Name " TargetLocationBackup
echo TargetLocationBackup="${TargetLocationBackup}" >> /scripts/Parameterfile.sh

read -p "Enter Source System Exported Files Location for DB " BackupLocationDB
echo BackupLocationDB="${BackupLocationDB}" >> /scripts/Parameterfile.sh

echo IsDBInstallonsameSAPhost="y" >> /scripts/Parameterfile.sh


read -p "Enter Source DB SID " DBSID
echo DBSID="${DBSID}" >> /scripts/Parameterfile.sh

read -p "Enter Source DB Instance Number  " dbnr
echo dbnr="${dbnr}" >> /scripts/Parameterfile.sh

		
echo SAPSID="${SAPSID}" >> /scripts/Parameterfile.sh

read -p "Enter Source DAA SID " DAASID
echo DAASID="${DAASID}" >> /scripts/Parameterfile.sh

read -p "Enter Source System Exported Files Location for SAP " BackupLocationSAP
echo BackupLocationSAP="${BackupLocationSAP}" >> /scripts/Parameterfile.sh


read -p "Enter Option 1 - Global Host, 2 - Local Host " Isitglobalhost
echo Isitglobalhost="${Isitglobalhost}" >> /scripts/Parameterfile.sh


echo "sapsid=$(echo $SAPSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

echo "daasid=$(echo $DAASID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

echo "dbsid=$(echo $DBSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh




		echo "Import DB starts"

		/scripts/TargetDBunTar.sh
	
	else

	
	touch /scripts/Parameterfile.sh
		chmod 777 /scripts/Parameterfile.sh
		
read -p "Enter Source System IP Address To Mount In Target " IP
echo IP="${IP}" >> /scripts/Parameterfile.sh

read -p "Enter Target Mount Location Name " TargetLocationBackup
echo TargetLocationBackup="${TargetLocationBackup}" >> /scripts/Parameterfile.sh

read -p "Enter Source System Exported Files Location for DB " BackupLocationDB
echo BackupLocationDB="${BackupLocationDB}" >> /scripts/Parameterfile.sh

echo IsDBInstallonsameSAPhost="y" >> /scripts/Parameterfile.sh


read -p "Enter Source DB SID " DBSID
echo DBSID="${DBSID}" >> /scripts/Parameterfile.sh

read -p "Enter Source DB Instance Number  " dbnr
echo dbnr="${dbnr}" >> /scripts/Parameterfile.sh

		
echo SAPSID="${SAPSID}" >> /scripts/Parameterfile.sh

read -p "Enter Source DAA SID " DAASID
echo DAASID="${DAASID}" >> /scripts/Parameterfile.sh

read -p "Enter Source System Exported Files Location for SAP " BackupLocationSAP
echo BackupLocationSAP="${BackupLocationSAP}" >> /scripts/Parameterfile.sh


read -p "Enter Option 1 - Global Host, 2 - Local Host " Isitglobalhost
echo Isitglobalhost="${Isitglobalhost}" >> /scripts/Parameterfile.sh


echo "sapsid=$(echo $SAPSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

echo "daasid=$(echo $DAASID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh

echo "dbsid=$(echo $DBSID | tr '[:upper:]' '[:lower:]')" >> /scripts/Parameterfile.sh



	
echo "Import SAP starts"

		/scripts/TargetSAPunTar.sh
		
	fi

fi

