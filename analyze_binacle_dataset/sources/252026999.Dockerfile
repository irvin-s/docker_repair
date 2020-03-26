FROM alpine:edge

MAINTAINER Conor Anderson <conor@conr.ca>

RUN  apk add --no-cache go \
                        nodejs \
                        python \
                        git \
                        make \ 
                        g++ \
                        curl \
                        musl-dev && \
     adduser maker -D && \
     mkdir -p /opt/go

ENV  GOPATH=/opt/go

RUN  git config --global user.email "mail@example.com" && \
     git config --global user.name "Done, Gitter" && \ 
     go get -u github.com/emersion/neutron && \
     cd $GOPATH/src/github.com/emersion/neutron && \
     echo "cd $PWD && go run neutron.go ." > /usr/bin/neutron && \
     chmod +x /usr/bin/neutron && \
     mkdir -p /config && \
     mv $GOPATH/src/github.com/emersion/neutron/db /config && \
     mv $GOPATH/src/github.com/emersion/neutron/config.json /config && \
     ln -s /config/db $GOPATH/src/github.com/emersion/neutron/ && \
     ln -s /config/config.json $GOPATH/src/github.com/emersion/neutron/ && \
     chown -R maker:users /opt/go

USER maker

WORKDIR $GOPATH/src/github.com/emersion/neutron

RUN  git config --global user.email "mail@example.com" && \
     git config --global user.name "Done, Gitter" && \
     git submodule init  && \
     git submodule update && \
     bowver=$(curl -s -N https://github.com/angular/angular.js/releases.atom | grep -o -m1 1.5.* | sed 's/<\/id>//g') &&\
     sed -i "s/\"angular\": \"1.5.6\"/\"angular\": \"${bowver}\"/g" public/bower.json && \
     make build-client && \
     sed -i 's/https:\/\/github.com\/ProtonMail\/WebClient.git/https:\/\/github.com\/vpapadopou\/Neutron-WebClient.git/g' .gitmodules  && \
     git submodule sync  && \
     cd public && \
     git stash && \
     git stash clear && \
     git checkout public && \
     git reset --hard 3dc709cbfc1337919d0e3bec55077f3f91b0ae6e && \
     git pull origin public && \
     cd .. && \
     make build-client && \
     rm -rf /tmp/*
     
EXPOSE  4000

CMD  '/usr/bin/neutron'
