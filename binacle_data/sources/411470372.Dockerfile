FROM alpine:3.6
MAINTAINER Markus Krogh <markus@nordu.net>
RUN apk add --no-cache ca-certificates python2 py2-pip
RUN pip install --upgrade pip
RUN mkdir /app
WORKDIR /app
RUN apk add --no-cache nmap nmap-scripts && pip install python-nmap
ADD *.py /app/
ENTRYPOINT ["python2", "nmap_services_py.py"]
CMD ["-h"]
