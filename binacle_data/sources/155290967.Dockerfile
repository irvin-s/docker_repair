# Copyright 2016 Globo.com. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

FROM alpine:3.2
ADD archive-server /bin/archive-server

EXPOSE 6161 6060
ENTRYPOINT ["/bin/archive-server", "-read-http=0.0.0.0:6060", "-write-http=0.0.0.0:6161" "-mongodb=$MONGODB_PORT_27017_TCP_ADDR:27017"]
