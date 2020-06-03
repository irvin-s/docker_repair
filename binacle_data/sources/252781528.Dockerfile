FROM golang:1.9  
  
RUN go get -d k8s.io/helm 2>/dev/null || true \  
&& cd /go/src/k8s.io/helm \  
&& make bootstrap \  
&& rm -rf /root/.glide/cache  
RUN cp -r /go/src/k8s.io/helm/vendor/* /go/src/ \  
&& rm -rf /go/src/k8s.io/helm/vendor/  
RUN go install -v k8s.io/helm/cmd/helm/  

