# Copyright 2017 Openprovider Authors. All rights reserved.
# Use of this source code is governed by a MIT-style
# license that can be found in the LICENSE file.

FROM scratch

ENV WHOISD_LOCAL_HOST 0.0.0.0
ENV WHOISD_LOCAL_PORT 43
ENV WHOISD_LOG_LEVEL 0

EXPOSE $WHOISD_LOCAL_PORT

COPY examples/elastic/mapping.json /etc/whoisd/conf.d/
COPY bin/linux-amd64/whoisd /

CMD ["/whoisd"]
