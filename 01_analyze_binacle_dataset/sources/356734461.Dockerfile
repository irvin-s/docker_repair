# Python3 MapReduce on a notebook server - mrjob

# Stack with no hub:
# $ cd python/py3base; docker build -t pdonorio/py3kbase .
# $ cd ../py3dataconda; docker build -t pdonorio/py3dataconda .
# $ cd ../py3mapreduce; docker build -t pdonorio/py3mapreduce .

#FROM pdonorio/jupy3k
FROM pdonorio/py3dataconda

MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

###############################
# Add mrjob from Yelp
WORKDIR /opt
# Dependencies
RUN apt-get install -y libyaml-dev
# Install and not remove from installation!
RUN git clone https://github.com/Yelp/mrjob \
    && cd mrjob && $CONDA_ACTIVATE && pip install -e .
# Extra libs (jinja2 is already requested from ipython)
RUN $CONDA_ACTIVATE && pip install plumbum

###############################
WORKDIR /data
