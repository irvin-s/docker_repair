FROM python:2
MAINTAINER https://github.com/SatelliteQE

RUN mkdir automation-tools
COPY / /root/automation-tools
RUN cd /root/automation-tools && pip install -r requirements.txt

ENV HOME /root/automation-tools
WORKDIR /root/automation-tools

CMD ["python"]
