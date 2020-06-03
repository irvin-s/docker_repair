# Version: 0.1
FROM vfarcic/bdd:latest
MAINTAINER Viktor Farcic "viktor@farcic.com"

ENTRYPOINT ["target/universal/stage/bin/tcbdd_runner", "-P", "browser=phantomjs"]
CMD ["--help"]