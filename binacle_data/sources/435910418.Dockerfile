FROM alpine:latest

RUN apk add --no-cache python python-dev gcc g++ make libffi-dev openssl-dev && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache


COPY src/requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

#create ctf-user
RUN addgroup -S ctf && adduser -S -G ctf ctf

#add chall items
ADD src/keystore.py /home/ctf/keystore.py
ADD src/static/index.html /home/ctf/static/index.html

#set some proper permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/keystore.py
RUN chmod 750 /home/ctf/static/index.html

ENV FLASK_APP=keystore.py

WORKDIR /home/ctf
EXPOSE 80
CMD ["flask", "run", "--port=80", "--host=0.0.0.0"]
