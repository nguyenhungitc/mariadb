FROM mariadb

COPY init.sh /init.sh
USER mysql:mysql

CMD /init.sh