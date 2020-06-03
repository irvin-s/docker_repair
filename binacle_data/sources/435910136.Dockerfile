FROM ubuntu:16.04

MAINTAINER avlidienbrunn

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install build-essential -y
RUN apt-get install libmagickwand-dev -y
RUN apt-get install imagemagick -y

RUN apt-get install -y python-pip python-dev build-essential libmysqlclient-dev nano curl

ENV APP_DIR /app

WORKDIR $APP_DIR

ADD . $APP_DIR/

RUN pip install -r /app/requirements.txt

ADD policy.xml /etc/ImageMagick-6/policy.xml

ADD flag /flag
RUN chmod 655 /flag
ADD flag /etc/flag
RUN chmod 655 /etc/flag
ADD flag /app/flag
RUN chmod 655 /app/flag
ADD flag /flag.txt
RUN chmod 655 /flag.txt
ADD flag /etc/flag.txt
RUN chmod 655 /etc/flag.txt
ADD flag /app/flag.txt
RUN chmod 655 /app/flag.txt

RUN ls /app/img/|grep -v css|xargs rm -f
RUN chmod 766 /app/img

RUN useradd -c 'flag is in /flag' -m -d /home/jailer -s /bin/bash jailer
RUN chown -R jailer:jailer /app/img
USER jailer

ENTRYPOINT ["python"]
CMD ["app.py"]