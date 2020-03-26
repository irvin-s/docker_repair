# Copyright 2016 Google Inc. All rights reserved.
# Use of this source code is governed by the Apache 2.0
# license that can be found in the LICENSE file.

FROM scratch

ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
