#!/bin/sh

while sleep "$INTERVAL"; do
    docker stats --no-stream $(docker ps | awk '{if(NR>1) print $NF}') | tail -n+2 | \
        while read line; do
            echo "$line" | \
                awk '{ printf("'$STATSD_PREFIX'.%s.cpu:%.2f|g", $2, substr($3, 1, length($3)-1)) }' | \
                xargs echo | \
                nc -u -w 1 "$STATSD_HOST" "$STATSD_PORT"
            echo "$line" | \
                awk '{ printf("'$STATSD_PREFIX'.%s.memory:%.2f|g", $2, substr($7, 1, length($7)-1)) }' | \
                xargs echo | \
                nc -u -w 1 "$STATSD_HOST" "$STATSD_PORT"
	    echo "SENT: '$line'"
        done
done
