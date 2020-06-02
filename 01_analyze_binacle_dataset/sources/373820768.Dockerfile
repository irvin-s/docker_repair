FROM moul/python-dev
MAINTAINER Manfred Touron "m@42.am"

ADD . /app
WORKDIR /app
ENTRYPOINT ["python", "frosty.py"]
EXPOSE 80