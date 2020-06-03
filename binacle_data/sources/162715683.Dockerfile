FROM ubuntu:14.04

# Add VOLUMEs to allow backup of logs and a shared gem repository
VOLUME  ["/gems"]

CMD /bin/bash
