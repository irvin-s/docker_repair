# Copyright 2019 Google, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

FROM alpine:3.9

RUN apk add build-base python3-dev py3-pip jpeg-dev zlib-dev
ENV LIBRARY_PATH=/lib:/usr/lib

RUN apk add --update python3
RUN pip3 install Flask
RUN pip3 install Pillow
RUN pip3 install Flask gunicorn


# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . .


CMD exec gunicorn --bind :8080 --workers 1 --threads 1 main-pil:app
