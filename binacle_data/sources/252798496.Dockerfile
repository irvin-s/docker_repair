# Alpine Linux with default Ruby 2.1.5 and development depencencies  
FROM gliderlabs/alpine:3.1  
  
MAINTAINER Denis Vazhenin <denis.vazhenin@me.com>  
  
RUN apk-install bash ca-certificates \  
ruby ruby-dev \  
ruby-irb \  
ruby-libs \  
ruby-io-console \  
ruby-bigdecimal \  
ruby-json \  
ruby-minitest \  
ruby-rake \  
ruby-rdoc \  
ruby-bundler \  
gcc g++ libgcc \  
make \  
musl-dev \  
zlib zlib-dev \  
libxml2 libxml2-dev \  
libxslt libxslt-dev  
  
ENV PATH /usr/lib/ruby/gems/2.1.0/bin:$PATH  
  
# use IRB by default  
CMD ["irb"]

