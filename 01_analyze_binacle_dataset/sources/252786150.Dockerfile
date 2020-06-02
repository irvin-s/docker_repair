FROM gcr.io/google-containers/fluentd-elasticsearch:v2.0.4  
  
RUN set -ex \  
&& gem install --no-document fluent-plugin-kafka \  
&& gem sources --clear-all \  
&& rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem  

