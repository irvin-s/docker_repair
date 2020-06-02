FROM arm64v8/python:3.6.8-alpine3.8

WORKDIR /usr/src/app

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories

RUN	apk update && \
	apk add --no-cache git

COPY ./requirements.txt ./
COPY ./start.sh ./
COPY ./crontab.txt ./

RUN /usr/bin/crontab crontab.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["/bin/sh" , "start.sh"]