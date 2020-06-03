# Licensed to Datalayer (https://datalayer.io) under one or more
# contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. Datalayer licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM python:3.7.2

RUN mkdir /dla
WORKDIR /dla

COPY index.html index.html

COPY datalayer_library datalayer_library
COPY setup.py setup.py
COPY README.md README.md
RUN python setup.py install

WORKDIR /dla
EXPOSE 9800
CMD ["python", "datalayer_library/main.py"]
