#!/bin/bash 

path=$(cd "$(dirname "$0")"; pwd)

filesToProcess() {
  local listFile=nofeatures
    cat $listFile
    }

filesToProcess|while read i; do
	        echo "Analysing $i"
		mkdir -p ../result/$i/
		make clean &> ../result/$i/clean.log
		git checkout .
		./Configure linux-x86_64 $i &> ../result/$i/configure.log
		CONFVAL=$?
		cp crypto/opensslconf.h ../result/$i/
		cp Makefile ../result/$i/
		make depend &> ../result/$i/depend.log
		DEPENDVAL=$?
		make &> ../result/$i/make.log
		MAKEVAL=$?
		make test &> ../result/$i/test.log
		TESTVAL=$?
		[ $CONFVAL -eq 0 ] && echo "$i conf OK"
		[ $CONFVAL -ne 0 ] && echo "$i conf FAIL"
		[ $DEPENDVAL -eq 0 ] && echo "$i depend OK"
		[ $DEPENDVAL -ne 0 ] && echo "$i depend FAIL"
	        [ $MAKEVAL -eq 0 ] && echo "$i make OK"
                [ $MAKEVAL -ne 0 ] && echo "$i make FAIL"
   	        [ $TESTVAL -eq 0 ] && echo "$i test OK"
	        [ $TESTVAL -ne 0 ] && echo "$i test FAIL"
	done

exit

