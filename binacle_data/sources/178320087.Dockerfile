# Dockerfile for Python 3 runtime
#
# This was constructed by looking at both the google/appengine-python27 image
# history (it looks like the source isn't available) and the sample dockerfile
# here: http://www.chinacloud.cn/upload/2014-06/14062000246508.pdf . To keep the
# image size small, we avoid working off of the Python 2.7 runtime, since we
# would just need to uninstall all of the Python 2 dependencies anyway.

# Use jessie instead of wheezy since jessie supports Python 3.4 installation
# through apt-get (in wheezy, you have to install from source, which is
# annoying).
FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update ; apt-get -y -q --no-install-recommends install \
    ca-certificates \
    python3 \
    python3-pip

RUN pip3 install \
    CherryPy \
    requests

RUN ln -s /home/vmagent/app /app

CMD []
ENTRYPOINT ["/home/vmagent/python_vm_runtime_py3/vmboot.py"]
WORKDIR /app
EXPOSE 8080

ADD . /home/vmagent/python_vm_runtime_py3
