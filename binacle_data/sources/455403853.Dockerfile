FROM foodtiny/native:development
MAINTAINER Loi Nguyen <loint@foodtiny.com>

ADD Application.cpp .
RUN g++ -c -o main.o Application.cpp
RUN g++ -o main main.o -lnative

ENTRYPOINT ./main