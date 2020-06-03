## how to run
## docker run -t -p <port> -v /var/run/docker.sock:/docker.sock -v <figapp>:/app larrycai/fig

FROM ubuntu:latest
MAINTAINER Larry Cai "larry.caiyu@gmail.com"
ENV REFREST_AT 20141015

RUN apt-get update && apt-get install -y curl make

RUN \
    curl -L https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker  && \
    chmod +x /usr/local/bin/docker && \
    
    # see http://www.fig.sh/install.html 
    curl -L https://github.com/docker/fig/releases/download/1.0.0/fig-`uname -s`-`uname -m`  -o /usr/local/bin/fig && \
    chmod +x /usr/local/bin/fig 
    
ENV DOCKER_HOST unix:///docker.sock

WORKDIR /app

# set initial command

ENTRYPOINT ["/usr/local/bin/fig"]
CMD ["-v"]