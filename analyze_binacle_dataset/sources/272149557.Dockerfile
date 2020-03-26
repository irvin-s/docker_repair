ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache swig libressl-dev python-dev libusb py-yaml py-flask py-pip build-base
RUN pip install https://pypi.python.org/packages/source/M/M2Crypto/M2Crypto-0.24.0.tar.gz
RUN pip install firetv[firetv-server]

COPY run.sh /
COPY json2yaml.py /
RUN chmod a+x /run.sh json2yaml.py

CMD [ "/run.sh" ]
