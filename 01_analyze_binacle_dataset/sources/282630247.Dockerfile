FROM python

VOLUME /root

ARG PROJECT_NAME
ARG TIMEZONE

ENV GUNICORN_PROJECT ${PROJECT_NAME}.wsgi:application
ENV TZ=${TIMEZONE}

WORKDIR /root

ADD ./application/requirements.txt /requirements.txt

RUN pip install --upgrade pip
RUN pip install -r /requirements.txt
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80

CMD gunicorn --bind 0.0.0.0:80 --reload ${GUNICORN_PROJECT}
