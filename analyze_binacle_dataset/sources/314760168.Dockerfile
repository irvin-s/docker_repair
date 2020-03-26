FROM python:3.6
LABEL maintainer="Dmitry Rodin <madiedinro@gmail.com>"
LABEL band.base-py.version="0.17.6"

RUN apt-get update && apt-get install -y --no-install-recommends \
		wget \
        curl \
		unzip \
		gzip \
        nano \
	&& rm -rf /var/lib/apt/lists/*


ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE ${PORT}
WORKDIR /usr/src/band
ADD . .
RUN pip install -U 'git+https://github.com/madiedinro/simple-clickhouse#egg=simplech'
RUN python setup.py develop
RUN pip freeze
