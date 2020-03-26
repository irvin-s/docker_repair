FROM ubuntu:xenial
# Hugo install sequence based on Dockerfile from https://bitbucket.org/fmanco/docker-images

# Upgrade
RUN apt-get update && apt-get -y upgrade -u && apt-get clean

# Install git and ssh client to retrieve sources
RUN apt-get install -y --no-install-recommends openssh-client git

# Install hugo
ENV hugo_deb_url=https://github.com/gohugoio/hugo/releases/download/v0.26/hugo_0.26_Linux-64bit.deb
ADD ${hugo_deb_url} /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb && rm -f /tmp/hugo.deb

# install AWS CLI and pygments
RUN apt-get -y install python-pip && \
    pip install awscli && \
    pip install pygments

COPY hugo-s3.sh /
RUN chmod +x /hugo-s3.sh

ENTRYPOINT ["/hugo-s3.sh"]
