FROM debian:jessie  
MAINTAINER Alex Shkop <a.v.shkop@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# install Ruby  
RUN apt-get update && apt-get install -yqq ruby rubygems-integration git  
  
# install fake-s3  
RUN git clone https://github.com/ashkop/fake-s3.git  
RUN cd fake-s3 && gem build fakes3.gemspec && gem install fakes3-1.2.0.gem  
  
# run fake-s3  
RUN mkdir -p /fakes3_root  
ENTRYPOINT ["/usr/local/bin/fakes3"]  
CMD ["-r", "/fakes3_root", "-p", "4569", "--do-not-reverse-lookup"]  
EXPOSE 4569  

