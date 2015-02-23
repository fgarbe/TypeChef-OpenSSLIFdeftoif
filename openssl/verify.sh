#!/bin/bash 

filesToProcess() {
  local listFile=configFlags
  cat $listFile
}

cd openssl

if [ -f configFlags ]
  then
    
	mkdir --p "$1"

	#Ref first
	i=0

	filesToProcess|while read feature; do
        	echo "Verifiying $1"
        	echo "With features: $feature"
        	./genConfig.sh $feature | tee "$1"/"$i"_ref.config
        	./build.sh | tee "$1"/"$i"_ref.build
        	./runtest.sh | tee "$1"/"$i"_ref.test
        	i=`expr $i + 1`
        done

	#Clean
	git checkout .

	#Org Next
	i=0

	filesToProcess|while read feature; do
 		echo "Verifiying $1"
        	echo "With features: $feature"
        	./genConfig.sh $feature | tee "$1"/"$i"_org.config
        	./build.sh | tee "$1"/"$i"_org.build
 	 	./runtest.sh | tee "$1"/"$i"_org.test
        	i=`expr $i + 1`
        done

	rm configFlags

fi
exit
