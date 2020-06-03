FROM golang:1.8-alpine  
  
ENV PROJECT=coreos-version-checker  
COPY . /${PROJECT}-sources/  
  
RUN apk --no-cache --virtual .build-dependencies add git \  
&& ORG_PATH="github.com/Financial-Times" \  
&& REPO_PATH="${ORG_PATH}/${PROJECT}" \  
&& mkdir -p $GOPATH/src/${ORG_PATH} \  
# Linking the project sources in the GOPATH folder  
&& ln -s /${PROJECT}-sources $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& echo "Fetching dependencies..." \  
&& go get -u github.com/kardianos/govendor \  
&& $GOPATH/bin/govendor sync \  
&& go get -v \  
&& go build \  
&& mv ${PROJECT} /${PROJECT} \  
&& apk del .build-dependencies \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
WORKDIR /  
  
EXPOSE 8080  
CMD [ "/coreos-version-checker" ]

