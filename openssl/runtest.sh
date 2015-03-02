#!/bin/sh

timeout 600 make test 2>&1

RETVAL=$?
[ $RETVAL -eq 0 ] && echo "Success_Test"
[ $RETVAL -eq 124 ] && echo "Failure_Timeout"
[ $RETVAL -ne 0 ] && echo "Failure_Test"

exit
