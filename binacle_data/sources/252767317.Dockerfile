# Copyright 2015 Metaswitch Networks  
#  
# Licensed under the Apache License, Version 2.0 (the "License");  
# you may not use this file except in compliance with the License.  
# You may obtain a copy of the License at  
#  
# http://www.apache.org/licenses/LICENSE-2.0  
#  
# Unless required by applicable law or agreed to in writing, software  
# distributed under the License is distributed on an "AS IS" BASIS,  
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
# See the License for the specific language governing permissions and  
# limitations under the License.  
FROM debian:wheezy  
  
WORKDIR /main/  
  
# Git is installed to allow pip installation from a github repo and also so  
# that the right branch can be included if uploading coverage.  
RUN apt-get update && \  
apt-get install -qy curl python-dev python-pip git libffi-dev libssl-dev  
  
# Install requirements.  
ADD requirements.txt /main/  
RUN pip install -r requirements.txt  
RUN rm -f requirements.txt  
  
# Add the policy-agent code.  
ADD dist/policy_agent /main/  
  
# Set command to run the policy agent  
CMD ["/main/policy_agent"]

