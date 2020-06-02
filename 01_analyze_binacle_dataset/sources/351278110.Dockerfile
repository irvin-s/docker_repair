FROM      ubuntu
MAINTAINER Politecnico di Torino

RUN apt-get update
RUN apt-get install -y libpcap-dev
RUN apt-get install -y build-essential cmake

RUN mkdir example
ADD example.c example/example.c
ADD CMakeLists.txt example/CMakeLists.txt
#RUN gcc example.c -lpcap -o example
RUN cd example && cmake . && make

CMD ./example/example
