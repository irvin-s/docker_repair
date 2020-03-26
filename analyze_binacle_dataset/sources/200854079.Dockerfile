FROM owasp/zap2docker-stable

# change to root user, which is the owner of the directories we need to write to
USER root

RUN apt-get update && apt-get install -q -y --fix-missing jq
RUN pip install --upgrade pip && pip install --upgrade zapcli
