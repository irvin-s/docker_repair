FROM python:slim

## We need Ansible, otherwise what's the point
RUN pip install ansible

## We set this so that the ADD, ENTRYPOINT and CMD happen here
WORKDIR /playbook

## Add the playbook dir to the container for distribution
ADD playbook/ .

## We set the /playbook dir as a volume to facilite bind mount at run time
VOLUME /playbook

ENTRYPOINT ["ansible-playbook"]

## Override this from the Docker run command
CMD ["-i","hosts","deploy.yml"]
