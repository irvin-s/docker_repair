FROM mysql:5.7

RUN { \
      echo '[client]'; \
      echo 'default-character-set=utf8mb4'; \
    } > /etc/mysql/conf.d/charset.cnf
