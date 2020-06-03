from ubuntu:12.10
maintainer Nick Stinemates <nick@docker.com>

add . /ttl

entrypoint ["/ttl/start.sh"]
