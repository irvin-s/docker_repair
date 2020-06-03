COPY --chown=0:0 python3-runtime/context/pipe /usr/local/bin/algorithmia-pipe
ENV PATH=$PATH:/home/algo/.local/bin
RUN pip install six