FROM alpine:edge
MAINTAINER janes - https://github.com/hxer

ENV PACKAGES="\
  python \
  python-dev \
  py2-pip \
  git \
  mysql \
  mysql-dev \
  gcc \
  g++ \
  cloc \
"

RUN apk add --update $PACKAGES && \
    pip install --upgrade pip

# config logs path
RUN git clone https://github.com/wufeifei/cobra && \
    cd cobra && \
    mkdir logs && \
    touch logs/cobra.log && \
    cp config.example config && \
    sed -i "s#host: 127.0.0.1#host: 0.0.0.0#" config && \
    sed -i "s#port: 5000#port: 80#" config && \
    sed -i "s#secret_key: your_secret_key#secret_key: 07b7b67e61834f90fa8ca9f25eb58b4f#" config && \
    sed -i "s#max_size: 200#max_size: 1000#" config && \
    pip install -r requirements.txt
    

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    mysql_install_db --user=mysql --verbose=1 --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

RUN echo "#!/bin/sh" > /start.sh && \
    echo "nohup mysqld --skip-grant-tables --bind-address 0.0.0.0 --user mysql > /dev/null 2>&1 &" >> /start.sh && \
    echo "sleep 3" >> /start.sh && \
    echo "python /cobra/cobra.py install &" >> /start.sh && \
    echo "python /cobra/cobra.py start &" >> /start.sh && \
    echo "tail -f /cobra/logs/cobra.log" >> /start.sh && \
    chmod u+x /start.sh
    
WORKDIR /cobra

EXPOSE 80
EXPOSE 3306

ENTRYPOINT ["/start.sh"]

