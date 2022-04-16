FROM mysql:8.0

COPY ./custom.conf /etc/mysql/conf.d/mysql.cnf

RUN touch /var/log/mysql-slow.log && chmod 777 /var/log/mysql-slow.log

CMD ["mysqld"]