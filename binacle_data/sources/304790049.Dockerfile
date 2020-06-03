FROM @FROM@

WORKDIR /usr
EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
#ENTRYPOINT ["/usr/bin/mysqld_safe"]
