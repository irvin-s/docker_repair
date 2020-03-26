FROM python:2
ENV PYTHONUNBUFFERED 1  

EXPOSE 80
EXPOSE 443

RUN apt update
RUN apt install -y  nginx

RUN mkdir /src
WORKDIR /src
ADD . /src

RUN pip install -r requirements.txt

RUN ln -s /src/nginx-memes.conf /etc/nginx/sites-enabled/memes.conf
RUN chmod +X /src/web-startup.sh

CMD ["/bin/bash", "/src/web-startup.sh"]