FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \
    cmake \
    git \
    tree \
    htop \
    tmux \
    vim \
    libicu-dev \
    libboost1.67-all-dev \
    curl \
    postgresql \
    nginx-full

RUN mkdir /forum && mkdir /forum/repos

RUN cd /forum/repos/ && git clone https://github.com/danij/Forum.git
RUN cd /forum/repos/Forum/ && git checkout initial
RUN mkdir /forum/repos/Forum-RelWithDebInfo
RUN cd /forum/repos/Forum-RelWithDebInfo/ && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo /forum/repos/Forum/ && make -j 2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g webpack webpack-cli

RUN cd /forum/repos/ && git clone https://github.com/danij/Forum.Auth.git
RUN curl https://danistorage.blob.core.windows.net/public/password.js -o /forum/repos/Forum.Auth/services/password.js
RUN cd /forum/repos/Forum.Auth/ && npm install

RUN cd /forum/repos/ && git clone https://github.com/danij/Forum.Attachments.git
RUN cd /forum/repos/Forum.Attachments/ && npm install

RUN cd /forum/repos/ && git clone https://github.com/danij/Forum.Search.git
RUN cd /forum/repos/Forum.Search/ && npm install

RUN cd /forum/repos/ && git clone https://github.com/danij/Forum.WebClient.git
RUN cd /forum/repos/Forum.WebClient/ && npm install
RUN cd /forum/repos/Forum.WebClient/ && webpack --config webpack.production.js
RUN rm /var/www/html/*
RUN cp -a /forum/repos/Forum.WebClient/dist/. /var/www/html/
RUN mv /var/www /var/www-old

RUN rm /etc/nginx/modules-enabled/50-mod-http-auth-pam.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-dav-ext.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-echo.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-geoip.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-image-filter.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-subs-filter.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-upstream-fair.conf \
 && rm /etc/nginx/modules-enabled/50-mod-http-xslt-filter.conf \
 && rm /etc/nginx/modules-enabled/50-mod-mail.conf \
 && rm /etc/nginx/modules-enabled/50-mod-stream.conf

RUN cp /forum/repos/Forum.WebClient/docker/nginx.config /etc/nginx/sites-available/default
RUN sed -i 's# TLSv1 TLSv1.1##' /etc/nginx/nginx.conf
RUN sed -i 's#gzip on;#gzip off;#' /etc/nginx/nginx.conf

RUN rm -r /var/log/nginx
RUN ln -s /forum/logs/nginx /var/log/nginx

RUN chmod +x /forum/repos/Forum/docker/bootstrap-global.sh 
CMD ["/bin/bash", "/forum/start/start.sh"]
