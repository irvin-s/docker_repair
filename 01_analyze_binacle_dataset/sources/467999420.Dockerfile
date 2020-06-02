#Copyright (c) 2018,2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
#This code is free software; you can redistribute it and/or modify it
#under the terms of the GNU General Public License version 2 only, as
#published by the Free Software Foundation. Amazon designates this
#particular file as subject to the "Classpath" exception as provided
#by Oracle in the LICENSE file that accompanied this code.
#
#This code is distributed in the hope that it will be useful, but WITHOUT
#ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
#version 2 for more details (a copy is included in the LICENSE file that
#accompanied this code).
#
#You should have received a copy of the GNU General Public License version
#2 along with this work; if not, write to the Free Software Foundation,
#Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#
# This image is used for integration testing toward Corretto
# Debian package.

FROM ubuntu:18.04

# Pre-install OpenJDK8 as default JDK
RUN apt update && apt install -y openjdk-8-jdk-headless

WORKDIR /distributions
COPY *.deb /distributions
COPY run_test.sh .

ENTRYPOINT ["/distributions/run_test.sh"]
