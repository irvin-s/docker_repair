FROM dock0/foreman  
MAINTAINER akerl <me@lesaker.org>  
# Must install libxslt and libxml2 and use system libs for bundle install  
# Due to nokogiri/overlayfs bug  
RUN pacman -S --noconfirm --needed libxml2 libxslt  
ADD source /srv/app  
RUN NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install --gemfile /srv/app/Gemfile  
ENV PORT 80  
ENV TZ America/New_York  

