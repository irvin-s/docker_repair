FROM ubuntu:16.04
WORKDIR /opt/middle_tier

RUN apt-get update && apt-get install -qy \
    build-essential python3-dev

RUN apt-get install -qy virtualenv
RUN virtualenv -p /usr/bin/python3.5 /opt/penv

COPY requirements.txt /opt/middle_tier
RUN . /opt/penv/bin/activate&&pip3 install -r requirements.txt

EXPOSE 80
ENTRYPOINT ["/opt/penv/bin/python"]
CMD ["app.py"]
