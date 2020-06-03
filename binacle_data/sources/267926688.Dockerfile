# Simple Dockerfile for wrapping https://github.com/neufv/put-me-on-a-watchlist in a docker container

FROM python:3.3-slim

RUN pip install requests

ADD put-me-on-a-watchlist.py /
CMD ["python", "/put-me-on-a-watchlist.py"]
