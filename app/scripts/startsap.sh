#!/bin/bash

source /scripts/Parameterfile.sh


startsap()
{

    if [ "$IsDBInstallonsameSAPhost" == "y" ]
        then
        echo " Starting HANA database"
        su - "$dbsid"adm -c "HDB start"  > hanalog 2>&1

        SAPStatus=$(su - "$dbsid"adm -c "/usr/sap/$DBSID/SYS/exe/hdb/sapcontrol -prot NI_HTTP -nr $dbnr -function GetSystemInstanceList" | grep "GREEN" )

        if [ "$SAPStatus" ]
        then
                echo "Please start the Untar'ing of SAP System"
	 mail -s "SAP Migration" 613759@cognizant.com <<< 'HANA DB is up and running'

        else

        echo "HANA database start failed. Please check the log"
	 mail -s "SAP Migration" 613759@cognizant.com <<< 'HANA DB start failed. Please check the log'

                exit
        fi
  fi

DBStatus=$(su - "$sapsid"adm -c "R3trans -d" | grep "R3trans finished (0000)")

     if [ "$DBStatus" ]
     then
          echo "DB is up and running. Start SAP"

               su - "$sapsid"adm -c "startsap r3"  > saplog 2>&1
			mail -s "SAP Migration" 613759@cognizant.com <<< 'SAP is up and running'


         else

                 echo "DB is stopped. Please start database."

     fi
}
startsap
