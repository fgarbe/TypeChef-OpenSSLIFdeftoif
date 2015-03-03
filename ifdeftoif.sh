#!/bin/bash 

START_TIME=$SECONDS

path=$(cd "$(dirname "$0")"; pwd)
echo "$path"
cd $path

#cd openssl

#make 2>&1 | tee makelog

#cd $path

filesToProcess() {
  local listFile=$path/casestudy/openssl_files
  cat $listFile
# cat $listFile | sed -n "${1}~8p" 
}

flags=" --bdd \
      --reuseAST
        -I $path/openssl \
	 -I $path/openssl/include
	-I $path/openssl/include/openssl
	--platfromHeader $path/openssl/platform.h \
        --featureModelDimacs $path/openssl/OpenSSL.dimacs \
	--include $path/openssl/partial_configuration.h \
	--recordTiming --parserstatistics --lexNoStdout --writePI --ifdeftoifstatistics"

filesToProcess $1|while read i; do
         echo "Ifdeftoif $path/openssl/$i.c"
         ../Hercules/ifdeftoif.sh $path/openssl/$i.c $flags
         done

# Assign values inside the id2i_optionstruct
# ./../Hercules/ifdeftoif.sh --featureConfig OpenSSLDefConfig.config

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "$(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"

exit
