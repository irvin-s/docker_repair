FROM ubuntu:14.04

WORKDIR /root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server wget


# Устанавливаем Go, создаем workspace и папку проекта
RUN wget https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz &&\
	tar -C /usr/local -xzf go1.9.linux-amd64.tar.gz && \
    mkdir go && mkdir go/src && mkdir go/bin && mkdir go/pkg && \
    mkdir go/src/dumb

ENV PATH=${PATH}:/usr/local/go/bin GOROOT=/usr/local/go GOPATH=/root/go

# Копируем наш исходный main.go внутрь контейнера, в папку go/src/dumb
ADD data_FULL.zip /tmp/data/data.zip
ADD . /  go/src/dumb/
#ADD my.cnf /etc/mysql/my.cnf 

WORKDIR /root/go/src/dumb

# Компилируем и устанавливаем наш сервер
RUN go build

# Открываем 80-й порт наружу
EXPOSE 8080

CMD ./dumb

#ENV MYSQL_USER=mysql \
#    MYSQL_DATA_DIR=/var/lib/mysql \
#    MYSQL_RUN_DIR=/run/mysqld \
#    MYSQL_LOG_DIR=/var/log/mysql
   
#VOLUME ["${MYSQL_DATA_DIR}", "${MYSQL_RUN_DIR}", "${MYSQL_LOG_DIR}"]

#CMD ./start.sh