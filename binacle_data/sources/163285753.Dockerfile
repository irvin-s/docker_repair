FROM coreos/etcd
MAINTAINER bdelacretaz@apache.org
ADD fsroot /
ENTRYPOINT /bin/bash /start.sh
