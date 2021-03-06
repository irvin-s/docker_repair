# Copyright 2017 The Go Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
FROM golang:1.8
LABEL maintainer "golang-dev@googlegroups.com"

# BEGIN deps (run `make update-deps` to update)

# Repo cloud.google.com/go at 76d607c (2017-07-20)
ENV REV=76d607c4e7a2b9df49f1d1a58a3f3d2dd2614704
RUN go get -d cloud.google.com/go/compute/metadata &&\
    (cd /go/src/cloud.google.com/go && (git cat-file -t $REV 2>/dev/null || git fetch -q origin $REV) && git reset --hard $REV)

# Repo github.com/bradfitz/go-smtpd at deb6d62 (2017-04-04)
ENV REV=deb6d623762522f8ad4a55b952001e4215a76cf4
RUN go get -d github.com/bradfitz/go-smtpd/smtpd &&\
    (cd /go/src/github.com/bradfitz/go-smtpd && (git cat-file -t $REV 2>/dev/null || git fetch -q origin $REV) && git reset --hard $REV)

# Repo github.com/jellevandenhooff/dkim at f50fe3d (2015-03-30)
ENV REV=f50fe3d243e1a9c9369eea29813517f3af190518
RUN go get -d github.com/jellevandenhooff/dkim &&\
    (cd /go/src/github.com/jellevandenhooff/dkim && (git cat-file -t $REV 2>/dev/null || git fetch -q origin $REV) && git reset --hard $REV)

# Repo go4.org at 034d17a (2017-05-25)
ENV REV=034d17a462f7b2dcd1a4a73553ec5357ff6e6c6e
RUN go get -d go4.org/types &&\
    (cd /go/src/go4.org && (git cat-file -t $REV 2>/dev/null || git fetch -q origin $REV) && git reset --hard $REV)

# Repo golang.org/x/crypto at 94c6142 (2017-07-20)
ENV REV=94c6142ae57b8dc154f6e1813c921a6c85f505cd
RUN go get -d golang.org/x/crypto/acme `#and 2 other pkgs` &&\
    (cd /go/src/golang.org/x/crypto && (git cat-file -t $REV 2>/dev/null || git fetch -q origin $REV) && git reset --hard $REV)

# Repo golang.org/x/net at ab54850 (2017-07-21)
ENV REV=ab5485076ff3407ad2d02db054635913f017b0ed
RUN go get -d golang.org/x/net/context `#and 2 other pkgs` &&\
    (cd /go/src/golang.org/x/net && (git cat-file -t $REV 2>/dev/null || git fetch -q origin $REV) && git reset --hard $REV)

# Optimization to speed up iterative development, not necessary for correctness:
RUN go install cloud.google.com/go/compute/metadata \
	github.com/bradfitz/go-smtpd/smtpd \
	github.com/jellevandenhooff/dkim \
	go4.org/types \
	golang.org/x/crypto/acme \
	golang.org/x/crypto/acme/autocert \
	golang.org/x/net/context \
	golang.org/x/net/context/ctxhttp
# END deps

COPY . /go/src/golang.org/x/build/

RUN go install -ldflags "-linkmode=external -extldflags '-static -pthread'" golang.org/x/build/cmd/pubsubhelper
