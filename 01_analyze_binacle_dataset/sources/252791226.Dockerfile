FROM golang:1.7.3  
EXPOSE 8000  
COPY . $GOPATH/src/github.com/lgtmco/lgtm  
RUN make -C $GOPATH/src/github.com/lgtmco/lgtm build && \  
mv $GOPATH/src/github.com/lgtmco/lgtm/lgtm /lgtm && \  
useradd -d/ -s/bin/false lgtm && \  
mkdir -p /var/lib/lgtm/ && \  
chown lgtm:lgtm /var/lib/lgtm  
  
ENV DATABASE_DRIVER=sqlite3  
ENV DATABASE_DATASOURCE=/var/lib/lgtm/lgtm.sqlite  
ENV GODEBUG=netdns=go  
  
# You need to set the following on the command-line.  
ENV GITHUB_CLIENT=  
ENV GITHUB_SECRET=  
  
USER lgtm:lgtm  
VOLUME ["/var/lib/lgtm"]  
ENTRYPOINT ["/lgtm"]  

