FROM python:3.6-slim-stretch

# Install OS-level dependencies for Grout
RUN apt-get update
RUN apt-get -y autoremove && apt-get install -y \
	libgeos-dev \
	binutils \
	libproj-dev \
	gdal-bin

COPY . /opt/grout
WORKDIR /opt/grout

RUN pip install -e .
RUN pip install tox

CMD ["tox"]
