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

# This is the Dockerfile for building a pinger. The pinger checks if the
# application is listening on port 8080 by connecting to its network stack.
FROM debian
RUN apt-get update && apt-get install -y python
ADD ./pinger.py /
ENTRYPOINT while true; do sleep 1000; done;
