FROM nanasess/php7-ext-apache

MAINTAINER Kentaro Ohkouchi <nanasess@fsm.ne.jp>

ENV PGUSER cube3_dev_user
ENV ECCUBE_PATH /var/www

ARG DBTYPE=pgsql
ARG ECCUBE_REPOS=https://github.com/EC-CUBE/ec-cube.git
ARG ECCUBE_BRANCH=master

RUN useradd -ms /bin/bash ${PGUSER}

RUN ls -lt ${PHP_INI_DIR}/conf.d/
COPY config/php.ini ${PHP_INI_DIR}/
ADD wait-for-${DBTYPE}.sh /wait-for-db.sh
RUN chmod +x /wait-for-db.sh

ENTRYPOINT /wait-for-db.sh

## Clone EC-CUBE3
RUN cd /var && \
    rm -r /var/www && \
    git clone --depth=50 -b ${ECCUBE_BRANCH} ${ECCUBE_REPOS} ${ECCUBE_PATH}

WORKDIR ${ECCUBE_PATH}
RUN composer install
COPY config/exec_env.sh ${ECCUBE_PATH}/exec_env.sh
RUN chmod +x ${ECCUBE_PATH}/exec_env.sh
RUN ls -lt ${ECCUBE_PATH}/

EXPOSE 80
