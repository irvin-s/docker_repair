FROM golang:1.5.4-wheezy  
  
WORKDIR /app  
ADD . /app  
  
RUN mkdir -p /go/src/github.com/grafana/  
RUN ln -s /app/ /go/src/github.com/grafana/grafana  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get update && apt-get install -y git gcc nodejs bzip2 && \  
npm install && \  
go run build.go setup && \  
go run build.go build && \  
npm run build && \  
apt-get remove -y git gcc nodejs bzip2 && \  
apt-get autoremove -y && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf node_modules && \  
rm -rf /tmp/* /root/.npm /root/.node-gyp && \  
rm -rf /app/Godeps && \  
rm -rf /app/public  
  
CMD ["/app/bin/grafana-server"]  

