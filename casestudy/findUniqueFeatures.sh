#!/bin/sh

grep -r -i -oh --include "*.c" "OPENSSL_NO_[a-zA-Z0-9]*" openssl | sort -u
