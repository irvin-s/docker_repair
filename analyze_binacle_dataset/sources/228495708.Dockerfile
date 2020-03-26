FROM mysql

COPY my.cnf.tmpl /etc/mysql/my.cnf
COPY entrypoint.sh /entrypoint.sh
COPY my_entrypoint.sh /my_entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /my_entrypoint.sh

ENTRYPOINT ["/my_entrypoint.sh"]
CMD ["mysqld"]
