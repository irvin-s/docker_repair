FROM ubuntu:latest
ENV DEBIAN_FRONTEND="noninteractive"

RUN ( . /etc/lsb-release; \
    echo "Updating Base Ubuntu Image"; \
    sed -ie "s'http://archive.ubuntu.com'http://us.archive.ubuntu.com'" /etc/apt/sources.list; \
    apt-get -qq update && apt-get -qq -y --no-install-recommends install apt-utils && apt-get -qq -y dist-upgrade; \
    apt-get -qq -y clean ; \
    )
RUN ( . /etc/lsb-release; \
    echo "Installing prerequisites"; \
    apt-get -qq -y --no-install-recommends install ffmpeg libargtable2-0 jq ssmtp curl ca-certificates tzdata gawk; \
    apt-get -qq -y clean ; \
    )
RUN ( . /etc/lsb-release; \
    echo "deb http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu ${DISTRIB_CODENAME} main" > /etc/apt/sources.list.d/handbrake.list; \
    echo "deb-src http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu ${DISTRIB_CODENAME} main" >> /etc/apt/sources.list.d/handbrake.list; \
    curl -s "http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x8771ADB0816950D8" | apt-key add -; \
    echo "Installing handbrake"; \
    apt-get -qq update && apt-get -qq -y --no-install-recommends --allow-unauthenticated install handbrake-cli; \
    apt-get -qq -y clean ; \
    )

VOLUME /postdata

# Match the COMSKIP_* variables to your plex user
# These tell the container where to found your TV and Movie plex trees.  You need to map them as volumes in your run statement/docker-compose.yml
# QUEUEDIR tells the manager where to find the job queue.  Normally this is mapped via a volume.
# QUEUETIMER tells the manager how long to sleep between each scan of the queue
# QUEUEDAYS tells the manager how long to keep completed queue entries.  
# Note that if errors are detected, the queue is stored in a .save file and never deleted, nor is its workspace tree under the QUEUEDIR
# COMCUT=1 uses the comcut processor; COMCUT=0 uses the comchap processor; COMCUT=-1 disables commercial processing altogether
# REMOVETS=1 tells the processor to remove the .ts source files upon successful transcodes.  
# REMOVETS=0 tells the processor to rename the .ts source files to .ts-sav
# TSCLEAN=1 tells the queue manager to scan the MOVIE and TV libraries for .ts-sav files and remove them once they are older than TSDAYS
# MAILTO - if set to an email address will send alerts to that address when an error occurs in the processing.  This option REQUIRES MAIL* variables to be set
# MAILDOMAIN - sets the domain name for from address rewriting
# MAILHUB - name/ip address of mail relay.  This must be a relay server; does not support auth.
# MAILFROM - sets email address that emails from this process should use
# TRANSCODER - sets the path to the transcoder script you want to use
# SLACK_HOOK - sets SLACK channel webhook for notifications
# COMSKIP_INI - sets the directory where comskip.ini files are found.  Catchall comskip file will be comskip.ini.  Config is filters.cfg 
ENV TZ=America/New_York \
    MANAGER_PORT=8080 \
    COMSKIP_UID=113 \
    COMSKIP_GID=123 \
    COMSKIP_USER=plex \
    COMSKIP_GROUP=plex \
    COMSKIP_INI=/config \
    TVDIR=/media/tv \ 
    MVDIR=/media/movies \
    POSTDATA=/postdata \
    QUEUEDIR=/postdata/queue \
    QUEUETIMER=60 \
    QUEUEDAYS=60 \
    COMCUT=0 \
    REMOVETS=0 \
    TSCLEAN=1 \
    TSDAYS=60 \
    MAILTO="" \
    MAILDOMAIN="" \
    MAILHUB="" \
    MAILFROM="" \
    TRANSCODER="" \
    SLACK_HOOK=""

ENTRYPOINT ["/init"]
CMD []

ARG WRKDIR
ARG SRCDIR

COPY ${WRKDIR} /
COPY ${SRCDIR} /

