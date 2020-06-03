FROM alpine:latest
LABEL maintainer="kangae2@gmail.com"

ADD https://storage.googleapis.com/alpine-nlp-jp/kangae2%40gmail.com-5b1c9331.rsa.pub /etc/apk/keys/ 
RUN echo "https://storage.googleapis.com/alpine-nlp-jp" >> /etc/apk/repositories && \
  apk add --update --no-cache mecab mecab-ipadic jumanpp knp 

CMD ["/bin/sh"]
