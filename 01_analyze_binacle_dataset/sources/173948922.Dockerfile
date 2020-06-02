FROM buildpack-deps:xenial

RUN apt-get update

# this gives add-apt-repository
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:jonathonf/tup && apt-get update && apt-get install -y tup
RUN apt-get install -y kmod fuse

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y python3-pip

RUN mkdir /app
WORKDIR /app

ADD requirements.txt .
RUN pip3 install -r requirements.txt

#ADD npm-shrinkwrap.json package.json ./
#RUN npm install

#ADD peru.yaml Makefile ./
#RUN make get_published_docs

#ADD . .

