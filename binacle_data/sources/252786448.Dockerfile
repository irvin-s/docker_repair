FROM alpine:3.7 AS bundler  
RUN apk add --no-cache py-pip && pip install exodus-bundler  
RUN apk add --no-cache curl  
WORKDIR curl  
RUN exodus -v --tarball curl | tar xz --strip-components=1 && \  
sed -i '' bundles/*/lib/* && \  
sed -i '' bundles/*/usr/bin/curl-x && \  
sed -i '' bundles/*/usr/lib/*  
RUN mkdir output && \  
mv /etc/ssl/certs/ca-certificates.crt output/ && \  
mv bundles/*/lib/* bundles/*/usr/lib/* output/ && \  
mv bundles/*/usr/bin/curl-x output/curl && \  
mv output/ld-* output/ld  
  
FROM scratch  
COPY \--from=bundler curl/output /  
ENV CURL_CA_BUNDLE=/ca-certificates.crt  
ENTRYPOINT [ "./ld", "--library-path", "/", "curl" ]  

