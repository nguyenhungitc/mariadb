#!/bin/bash
set -e
new_cluster=true
cmd="/usr/local/bin/docker-entrypoint.sh mysqld"
hosts=$(echo $MYSQL_CLUSTER_ADDRESS | rev | cut -d '/' -f1 | rev | tr "," " ")

if [ ! -z "$hosts" ];then
    for host in $hosts;do
        if ( 2> /dev/null </dev/tcp/$host/3306 );then
            new_cluster=false
            break
        fi
    done
fi

if [ "$new_cluster" = "true" ];then
    cmd+=" --wsrep-new-cluster"
    if [ -f "/var/lib/mysql/grastate.dat" ];then
        sed -i "s|^safe_to_bootstrap: 0|safe_to_bootstrap: 1|g" /var/lib/mysql/grastate.dat
    fi
fi

echo "====== Executing command: $cmd ======"
exec $cmd