FROM python:2.7-slim
LABEL maintainer="ops@opentargets.org"

#need make gcc etc for requirements later
#need git to pip install from git
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl

# install fresh these requirements.
# do this before copying the code to minimize image layer rebuild for dev
COPY ./requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

#put the application in the right place
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN pip install --no-cache-dir -e .

# point to the entrypoint script
ENTRYPOINT [ "scripts/entrypoint.sh" ]
# ENTRYPOINT [ "make" ]