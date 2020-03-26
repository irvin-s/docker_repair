FROM gyre007/salt-shaker:onbuild

MAINTAINER WebOps MoJ <webops@digital.justice.gov.uk>

ENTRYPOINT [ "python", "./src/shaker/shaker.py" ]

CMD ["--help"]
