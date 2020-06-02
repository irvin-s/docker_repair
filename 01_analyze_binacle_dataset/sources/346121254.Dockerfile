FROM haskell:7.8

RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev libmysqlclient-dev

EXPOSE 3000

COPY ./livelog /livelog

CMD /livelog/api/dist/livelog-exe
