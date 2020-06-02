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
#
# Base image for hibiki app containing various Python packages, used to
# speed up docker build time of hibiki main app image.
#
# How to build an image:
# $ ./build.sh

FROM python:2.7

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt
