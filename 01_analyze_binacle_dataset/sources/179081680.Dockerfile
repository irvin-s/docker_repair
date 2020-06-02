FROM ubuntu:14.10

RUN apt-get update
RUN apt-get install -y python3-setuptools

RUN easy_install3 pip
RUN pip3 install stdeb

# Needed for stdeb
RUN apt-get install -y debhelper python-all python3-all

WORKDIR /source

# build deb package and change owner of the created files to the original owner
CMD python3 setup.py --command-packages=stdeb.command bdist_deb && chown -R $(stat -c '%u:%g' ./) deb_dist/
