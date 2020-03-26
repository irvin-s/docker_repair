FROM sameersbn/gitlab:latest

ADD google_oauth_enabler.py /google_oauth_enabler.py
RUN chmod +x /google_oauth_enabler.py && sed 's@#!/bin/bash@#!/bin/bash\n/google_oauth_enabler.py@' -i /app/init
