FROM rounds/10m-python
MAINTAINER Aviv Laufer


RUN apt-get update && \
  apt-get install -y  git


RUN cd /root/ && git clone https://github.com/rounds/py-ssj.git
RUN cd /root/py-ssj && pip install -r requirements.txt

CMD cd /root/py-ssj && python py-ssj.py
