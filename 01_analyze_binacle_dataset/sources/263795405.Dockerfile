# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install some packages.
RUN apt-get update; apt-get -y install aptitude wget unzip git

# Install Golang binaries
RUN wget https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz
RUN tar -xvf go1.9.1.linux-amd64.tar.gz; mv go /usr/local/

# Install Terraform.
RUN mkdir /terraform;
WORKDIR /terraform
RUN wget https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_linux_amd64.zip
RUN unzip terraform_0.10.7_linux_amd64.zip
WORKDIR /
RUN mv /terraform /usr/local/

# Set up environment
RUN mkdir -p /gows
ENV GOPATH /gows
ENV GOBIN $GOPATH/bin
ENV PATH $PATH:/usr/local/terraform:/usr/local/go/bin:$GOBIN

# Setup golang deps
RUN go get -v github.com/tools/godep
RUN go get -v github.com/golang/lint/golint
RUN go get -v github.com/axw/gocov
# gocov isn't automatically building and placing binary in $GOBIN
RUN cd ${GOPATH}/src/github.com/axw/gocov/gocov && go build -o ${GOBIN}/gocov
RUN go get -v github.com/AlekSi/gocov-xml
RUN go get -v github.com/matm/gocov-html
RUN go get -v github.com/go-playground/overalls

# Install Terraform linter.
RUN mkdir /terraform-linter
WORKDIR /terraform-linter
RUN wget https://github.com/wata727/tflint/releases/download/v0.4.2/tflint_linux_amd64.zip
RUN unzip tflint_linux_amd64.zip
WORKDIR /
RUN mv /terraform-linter/tflint /usr/bin/
ENV PATH $PATH:/usr/local/terraform:/usr/local/go/bin

RUN apt-get -y install make binutils

# Build the Infoblox provider
ADD . /gows/src/github.com/sky-uk/terraform-provider-infoblox
RUN cd /gows/src/github.com/sky-uk/terraform-provider-infoblox; make fmt; make ; cp /gows/bin/terraform-provider-infoblox /usr/local/terraform/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.ssh/id_rsa*

