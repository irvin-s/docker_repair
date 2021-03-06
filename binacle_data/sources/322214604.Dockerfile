# Image name: daq/aardvark
#
# Base image called aardvark because the code is lazy and evaluates alphabetically.
#
#              _.---._    /\\
#           ./'       "--`\//
#         ./              o \
#        /./\  )______   \__ \
#       ./  / /\ \   | \ \  \ \
#          / /  \ \  | |\ \  \7
#           "     "    "  "

# Need to use ubuntu because mininet is very persnickity about versions.
FROM ubuntu:bionic

# Dump all our junks into the root home directory.
WORKDIR /root

COPY bin/retry_cmd bin/

ENV AG="bin/retry_cmd apt-get -qqy --no-install-recommends -o=Dpkg::Use-Pty=0"

RUN $AG update && $AG install net-tools bash iproute2 iputils-ping tcpdump strace vim
