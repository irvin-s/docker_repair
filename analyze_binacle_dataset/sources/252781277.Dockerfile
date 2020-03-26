# Buildbox image for Ruby 2.3.x apps.  
# See: https://www.ruby-lang.org/en/downloads/  
FROM balser/buildbox  
  
ENV PACKAGE ruby-2.3.1  
ENV PACKAGE_URL http://cache.ruby-lang.org/pub/ruby/2.3/$PACKAGE.tar.gz  
ENV CHECKSUM b87c738cb2032bf4920fef8e3864dc5cf8eae9d89d8d523ce0236945c5797dcd  
  
RUN \  
cd /tmp && \  
curl -sOL $PACKAGE_URL && \  
echo "$CHECKSUM $PACKAGE.tar.gz" | sha256sum -c && \  
tar xzvf $PACKAGE.tar.gz && \  
cd $PACKAGE && \  
./configure --prefix=/usr/local \--disable-install-doc && \  
make && \  
make --jobs=`nproc` install && \  
rm -rf /tmp/$PACKAGE*  
  
RUN /usr/local/bin/gem update --system --no-document  
RUN /usr/local/bin/gem install bundler --no-document  

