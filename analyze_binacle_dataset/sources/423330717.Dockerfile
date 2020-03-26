FROM jcscottiii/base-gdec:latest
MAINTAINER James C. Scott III <jcscott.iii@gmail.com>

# Change to root to install more dependencies
USER root
# Install libs for GUI
RUN apt-get install -y \
    libgtk2.0-0=2.24.23-0ubuntu1.3 \
    libgconf-2-4=3.2.6-0ubuntu2 \
    libasound2=1.0.27.2-3ubuntu7 \
    libxtst6=2:1.2.2-1 \
    libnss3=2:3.19.2.1-0ubuntu0.14.04.1

RUN apt-get clean
