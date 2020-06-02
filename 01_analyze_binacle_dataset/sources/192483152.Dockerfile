# start from the public ubuntu 14.04 image
FROM stackbrew/ubuntu:14.04

# install package dependencies
RUN apt-get update && apt-get install -y \
    libpython2.7-dev \
    libyaml-dev \
    python2.7 \
    python-pip

# start all following commands from /conductor
WORKDIR /conductor

# add the python requirements.txt file from this repo
ADD requirements.txt /conductor/requirements.txt

# install python dependencies
RUN pip install -r requirements.txt

# add docker/entrypoint.sh into image at /usr/local/bin/entrypoint
ADD docker/entrypoint.sh /usr/local/bin/entrypoint

# set the entrypoint script to be the default executable
ENTRYPOINT ["/usr/local/bin/entrypoint"]

# default to --help if no command is specified
CMD ["--help"]

# add the remaining files from this repo
ADD . /conductor
