FROM ubuntu:17.10
MAINTAINER Stefan Bossbaly <sbossb@gmail.com>

########################################################
# Volumes
########################################################
ENV SRC_DIR /srv/src
ENV CHROMIUM_DIR /srv/chromium
ENV CCACHE_DIR /srv/ccache
ENV TMP_DIR /srv/tmp
ENV KEYS_DIR /srv/keys
ENV LMANIFEST_DIR /srv/local_manifests
ENV LOGS_DIR /srv/logs
ENV ZIP_DIR /srv/zips

# By default we want to use CCACHE, you can disable this
# WARNING: disabling this may slow down a lot your builds!
ENV USE_CCACHE 1

# ccache maximum size. It should be a number followed by an optional suffix: k,
# M, G, T (decimal), Ki, Mi, Gi or Ti (binary). The default suffix is G. Use 0
# for no limit.
ENV CCACHE_SIZE 50G

# Sign the builds with the keys in $KEYS_DIR
ENV SIGN_BUILDS false

# When SIGN_BUILDS = true but no keys have been provided, generate a new set with this subject
ENV KEYS_SUBJECT '/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'

########################################################
# User Id
########################################################
ENV USER "root"
ENV USER_NAME "CopperheadOs Buildbot"
ENV USER_MAIL "copperheados-buildbot@docker.host"

# Apply the MicroG's signature spoofing patch
# Valid values are "no", "yes" (for the original MicroG's patch) and
# "restricted" (to grant the permission only to the system privileged apps).
#
# The original ("yes") patch allows user apps to gain the ability to spoof
# themselves as other apps, which can be a major security threat. Using the
# restricted patch and embedding the apps that requires it as system privileged
# apps is a much secure option. See the README.md ("Custom mode") for an
# example.
ENV SIGNATURE_SPOOFING "no"

# Installs the PICO variant of OpenGAPPS
# Valid values are "no", "yes"
ENV OPEN_GAPPS "no"

########################################################
# Build Variables
########################################################
ENV DEVICE "walleye"
ENV BUILD_TAG "OPM2.171019.029.B1.2018.05.15.17"
ENV BUILD_ID "OPM2.171019.029.B1"
ENV CHROMIUM_RELEASE_NAME "66.0.3359.158"
ENV CHROMIUM_RELEASE_CODE "335915852"
ENV NUM_OF_THREADS 8

########################################################
# Create Volume entry points
########################################################
VOLUME $SRC_DIR
VOLUME $CHROMIUM_DIR
VOLUME $CCACHE_DIR
VOLUME $TMP_DIR
VOLUME $KEYS_DIR
VOLUME $LMANIFEST_DIR
VOLUME $LOGS_DIR
VOLUME $ZIP_DIR

########################################################
# Copy required files
########################################################
COPY src/ /root/

########################################################
# Create missing directories
########################################################
RUN mkdir -p $SRC_DIR
RUN mkdir -p $CHROMIUM_DIR
RUN mkdir -p $CCACHE_DIR
RUN mkdir -p $TMP_DIR
RUN mkdir -p $KEYS_DIR
RUN mkdir -p $LMANIFEST_DIR
RUN mkdir -p $LOGS_DIR
RUN mkdir -p $ZIP_DIR

########################################################
# Install Dependencies
########################################################
RUN apt-get -qq update
RUN apt-get -qqy upgrade
RUN apt-get install -y bc bison build-essential ccache cron curl flex \
      g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \
      lib32readline-dev lib32z1-dev libesd0-dev liblz4-tool libncurses5-dev \
      libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lsof lzop \
      maven openjdk-8-jdk pngcrush procps python rsync schedtool \
      squashfs-tools wget xdelta3 xsltproc yasm zip zlib1g-dev cgpt bsdmainutils lzip

########################################################
# Add PGP Keys
########################################################
RUN gpg --import "/root/gpgkeys/9AB10E784340D13570EF945E83810964E8AD3F819AB10E78.gpg"
RUN gpg --import "/root/gpgkeys/9AF5F22A65EEFE022108E2B708CBFCF7F9E712E59AF5F22A.gpg"
RUN gpg --import "/root/gpgkeys/47A0B99EE6E0512B1829A92528CAFB50B60ABDD447A0B99E.gpg"
RUN gpg --import "/root/gpgkeys/E09EE26BC29C13C520C097E827C85CFCFAD4F2B8E09EE26B.gpg"

########################################################
# Install Google Tools
########################################################
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/sbin

########################################################
# Set the work directory
########################################################
WORKDIR $SRC_DIR

ENTRYPOINT ["/root/docker_entrypoint.sh"]
