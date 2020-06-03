FROM google/python

RUN virtualenv /env
RUN /env/bin/pip install devpi-server

VOLUME  ["/cache"]

EXPOSE 3141

CMD ["/env/bin/devpi-server", "--serverdir", "/cache", "--host", "0.0.0.0"]

