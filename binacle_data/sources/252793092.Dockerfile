FROM google/cloud-sdk  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
g++ \  
gcc \  
vim \  
libc6-dev \  
make \  
git \  
golang \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV PATH=${PATH}:/google-cloud-sdk/platform/google_appengine  
  
RUN chmod +x /google-cloud-sdk/platform/google_appengine/goapp  
RUN mkdir -p /go  
ENV GOPATH /go  
  
RUN go get google.golang.org/appengine/...  
  
EXPOSE 8080 8000  

