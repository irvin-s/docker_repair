FROM crossbario/autobahn-python:cpy3

USER root

WORKDIR /workspace

COPY ${PWD}/app /workspace

RUN pip3 install -r requirements.txt && rm -rf ~/.cache/pip

CMD ["python3", "-u", "server.py"]
