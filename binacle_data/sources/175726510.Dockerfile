# Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may
# not use this file except in compliance with the License. A copy of the
# License is located at
#
#	http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.

FROM gcc:7.3
MAINTAINER Amazon Web Services, Inc.

RUN mkdir /out
VOLUME ['/out']

RUN mkdir -p /usr/src/buildPause/

WORKDIR /usr/src/buildPause

CMD ["make", "all"]
