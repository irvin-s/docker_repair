FROM fluent/fluentd:v0.14-debian-onbuild  
LABEL maintainer="dev.backend@dailyhotel.com"  
# Set the timezone to KST  
# RUN cat /usr/share/zoneinfo/Asia/Seoul > /etc/localtime  
  
ENV LANGUAGE C.UTF-8  
ENV LANG C.UTF-8  
ENV LC_ALL C.UTF-8  
ENV LC_CTYPE C.UTF-8  
  
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev build-essential" \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends $buildDeps \  
&& gem install \  
fluent-plugin-kafka \  
zookeeper \  
aws-sdk \  
&& gem sources --clear-all \  
&& SUDO_FORCE_REMOVE=yes \  
apt-get purge -y --auto-remove \  
-o APT::AutoRemove::RecommendsImportant=false \  
$buildDeps \  
&& rm -rf /var/lib/apt/lists/* \  
/root/.gem/ruby/2.3.0/cache/*.gem  
  
  

