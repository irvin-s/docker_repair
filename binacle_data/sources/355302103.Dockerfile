# Copyright 2015 Google Inc. All Rights Reserved.
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
# This is the Dockerfile for building a devappserver base image.
FROM debian
RUN apt-get update
RUN apt-get install -y python curl python-pip
RUN curl https://dl.google.com/dl/cloudsdk/release/install_google_cloud_sdk.bash > install.sh
RUN bash ./install.sh --disable-prompts --install-dir ./sdk
RUN SDK_ROOT=$(echo /sdk/$(ls sdk/)); $(echo $SDK_ROOT/bin/gcloud components update --quiet app app-engine-python app-engine-php app-engine-java)
ADD ./das.sh /
ENTRYPOINT /das.sh
