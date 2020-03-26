FROM rancher/agent
ADD entrypoint.py /
ENTRYPOINT /entrypoint.py
