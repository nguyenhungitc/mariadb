FROM mariadb

COPY init.sh /init.sh
COPY init.sql /docker-entrypoint-initdb.d/init.sql

USER mysql:mysql
CMD /init.sh
