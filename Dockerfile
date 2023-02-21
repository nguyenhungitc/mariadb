FROM mariadb

COPY init.sh /init.sh
COPY init.sql /docker-entrypoint-initdb.d/init.sql

#RUN apt-get install galera-arbitrator-4 -y

USER mysql:mysql
CMD /init.sh
