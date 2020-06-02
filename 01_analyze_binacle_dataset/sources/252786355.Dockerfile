FROM dock0/build  
MAINTAINER akerl <me@lesaker.org>  
RUN gem install --no-user-install --no-document pkgforge  
CMD ["pkgforge", "build"]  

