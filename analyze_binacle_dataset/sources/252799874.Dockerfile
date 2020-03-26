FROM golang:alpine  
  
COPY ghbackup.sh /usr/local/bin/ghbackup.sh  
  
RUN chmod +x /usr/local/bin/ghbackup.sh && \  
apk add --no-cache git && \  
go get github.com/qvl/ghbackup && \  
go build -o /usr/bin/ghbackup github.com/qvl/ghbackup && \  
rm -R /go/src/github.com && \  
ghbackup -version  
  
RUN echo '0 * * * * /usr/local/bin/ghbackup.sh' > /etc/crontabs/root  
  
CMD ["/usr/sbin/crond", "-f"]  

