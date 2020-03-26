FROM pygatb/alpine_runtime_base
CMD ["/usr/bin/python3"]

# Install pyGATB
ARG PYGATB_EGG
COPY $PYGATB_EGG "/tmp/$PYGATB_EGG"

RUN easy_install-3.5 "/tmp/$PYGATB_EGG" \
 && python3 -m unittest discover gatb \
 && rm "/tmp/$PYGATB_EGG"

# Set work dir with samples
WORKDIR /home/work
COPY samples .
VOLUME /home/work
