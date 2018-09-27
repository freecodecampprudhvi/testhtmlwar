class ScriptRunnerController < ApplicationController

def index
puts "inside index"
end

def create
  puts "reaached create controllwr"

  scripting= params[:scripting]
  sapsid=params[:sapsid]
  dbsid=params[:dbsid]
  inascs=params[:inascs]
  daasid=params[:daainsid]
  dbin=params[:dbin]
  lcnsap=params[:lcnsap]
  lcndb=params[:lcndb]
  hostascs=params[:hostascs]


  puts scripting
  puts dbsid
  puts inascs
  puts daasid
  puts dbin
  puts lcnsap
  puts lcndb
  puts hostascs
  if scripting =3 then
    isdbinstall=0
  else
    isdbinstall=1
  end
  path = "D:/testing/Parameterfile.sh"

  File.open(path, "w+") do |f|
    f.write "SAPSID="
    f.write(sapsid.upcase)
    f.write "\nDBSID="
    f.write(dbsid.upcase)
    f.write "\nSAPPASNR="
    f.write(inascs.upcase)
    f.write "\nDAASID="
    f.write(daasid.upcase)
    f.write "\ndbnr="
    f.write(dbin.upcase)
    f.write "\nBackupLocationSAP="
    f.write(lcnsap.upcase)
    f.write "\nBackupLocationDB=/"
    f.write(lcndb.upcase)
    f.write "\nIsitglobalhost="
    f.write(hostascs.upcase)
    f.write "\nIsDBInstallonsameSAPhost="
    f.write(isdbinstall)
    f.write "\nsapsid="
    f.write(sapsid.downcase)
    f.write "\ndaasid="
    f.write(daasid.downcase)
    f.write "\ndbsid="
    f.write(dbsid.downcase)
  end
  if scripting=3 then
    `bash ./app/scripts/SourceSAPTar.sh`
    sleep(60)
    `bash ./app/scripts/SourceDBTar.sh`
  elsif scripting=2 then
    `bash ./app/scripts/SourceDBTar.sh`
  else
    `bash ./app/scripts/SourceSAPTar.sh`
  end




end

end
