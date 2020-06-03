FROM astefanutti/decktape
USER root
RUN apt update -q && \
	apt install -y --no-install-recommends make
USER node
RUN npm install decktape
