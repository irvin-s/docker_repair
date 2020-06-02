# docker build -t accetto/hello-there-alpine .  
# docker run --name=hello-alpine accetto/hello-there-alpine  
# docker start -i hello-alpine  
# size of 'alpine:latest': 4.139 MB  
# size of 'accetto/hello-there-alpine': 4.17 MB  
FROM alpine  
  
ENV REFRESHED_AT 2018-04-07  
LABEL vendor="accetto" \  
maintainer="https://github.com/accetto" \  
any.accetto.description="Docker test image hello-there-alpine" \  
any.accetto.display-name="Docker test image hello-there-alpine" \  
any.accetto.expose-services="none" \  
any.accetto.tags="hello-there, test, alpine"  
  
WORKDIR /usr/src/hello  
  
COPY ./src .  
  
RUN apk add --no-cache build-base \  
&& gcc hello.c -o hello \  
&& apk del --purge build-base  
  
CMD ["./hello"]  

