FROM mariadb:latest

COPY ["wait4mysql.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/wait4mysql.sh"]
