FROM fluent/fluentd:v1.1-debian-onbuild  
MAINTAINER Baznai Cloud <info@banzaicloud.com>  
  
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends $buildDeps \  
&& sudo gem install \  
fluent-plugin-elasticsearch \  
fluent-plugin-remote-syslog \  
fluent-plugin-kubernetes_metadata_filter \  
fluent-plugin-webhdfs \  
fluent-plugin-elasticsearch \  
fluent-plugin-prometheus \  
fluent-plugin-s3 \  
fluent-plugin-rewrite-tag-filter \  
&& sudo gem sources --clear-all \  
&& SUDO_FORCE_REMOVE=yes \  
apt-get purge -y --auto-remove \  
-o APT::AutoRemove::RecommendsImportant=false \  
$buildDeps \  
&& rm -rf /var/lib/apt/lists/* \  
/home/fluent/.gem/ruby/2.3.0/cache/*.gem  
  
ADD fluent.conf /fluentd/etc/fluent.conf  
  
VOLUME /fluentd/etc/conf.d/  
VOLUME /fluentd/etc/ssl/  
  
EXPOSE 24284

