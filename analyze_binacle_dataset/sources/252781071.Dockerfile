FROM cotdsa/php-base  
  
RUN set -xe && \  
apt-get -qq update && \  
apt-get -qq install --no-install-recommends \  
python \  
python-pip \  
&& \  
pip install pyyaml && \  
apt-get purge -qq --auto-remove \  
-o APT::AutoRemove::RecommendsImportant=false \  
-o APT::AutoRemove::SuggestsImportant=false \  
python-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* && \  
true  
  
RUN set -xe && \  
apt-get -qq update && \  
apt-get -qq install --no-install-recommends \  
ruby-dev \  
rubygems \  
make \  
&& \  
gem install --no-rdoc --no-ri sass -v 3.4.22 && \  
gem install --no-rdoc --no-ri compass && \  
apt-get purge -qq --auto-remove \  
-o APT::AutoRemove::RecommendsImportant=false \  
-o APT::AutoRemove::SuggestsImportant=false \  
ruby-dev make && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* && \  
ln -s /usr/local/bin/compass /usr/bin/compass && \  
true  

