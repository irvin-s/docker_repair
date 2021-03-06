#FROM python:3.5-alpine
FROM python:3.5-jessie
ADD ./ /sb/
WORKDIR /sb/

#ARG PASS

#RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

#RUN apk add --update --no-cache ca-certificates gcc g++ curl openblas-dev@community

#RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN pip install --upgrade pip

#RUN pip install -r /sb/requirements.txt

#CMD python3 ./insert_admin.py --password ${PASS}

RUN pip install .

WORKDIR /sb/app/

CMD ["python3", "./app.py"]