#############################################
# Dockerfile for the ACMA API flask server. #
# Based on ubuntu 14.04                     #
#############################################

# acma: finds the telco for a number (and tells you if it is vuln to voicemail attacks)
# Copyright (C) 2014, Cyphar All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software without
#    specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

FROM ubuntu:14.04
MAINTAINER "cyphar <cyphar@cyphar.com>"

# Make sure the repos and packages are up to date
RUN apt-get update
RUN apt-get upgrade -y

# Install python3 and flask.
RUN apt-get install -y python3 python3-flask

# Set up ACMA API server directory.
RUN mkdir -p -- /srv/db /srv/www
WORKDIR /srv/www

# Set up server user.
RUN useradd -U -M -s /bin/nologin -- drone
RUN passwd -d -- drone

# Change ownership.
RUN chown drone:drone -- /srv/www /srv/db
USER drone

# Copy over the ACMA API app source.
COPY . /srv/www

# Generate database
RUN tar xvfz data.tar.gz
RUN python3 conv.py data.csv -d /srv/db/acma.db

# Set up ACMA API and port config.
EXPOSE 5000
ENTRYPOINT ["python3", "api.py", "-H0.0.0.0", "-p5000"]
CMD ["-d/srv/db/acma.db"]
