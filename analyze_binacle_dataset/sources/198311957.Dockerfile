# Sourced in part from https://dotnet.microsoft.com/download/linux-package-manager/ubuntu16-04/sdk-current
# We also used some parts of https://github.com/dotnet/dotnet-docker/blob/master/2.2/sdk/stretch/amd64/Dockerfile
RUN apt-get -y update && \
    apt-get install --no-install-recommends -y \
        build-essential \
        ca-certificates \
        libssl-dev \
        apt-transport-https \
        wget && \
        rm -rf /var/lib/apt/lists/*

# MIT license from initial repo
# Copyright (c) 2014 Docker, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Install .NET Core SDK
ENV DOTNET_SDK_VERSION 2.2
ENV UBUNTU_VERSION 16.04

# Downloads latest dpkg for current ubuntu version
RUN wget -q https://packages.microsoft.com/config/ubuntu/$UBUNTU_VERSION/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-$DOTNET_SDK_VERSION && \
    rm -rf /var/lib/apt/lists/* && \
    dotnet help