FROM scratch

CMD "no-such-command"

LABEL \
  com.opentable.sous.repo_url=github.com/opentable/homer-says-doh \
  com.opentable.sous.repo_offset= \
  com.opentable.sous.version=0.0.17-notatalluseful \
  com.opentable.sous.revision=91495f1b1630084e301241100ecf2e775f6b672c
