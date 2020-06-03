FROM ubuntu:14.04
MAINTAINER Mert Kahyaoğlu <mertkahyaoglu93@gmail.com>
RUN apt-get update
RUN apt-get install -y nodejs npm
COPY . /src/
EXPOSE 3001
CMD ["nodejs", "/src/server.js"]
