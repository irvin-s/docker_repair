#BUILD_PUSH=hub,quay
FROM bigm/nodejs

# https://github.com/haraka/Haraka/blob/master/Dockerfile
# https://github.com/gbleux/docker-haraka/blob/master/Dockerfile

#groupmod -g NEWGID OLDGID
VOLUME ["/data", "/xt/haraka/config"]
EXPOSE 25 587

RUN /xt/tools/_download /usr/local/bin/swaks "http://www.jetmore.org/john/code/swaks/files/swaks-20130209.0/swaks" \
    && chmod +x /usr/local/bin/swaks

RUN npm -g install Haraka

ADD root/ /
WORKDIR /xt/haraka
RUN npm install

ADD supervisor.d/* /etc/supervisord.d/
ADD startup/* /prj/startup/


## folders under /xt/defaults will be populated in instance if they are empty
#RUN mkdir -p /xt/defaults/etc \
#    && cp -rp /etc/confd /xt/defaults/etc/confd
#
## final
#ADD supervisor.d/* /etc/supervisord.d/
#ADD startup/* /prj/startup/