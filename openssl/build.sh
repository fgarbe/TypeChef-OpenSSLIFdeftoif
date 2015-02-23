#!/bin/bash
echo "Start make..."
timeout 600 make 2>&1  

RETVAL=$?
echo $RETVAL
[ $RETVAL -eq 0 ] && echo "Success_Build"
[ $RETVAL -eq 124 ] && echo "Failure_Timeout"
[ $RETVAL -ne 0 ] && echo "Failure_Build"

exit

