FROM progrium/busybox  
  
MAINTAINER Amajd Masad <amjad.masad@gmail.com>  
  
RUN opkg-install ruby ruby-stdlib  
RUN gem install --no-user-install rspec  

