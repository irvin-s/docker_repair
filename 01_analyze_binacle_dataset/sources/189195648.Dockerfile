#BUILD_PUSH=hub,quay
FROM bigm/devtools

### web server to publish the tools
RUN /xt/tools/_ppa_install ppa:nginx/stable nginx
RUN rm -rf /etc/nginx/*.d && \
  mkdir -p /etc/nginx/addon.d /etc/nginx/conf.d /etc/nginx/host.d /etc/nginx/nginx.d

### php-fpm
RUN /xt/tools/_apt_install php5-fpm
RUN rm -rf /etc/php5/fpm/pool.d && \
  mkdir /etc/php5/fpm/pool.d

### adminer
RUN VERSION=4.2.3 \
  && mkdir -p /data/http/db \
	&& /xt/tools/_download /data/http/db/index.php "http://downloads.sourceforge.net/project/adminer/Adminer/Adminer%20${VERSION}/adminer-${VERSION}-en.php" \
	&& /xt/tools/_download /data/http/db/adminer.css "https://raw.githubusercontent.com/vrana/adminer/master/designs/pokorny/adminer.css"

### https://github.com/simogeo/Filemanager
RUN mkdir -p /data/http/fs \
  && /xt/tools/_download /data/http/fs/fs.zip https://github.com/simogeo/Filemanager/archive/master.zip \
  && cd /data/http/fs/ \
  && unzip fs.zip > /dev/null \
  && rm -f fs.zip \
  && mv Filemanager-master/* ./ \
  && rm -rf Filemanager-master

### TODO adminer editor
### TODO phpmyadmin

### configuration files
ADD root/ /
ADD startup/* /xt/startup/
ADD supervisor.d/* /etc/supervisord.d/

EXPOSE 80
CMD ["/usr/local/bin/supervisord", "-c",  "/etc/supervisord.conf"]
