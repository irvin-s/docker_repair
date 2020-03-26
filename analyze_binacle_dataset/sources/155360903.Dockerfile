FROM ubuntu:trusty
MAINTAINER  Jessica Frazelle <github.com/jfrazelle>

# install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    python-pip \
    --no-install-recommends

# add the source
COPY . /src

# install requirements
RUN cd /src; pip install -U gunicorn
RUN cd /src; pip install -r ./requirements.txt

WORKDIR /src

CMD gunicorn -b 0.0.0.0:5000 app:app