# Copyright 2018 Google Inc
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

FROM golang:1.7.3
ADD . /go/src/prometheus-dummy-exporter
RUN go get github.com/prometheus/client_golang/prometheus
RUN CGO_ENABLED=0 GOOS=linux go install prometheus-dummy-exporter

FROM alpine:latest
COPY --from=0 /go/bin/prometheus-dummy-exporter .
