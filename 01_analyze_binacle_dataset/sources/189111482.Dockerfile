FROM rounds/10m-python
MAINTAINER Ofir Petrushka

RUN \
  apt-get update && \
  apt-get install -y graphite-carbon && \
  rm -fr /var/lib/apt/lists/*

# No Deamon patch
# https://github.com/graphite-project/carbon/commit/0d4407466d1a96765400cac0c1945108a34fbe80
RUN curl https://raw.githubusercontent.com/graphite-project/carbon/0d4407466d1a96765400cac0c1945108a34fbe80/lib/carbon/util.py -o /usr/lib/python2.7/dist-packages/carbon/util.py
RUN curl https://raw.githubusercontent.com/graphite-project/carbon/0d4407466d1a96765400cac0c1945108a34fbe80/lib/carbon/conf.py -o /usr/lib/python2.7/dist-packages/carbon/conf.py
