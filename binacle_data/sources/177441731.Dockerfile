FROM scratch
MAINTAINER estesp@gmail.com

ENTRYPOINT [ "/tinygo" ]
EXPOSE 80
COPY tinygo /
