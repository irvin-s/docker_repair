FROM stackbrew/ubuntu:saucy

# Make sure Ubuntu knows that we're in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

ENV TEAM_CITY_BASE_URL http://download-ln.jetbrains.com/teamcity                 
ENV TEAM_CITY_PACKAGE TeamCity-8.0.5.tar.gz
ENV TEAM_CITY_INSTALL_DIR /usr/local

# Ensure all packages are up to date
RUN apt-get update
RUN apt-get upgrade -y

# Install curl so that we can download TeamCity
RUN apt-get install -y curl

# Download and unpack archive
RUN curl $TEAM_CITY_BASE_URL/$TEAM_CITY_PACKAGE | tar xvz -C $TEAM_CITY_INSTALL_DIR
