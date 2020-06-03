FROM circleci/golang:1.11.2

RUN sudo apt-get update && sudo apt-get install -y \
    libgtk-3-dev \
    libpcsclite-dev \
    libudev-dev \
    libusb-1.0-0-dev \
&& sudo rm -rf /var/lib/apt/lists/*

RUN go get -u github.com/tcnksm/ghr \
    && go get -u github.com/stevenmatthewt/semantics

RUN curl -L -s https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 -o /go/bin/dep \
    && chmod +x /go/bin/dep

RUN mkdir -p /go/src/github.com/mitchellh/gox
RUN git clone --branch master https://github.com/mitchellh/gox.git /go/src/github.com/mitchellh/gox
RUN cd /go/src/github.com/mitchellh/gox && git reset --hard 9cc487598128d0963ff9dcc51176e722788ec645
RUN cd /go/src/github.com/mitchellh/gox && dep ensure && go install -v ./...
