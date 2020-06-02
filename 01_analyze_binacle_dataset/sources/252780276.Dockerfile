FROM ruby:2.2-slim  
  
# Install gem and packages  
RUN apt-get update -qqy \  
&& apt-get install -qqy \  
git wget curl \  
build-essential \  
rpm createrepo aptly\  
bzip2 \  
gnupg gpgv \  
&& apt-get clean -qq \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& gem install fpm --no-ri --no-rdoc  
  
# Define mountable directories.  
VOLUME ["/data"]  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

