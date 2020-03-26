FROM busybox

CMD exit 1

LABEL \
  com.opentable.sous.repo_url=github.com/user/succeedthenfail \
  com.opentable.sous.repo_offset= \
  com.opentable.sous.version=2.0.0-fail \
  com.opentable.sous.revision=91495f1b1630084e301241100ecf2e775f6b672c
