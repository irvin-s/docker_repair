FROM python:3.5
MAINTAINER gijsmolenaar@gmail.com
RUN pip install astropy
RUN pip install https://github.com/gijzelaerr/kliko/archive/master.zip
ADD kliko.yml /
ADD kliko /
RUN chmod 755 /kliko
CMD /kliko
