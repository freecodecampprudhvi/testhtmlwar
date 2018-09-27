su - b4hadm -c "HDB start"  
wait
DBStatus=$(su - "$sapsid"adm -c "R3trans -d" | grep "R3trans finished (0000)")
if [ "$DBStatus" ]
then
su - b4aadm -c "startsap r3"
