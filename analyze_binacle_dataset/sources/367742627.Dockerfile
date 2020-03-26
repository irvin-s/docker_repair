FROM ubuntu:16.04

RUN apt -y update && apt -y upgrade
RUN apt -y install python-pip python-dev build-essential
RUN pip install virtualenv

RUN mkdir -p /opt/mattermost-integration-gitlab
COPY . /opt/mattermost-integration-gitlab
WORKDIR /opt/mattermost-integration-gitlab
RUN pip install .


EXPOSE 5000

CMD /opt/mattermost-integration-gitlab/entrypoint.sh
