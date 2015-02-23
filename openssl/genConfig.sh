#!/bin/bash
echo "Start config generation..."
timeout 600 ./Configure linux-x86_64 $*
make depend

RETVAL=$?
echo $RETVAL
[ $RETVAL -eq 0 ] && echo "Success_Config"
[ $RETVAL -eq 124 ] && echo "Failure_Timeout"
[ $RETVAL -ne 0 ] && echo "Failure_Config"

exit

