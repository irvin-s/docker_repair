FROM library/mysql

COPY wait.sh /usr/local/bin/wait.sh
CMD /usr/local/bin/wait.sh
