# Copyright 2016 ICFP Programming Contest 2016 Organizers
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# See ../../python-base/Dockerfile for the definition of this image.
FROM icfpc2016/python-base:latest

# httpredir.debian.org is not too smart, select the mirror manually
RUN sed -i 's#httpredir.debian.org/debian#www.ftp.ne.jp/Linux/distributions/Debian/debian#g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y graphviz && apt-get clean

RUN mkdir -p /opt/app
WORKDIR /opt/app

COPY requirements.txt /opt/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /opt/app/

ENV PYTHONPATH=/opt/app
CMD ./run_app.sh
