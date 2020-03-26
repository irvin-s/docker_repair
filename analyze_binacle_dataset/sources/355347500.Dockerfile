#
# A Docker image for neuroscience data analysis with Python
#


FROM neuralensemble/base
MAINTAINER andrew.davison@unic.cnrs-gif.fr

RUN $VENV/bin/pip install elephant

# in analysisX, add SpykeViewer, OpenElectrophy, KlustaSuite

WORKDIR /home/docker/
