# MariaDB Galera Cluster in Docker Containers

This repository maintains the Dockerfile and scripts to build MariaDB Galera Cluster in Docker Containers.

## What does it do

Dockerfile : 

    1. Build from official docker container
    2. Copy files init.sh
    3. Set user mysql
    4. Set /init.sh as entrypoint

init.sh :

    1. Check service in the cluster to see if this is a new cluster
    2. Updated safe_to_bootstrap to 1 in /var/lib/mysql/grastate.dat, if mysql data is found and this is a new cluster
    3. Start mysqld with different arguments.
    
galega-status :

    USAGE: galera-status [--help] [--follow] [--hosts=<node1>,<node2>,...] [MySQL options]
    OPTIONS: --help        this help
         --follow      continuously updates information retrieved from monitored nodes
         --hosts       comma-separated list of node hosts
    EXAMPLES: galera-status --hosts=172.0.0.1,172.0.0.2,172.0.0.3 -uuser -psecret --follow
          galera-status --follow

## Example

You can test with command:

    docker-compose -f docker-compose.yml up -d

If it does not work, please download latest docker-compose and try again.

    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

When all containsers are running.

    # docker ps
    CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS     NAMES
    174b1c551e2a   mariadb-cluster  "docker-entrypoint.s…"   28 minutes ago   Up 28 minutes             mariadb

    # docker exec -it mariadb mysql -uroot -p***** -e "show status where variable_name in ('wsrep_cluster_status', 'wsrep_incoming_addresses','wsrep_local_state_comment');"
    +---------------------------+----------------------------------------+
    | Variable_name             | Value                                  |
    +---------------------------+----------------------------------------+
    | wsrep_local_state_comment | Synced                                 |
    | wsrep_incoming_addresses  | x.x.x.x,y.y.y.y,z.z.z.z                |
    | wsrep_cluster_status      | Primary                                |
    +---------------------------+----------------------------------------+

## References

    https://github.com/hweidner/galera-docker
    https://github.com/ustcweizhou/docker-mariadb-cluster
    https://github.com/scheidtp/galera-status
