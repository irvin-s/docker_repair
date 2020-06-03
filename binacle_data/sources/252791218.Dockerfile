# Copyright (c) 2015. Zuercher Hochschule fuer Angewandte Wissenschaften  
# All Rights Reserved.  
#  
# Licensed under the Apache License, Version 2.0 (the "License"); you may  
# not use this file except in compliance with the License. You may obtain  
# a copy of the License at  
#  
# http://www.apache.org/licenses/LICENSE-2.0  
#  
# Unless required by applicable law or agreed to in writing, software  
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT  
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the  
# License for the specific language governing permissions and limitations  
# under the License.  
#  
# Author: Piyush Harsh,  
# URL: piyush-harsh.info  
#  
# Thanks to: https://hub.docker.com/_/python/  
FROM python:2.7  
RUN apt-get update  
RUN apt-get install -y git python-pip python-dev python-flask libffi-dev  
  
WORKDIR /code  
  
RUN git clone https://github.com/icclab/hurtle_cc_sdk.git  
RUN pip install --upgrade requests  
  
WORKDIR /code/hurtle_cc_sdk  
RUN python setup.py install  
  
WORKDIR /code  
RUN git clone -b hadoop_sm https://github.com/Pentadactylus/sm_openstack  
RUN pip install flask  
  
WORKDIR /code/sm_openstack  
RUN python setup.py install  

