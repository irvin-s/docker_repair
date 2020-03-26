FROM mysql:5.7.9

RUN sed -i 's/\[mysqld\]/\[mysqld\]\nlower_case_table_names=1/g' /etc/mysql/my.cnf

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]