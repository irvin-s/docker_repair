# docker build -t accetto/hello-there-debian .  
# docker run --name=hello-debian accetto/hello-there-debian  
# docker start -i hello-debian  
# size of 'debian:stretch-slim': 55.25 MB  
# size of 'accetto/hello-there-debian': 55.45 MB  
FROM debian:stretch-slim  
  
ENV REFRESHED_AT 2018-04-07  
LABEL vendor="accetto" \  
maintainer="https://github.com/accetto" \  
any.accetto.description="Docker test image hello-there-debian" \  
any.accetto.display-name="Docker test image hello-there-debian" \  
any.accetto.expose-services="none" \  
any.accetto.tags="hello-there, test, debian"  
  
WORKDIR /usr/src/hello  
  
COPY ./src .  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends gcc libc6-dev \  
&& gcc hello.c -o hello \  
&& apt-get remove -y --purge gcc libc6-dev \  
&& apt-get autoremove -y --purge \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
CMD ["./hello"]  

