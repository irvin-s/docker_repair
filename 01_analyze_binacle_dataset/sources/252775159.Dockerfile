FROM ruby:2.3  
RUN \  
# Install fakes3.  
git clone https://github.com/beanworks/fake-s3.git && \  
cd fake-s3 && \  
bundle install && \  
# Create fakes3 filesystem directory.  
mkdir -p /fakes3_root  
  
# Fails to require "fakes3/cli" without moving to this directory.  
# Maybe some ruby expert can figure out how to avoid this.  
WORKDIR /fake-s3  
  
ENTRYPOINT ["/fake-s3/bin/fakes3"]  
CMD ["-r", "/fakes3_root", "-p", "4569"]  
EXPOSE 4569  

