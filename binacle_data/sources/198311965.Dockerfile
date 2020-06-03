COPY --chown=0:0 python2-buildtime/context/build /usr/local/bin/algorithmia-build
COPY --chown=0:0 python2-buildtime/context/test /usr/local/bin/algorithmia-test
ENV PATH=$PATH:/home/algo/.local/bin
