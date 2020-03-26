FROM registry.opensource.zalan.do/stups/python:3.5.0-5

EXPOSE 8080
WORKDIR /

COPY requirements.txt /
RUN pip3 install -r /requirements.txt

COPY app.py /
COPY customer-service.wsdl /
COPY scm-source.json /

CMD /app.py
