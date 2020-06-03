FROM golang:1.10-alpine as on-change  
RUN apk --update add git && \  
rm -rf /var/cache/apk/* && \  
/usr/local/go/bin/go get github.com/spelufo/on-change  
  
FROM node:9-stretch  
COPY \--from=on-change /go/bin/on-change /usr/local/bin  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
gifsicle \  
gosu \  
graphviz \  
groff \  
imagemagick \  
lmodern \  
make \  
pandoc \  
texlive-extra-utils \  
texlive-fonts-extra \  
texlive-fonts-recommended \  
texlive-font-utils \  
texlive-latex-base \  
texlive-latex-extra \  
texlive-luatex \  
texlive-publishers && \  
npm --global install --no-save --unsafe-perm asciicast2gif && \  
rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/* ~/.npm  
COPY example/ ./example/  
COPY policy.xml /etc/ImageMagick-6/policy.xml  
# Run a test build.  
RUN make -C example all clean  
ADD [ "https://www.shore.co.il/blog/static/runas", "/entrypoint" ]  
ENTRYPOINT [ "/bin/sh", "/entrypoint" ]  
VOLUME /volume  
WORKDIR /volume  
ENV HOME /volume  
CMD [ "on-change", ".", "make" ]  

