FROM mysql:5.6
MAINTAINER easter1021<mufasa.hsu@gmail.com>

RUN set -xe && \
        usermod -u 1000 mysql && \
        mkdir -p /var/run/mysqld && \
        chmod -R 777 /var/run/mysqld && \

        # 改為台北時區
        echo "Asia/Taipei" > /etc/timezone && \
        dpkg-reconfigure --frontend noninteractive tzdata
