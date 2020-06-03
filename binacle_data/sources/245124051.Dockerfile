FROM python:3.6-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential python3-dev libffi-dev
ENV PYTHONUNBUFFERED 1
