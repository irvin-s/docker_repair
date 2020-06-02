FROM daocloud.io/centos:6
MAINTAINER YMFE <ymfe.team@gmail.com>

RUN echo "\
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node \
export NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node \
export SASS_BINARY_SITE=http://npm.taobao.org/mirrors/node-sass \
PATH=$PATH:/root/.nvm/current/bin \
export PATH \
" >> /root/.bash_profile

RUN yum -y install git gcc-c++.x86_64 vim bzip2 fontconfig
RUN yum -y install mysql-server mysql mysql-devel

ADD files/yicond /etc/rc.d/init.d/
RUN chmod 777 /etc/rc.d/init.d/yicond
ADD files/pm2 /usr/bin
RUN chmod 777 /usr/bin/pm2
ADD files/node /usr/bin
RUN chmod 777 /usr/bin/node
ADD files/npm /usr/bin
RUN chmod 777 /usr/bin/npm
ADD files/yicon /usr/bin
RUN chmod 777 /usr/bin/yicon
ADD files/init.sql /
ADD files/iconfont.sql /
ADD files/ldapauth.js /
ADD files/fixed.js /

RUN sed -i '1a default-character-set=utf8\ncharacter_set_server=utf8' /etc/my.cnf \
    && echo -e "default-character-set=utf8\n\n\
[client]\ndefault-character-set=utf8\n\n\
[mysql.server]\ndefault-character-set=utf8" >> /etc/my.cnf

RUN source /root/.bash_profile \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash \
    && source /root/.bash_profile \
    && nvm install v6.2.1 \
    && npm install npm@3.10.5 -g --registry=https://registry.npm.taobao.org \
    && npm install pm2 -g --registry=https://registry.npm.taobao.org \
    && npm install yicon-builder@1.0.6 -g --registry=https://registry.npm.taobao.org

RUN service mysqld restart \
    && /usr/bin/mysqladmin -u root password "123456" \
    && mysql -u root -p123456 < init.sql \
    && sed -i '1i\use iconfont;\n' iconfont.sql \
    && mysql -u root -p123456 < iconfont.sql \
    && rm init.sql \
    && rm iconfont.sql

RUN source /root/.bash_profile \
    && mkdir yicon \
    && cd yicon \
    && yicon init -b v1.2.1 --default \
    && cp src/start.sh src/yicon.sh \
    && mv src/src/controller/modules/ldapauth.js src/src/controller/modules/ldapauth.bak.js \
    && mv /ldapauth.js src/src/controller/modules/ldapauth.js \
    && cd .. \
    && node fixed.js \
    && rm fixed.js

RUN echo " \
echo \"use users;REPLACE INTO users(user, pwd) VALUES ('\$1', md5('\$2'));\" >> user.sql && \
mysql -u root -p123456 < user.sql && \
rm user.sql \
" >> user \
    && chmod 777 user

EXPOSE 3000

CMD /etc/rc.d/init.d/yicond
