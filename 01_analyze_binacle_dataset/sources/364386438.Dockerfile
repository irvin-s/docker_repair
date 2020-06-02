#!/bin/bash

FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y sudo
RUN rm -rf /lib/modules
RUN apt-get install -y linux-headers-4.4.0-45-generic
RUN ln -s /lib/modules/4.4.0-45-generic /lib/modules/`uname -r`

ADD ./ /ovs_build
