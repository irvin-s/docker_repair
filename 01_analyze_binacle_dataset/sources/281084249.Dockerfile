# Copyright 2017 Google Inc.
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

# build
FROM golang:1.8
WORKDIR /go/src/
COPY . ./
RUN go get -d -v ./...
RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo ./cmd/gke-serviceaccounts-initializer

# package
FROM alpine:latest
RUN apk --no-cache add ca-certificates && rm -rf /var/cache/apk/* /tmp/*
COPY --from=0 /go/bin/gke-serviceaccounts-initializer /bin/
CMD ["/bin/gke-serviceaccounts-initializer"]
