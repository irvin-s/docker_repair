FROM ubuntu:trusty
RUN apt-get update
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN apt-get install python-pip python-dev libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev wget vim libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk python-mysqldb
RUN pip -r requirements.txt
RUN mkdir -p /opt/openslack && cd /opt/openslack && git clone https://github.com/openslack/openslack-crawler.git
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-s"]
