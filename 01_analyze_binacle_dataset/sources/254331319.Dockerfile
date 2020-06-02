# Set the base image to Ubuntu
FROM    joewhaley/docker-flask-pandas:latest

# File Author / Maintainer
MAINTAINER Lef Ioannidis

ADD requirements.txt /tmp/requirements.txt

# Install oracle dependencies
RUN pip install -r /tmp/requirements.txt

# Define working directory
RUN mkdir /src
ADD . /src
WORKDIR /src

# Expose ports
EXPOSE 8080

# Wait for postgres
# Start nodeJS UnifyID backend
CMD ["make", "run"]
