FROM kernsuite/base:1

RUN docker-apt-install meqtrees

ENV MEQTREES_CATTERY_PATH /usr/lib/python2.7/dist-packages/Cattery

RUN pip install kliko

ADD kliko.yml /
ADD kliko /
ADD batch.tdlconf /

CMD meqtree-pipeliner.py
