FROM antik486/docker-erl  
MAINTAINER antik486 <antik486@gmail.com>  
  
RUN yum -y update; \  
yum -y install ruby ruby-devel rpm-build hostname; \  
yum clean all  
  
RUN git clone https://github.com/basho/rebar.git /tmp/rebar; \  
cd /tmp/rebar; \  
./bootstrap; \  
mkdir -p /opt/rebar/; \  
cp /tmp/rebar/rebar /opt/rebar/; \  
chmod +x /opt/rebar/rebar; \  
rm -Rf /tmp/rebar;  
  
ENV PATH /opt/rebar:$PATH  
  
RUN gem install fpm  
  
VOLUME ["/opt/app"]  
  
WORKDIR /opt/app  
  
ENTRYPOINT ["bash"]  

