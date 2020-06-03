from ubuntu
maintainer Nick Stinemates <nick@docker.com>

add . /plugin
workdir /plugin

entrypoint ["sh", "start.sh"]
