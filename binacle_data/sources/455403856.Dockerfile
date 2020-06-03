FROM foodtiny/native:development
MAINTAINER Loi Nguyen <loint@foodtiny.com>

ADD ApplicationTest.cpp .
RUN g++ -c -o main.o ApplicationTest.cpp
RUN g++ -o main main.o -lnative

ENTRYPOINT ./main