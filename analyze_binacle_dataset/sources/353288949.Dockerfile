FROM node:0.12
MAINTAINER Rex Tsai "https://about.me/chihchun"

# Software versions
ENV HUBOT_SLACK_VERSION=3.3.0
ENV HUBOT_VERSION=0.3.1
ENV YO_VERSION=1.4.7
ENV COFFEE_SCRIPT=1.9.3

# Usual update / upgrade
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get install -y redis-server

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install coffee-script, hubot
RUN npm install -g yo@${YO_VERSION} \
        coffee-script@${COFFEE_SCRIPT} \
        generator-hubot@${HUBOT_VERSION}

# Working enviroment
ENV BOTDIR /opt/bot
RUN install -o nobody -d ${BOTDIR}

WORKDIR ${BOTDIR}

# Install Hubot
USER nobody
ENV HOME ${BOTDIR}
RUN yo hubot --name="Hubot" --defaults

# Install slack adapter
RUN npm install hubot-slack@${HUBOT_SLACK_VERSION} --save

# Install moretext
RUN npm install moretext@1.0.0 --save
ADD scripts/moretext.coffee ${BOTDIR}/scripts/moretext.coffee

# Entrypoint
CMD ["/bin/sh", "-c", "cd ${BOTDIR} && bin/hubot --adapter slack"]
