#  
# Copyright 2018 Davi Garcia (davivcgarcia@gmail.com)  
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
#  
# This is the first stage, where we use a builder image to compile the  
# application code. The dependencies are fetched from internet and the binary  
# is guaranteed to be fully static (build hack).  
FROM golang:1.10 AS builder  
WORKDIR /go/src/github.com/davivcgarcia/awx-telegram-bot  
COPY . ./  
RUN go get -d -v  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  
  
# This is the second stage, where we get the smallest image available  
# and inject our static binary from the previous stage. The app is executed  
# as unpriviledged user as the entrypoint.  
FROM alpine:3.7  
RUN apk --no-cache add ca-certificates  
COPY \--from=builder /go/src/github.com/davivcgarcia/awx-telegram-bot/app /  
USER 123456  
CMD ["/app"]  

