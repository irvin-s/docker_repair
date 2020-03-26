FROM ubuntu:latest
MAINTAINER Debapriya Das (yodebu@gmail.com)

# Install deps + add Chrome Stable + purge all the things
RUN rm -rf /var/lib/apt/lists/* && apt-get clean
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -yq \
	google-chrome-stable \
	--no-install-recommends \
	g++ build-essential git curl gcc g++ make python python-dev openjdk-8-jdk openjdk-8-jre 

RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install nodejs -yq 
ENV PORTS=0:65535
EXPOSE 4444
RUN curl -sSL https://install.meteor.com | /bin/sh
ENV PATH="$HOME/.meteor:$PATH"
RUN npm install selenium-standalone@latest -g
RUN selenium-standalone install
CMD ['selenium-standalone', 'start', '&']

