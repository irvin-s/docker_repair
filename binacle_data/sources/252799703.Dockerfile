FROM golang:1.6-onbuild  
COPY . /go/src/app  
  
RUN go get -d -v \  
&& go install -v  
  
ENV ELASTICSEARCH_URL http://elasticsearch:9200  
ENV ELASTICSEARCH_USERNAME elastic  
ENV ELASTICSEARCH_PASSWORD changeme  

