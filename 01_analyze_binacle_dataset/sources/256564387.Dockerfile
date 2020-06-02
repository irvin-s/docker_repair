# LICENSE CDDL 1.0 + GPL 2.0
#
# Adapted from ORACLE DOCKERFILES PROJECT
# --------------------------
# This is the Dockerfile for Oracle WebLogic Server 12.2.1.1 Generic Distro
# 
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# For generic build:
#   fmw_12.2.1.1.0_wls_Disk1_1of1.zip 
#
# Or for developer build:
#   fmw_12.2.1.1.0_wls_quick_Disk1_1of1.zip 
#
# Download from:
# http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-for-dev-1703574.html 
#
# The zip archive used must be available for download at a URL specified in
# FMW_BASEURL.
#
# BUILD ENVIRONMENT VARIABLES
# -----------------------
# The following environment variables are required:
#
# FMW_BASEURL - Base http or https bath from which to download the weblogic
#               zip archive.
#
# FMW_VERSION - Set to the desired version as matching zip archive
#               (ex: 12.2.1.1.0)
#
# FMW_QUICK   - If set then the quick/developer version of weblogic will be
#               used.
# 
#
# IMPORTANT
# ---------
# The resulting image of this Dockerfile contains a WLS Empty Domain.
#
FROM rhel7-java-180-oracle
MAINTAINER Johnathan Kupferer <jkupfere@redhat.com>

# WLS Configuration (editable during build time)
# ------------------------------
ARG ADMIN_PASSWORD

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV FMW_PKG=fmw_${FMW_VERSION}_wls${FMW_QUICK:+_quick}_Disk1_1of1.zip \
    FMW_JAR=fmw_${FMW_VERSION}_wls${FMW_QUICK:+_quick}.jar \
    SCRIPT_FILE=/u01/oracle/createAndStartEmptyDomain.sh \
    ORACLE_HOME=/u01/oracle \
    USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom" \
    DEBUG_FLAG=true \
    PRODUCTION_MODE=dev \
    DOMAIN_NAME="${DOMAIN_NAME:-base_domain}" \
    DOMAIN_HOME=/u01/oracle/user_projects/domains/${DOMAIN_NAME:-base_domain} \
    ADMIN_PORT="${ADMIN_PORT:-8001}" \
    PATH=$PATH:/usr/java/default/bin:/u01/oracle/oracle_common/common/bin:/u01/oracle/wlserver/common/bin

# Copy packages
# -------------
ADD ${FMW_BASEURL}${FMW_PKG} /u01/
COPY install.file oraInst.loc /u01/
COPY container-scripts/createAndStartEmptyDomain.sh container-scripts/create-wls-domain.py /u01/oracle/

# Setup filesystem and oracle user
# Install and configure Oracle JDK
# Adjust file permissions, go to /u01 as user 'oracle' to proceed with WLS installation
# ------------------------------------------------------------
RUN chmod a+xr /u01 && \
    chmod +xr $SCRIPT_FILE && \
    useradd -b /u01 -M -s /bin/bash oracle && \
    chown oracle:oracle -R /u01 && \
    echo oracle:oracle | chpasswd && \
    cd /u01 && $JAVA_HOME/bin/jar xf /u01/$FMW_PKG && cd - && \
    su -c "$JAVA_HOME/bin/java -jar /u01/$FMW_JAR -silent -responseFile /u01/install.file -invPtrLoc /u01/oraInst.loc -jreLoc $JAVA_HOME -ignoreSysPrereqs -force -novalidation ORACLE_HOME=$ORACLE_HOME INSTALL_TYPE=\"WebLogic Server\"" - oracle && \
    rm /u01/$FMW_JAR /u01/$FMW_PKG /u01/oraInst.loc /u01/install.file

WORKDIR ${ORACLE_HOME}

# Define default command to start script. 
CMD ["/u01/oracle/createAndStartEmptyDomain.sh"]
