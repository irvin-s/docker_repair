# https://shopify.github.io/dashing/  
FROM brimstone/ubuntu:14.04  
MAINTAINER brimstone@the.narro.ws  
  
# Install the packages we need, clean up after them and us  
RUN package bundler ruby-dev build-essential vim nodejs zlib1g-dev \  
  
&& gem install --no-ri --no-rdoc dashing execjs dashing-contrib  
  
ADD loader /loader  
  
# Set our command  
ENTRYPOINT ["/loader"]  
  
WORKDIR /dashboard  
  
CMD ["start"]  
  
VOLUME /dashboard  
  
EXPOSE 3030  

