FROM aist-python

USER root

RUN apk add build-base gcc abuild binutils binutils-doc gcc-doc

COPY requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

RUN python3 -m spacy download en

RUN python3 -m nltk.downloader wordnet
RUN pip install gunicorn
RUN pip install gevent

COPY src /app

EXPOSE 80

COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]