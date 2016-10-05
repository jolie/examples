#!/bin/sh

# To run multiple clients: ./multiple.sh [num. clients]
# Type <enter> to interrupt execution

NUM=1
if [ $# -ge 1 ]; then
	NUM=$1
fi

for (( i=1; $i<=$NUM; i++ )); do
	. jolie -C ClientLocationConstant=\"socket://localhost:400$i\" Client2.ol &
done

read

pkill -P `pgrep -d, -P $$`
