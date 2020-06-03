FROM ubuntu:17.10

#COPY ./ ./
RUN apt-get update \
    && apt-get install -y vim \
                          curl \
                          wget \
                          default-jdk \
                          maven \
                          gradle \
                          golang-1.9-go \
                          git \
                          jq \
                          python \
                          ruby-dev \
                          python-pip \
                          python-dev \
                          libffi-dev \
                          libssl-dev \
                          libxml2-dev \
                          libxslt1-dev \
                          zlib1g-dev

RUN pip install --upgrade pip 
RUN pip install six \
                pyquery \
                xmltodict \
                ipcalc \
                click \
                Jinja2 \
                shyaml \
                dicttoxml \
                pprint \
                PyYAML \
                requests 

RUN wget -O cf-cli.deb "https://cli.run.pivotal.io/stable?release=debian64&source=github-rel" \
      && dpkg -i cf-cli.deb \
      && mkdir -p $HOME/go/bin $HOME/go/src $HOME/go/pkg  \
      && cp /usr/lib/go*/bin/* /usr/local/bin \
      && export GOPATH=$HOME/go/ \
      && export GOBIN=$GOPATH/bin \
      && export PATH=$PATH:$GOBIN \
      && cf --version \
      && java -version \
      && mvn -v \
      && gradle -v \
      && go version \
      && go get github.com/pivotal-cf/om \
      && go get github.com/pivotal-cf/pivnet-cli \
      && go get github.com/vmware/govmomi/govc \
      && go get github.com/casualjim/yaml2json \
      && gem install cf-uaac
ENV HOME /root
ENV GOPATH $HOME/go
ENV GOBIN $GOPATH/bin
ENV PATH $PATH:$GOBIN:/usr/local/bin:/root/go/bin
