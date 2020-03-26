##FROM cypress/browsers:chrome67
#FROM basaltinc/docker-node-php-base:latest
#
#LABEL "com.github.actions.name"="Knapsack Cypress"
#LABEL "com.github.actions.description"="Custom"
#LABEL "com.github.actions.icon"="mic"
#LABEL "com.github.actions.color"="yellow"
#
#LABEL "repository"="http://github.com/basaltinc/knapsack"
#LABEL "homepage"="http://github.com/basaltinc/knapsack"
#
#ADD entrypoint.sh /entrypoint.sh
##RUN chmod +x /entrypoint.sh
#
#ENTRYPOINT ["/entrypoint.sh"]

FROM debian:9.5-slim

LABEL "com.github.actions.name"="Hello World"
LABEL "com.github.actions.description"="Write arguments to the standard output"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/octocat/hello-world"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Octocat <octocat@github.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
