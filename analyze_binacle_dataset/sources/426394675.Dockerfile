from node:5.5.0

RUN apt-get update
RUN apt-get install make 
RUN apt-get install jq
RUN apt-get install bc

# Add Docker Client 
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get -y install docker-ce

RUN npm install -g igroff/difftest-runner
RUN npm install -g coffee-script

RUN mkdir /var/app
WORKDIR /var/app
ADD . /var/app


RUN make build

#ENTRYPOINT ["/bin/bash"]
CMD ["./epistream.coffee"]
