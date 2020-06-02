FROM openai/retro-agent:pytorch

# Needed for OpenCV.
RUN apt-get update && \
    apt-get install -y libgtk2.0-dev && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp
RUN . ~/venv/bin/activate && \
    pip install -r /tmp/requirements.txt && \
    pip install --no-deps git+https://github.com/fgvbrt/baselines.git@1659068fdeb5fd4859fa598634008a84afe3616e && \
    git clone https://github.com/openai/retro-contest.git && cd retro-contest/support && \
    pip install .

ADD *.py ./
ADD *.yaml ./
ADD test.sh ./
ADD *.pt ./

CMD ["/bin/bash", "test.sh"]
