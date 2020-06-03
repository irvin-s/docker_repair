FROM numenta/nupic  
  
MAINTAINER Allan Costa <allan@cloudwalk.io>  
  
# Install redis and go  
RUN \  
wget http://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz;\  
tar -C /usr/local -xzf go1.1.2.linux-amd64.tar.gz;\  
rm go1.1.2.linux-amd64.tar.gz;\  
  
wget http://download.redis.io/releases/redis-2.6.16.tar.gz;\  
tar -xzf redis-2.6.16.tar.gz;\  
cd redis-2.6.16;\  
make;\  
rm ../redis-2.6.16.tar.gz;  
#RUN  
# Install Supervisor  
RUN apt-get install -y supervisor  
  
# Add redis and go to path  
ENV GOPATH /home/docker/go  
ENV PATH /home/docker/redis-2.6.16/src:/usr/local/go/bin:$PATH  
  
# Install Python dependencies (others than NuPIC)  
ADD requirements.txt /home/docker/omg-monitor/requirements.txt  
WORKDIR /home/docker/omg-monitor/  
RUN pip install -r requirements.txt  
  
# Install go packages and build go api  
RUN \  
go get github.com/codegangsta/martini;\  
go get github.com/garyburd/redigo/redis;  
#RUN  
ADD server/ /home/docker/omg-monitor/server  
# Build Go server's binary  
RUN \  
cd /home/docker/omg-monitor/server;\  
go build;  
#RUN  
# Copy omg-monitor directory  
ADD startup.sh /home/docker/omg-monitor/startup.sh  
ADD monitor/ /home/docker/omg-monitor/monitor  
ADD config/ /home/docker/omg-monitor/config  
  
EXPOSE 5000  
# Set directory for logs  
ENV LOG_DIR /var/log/docker/monitor  
  
ENV OMG_MONITOR_PORT 5000  
WORKDIR /home/docker/omg-monitor/  
  
ENTRYPOINT ["./startup.sh"]  

