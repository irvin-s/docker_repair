FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7

# Note this is based mostly on https://github.com/sclorg/s2i-python-container/blob/master/3.5/Dockerfile.rhel7

EXPOSE 8080

ENV SUMMARY="Jenkins slave with python 3 and nodejs 6" \
    DESCRIPTION="Jenkins pipeline slave with python 3 and nodejs 6 installed"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Jenkins-Pipeline-python-nodejs" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,jenkins-jnlp-python,jenkins-jnlp-nodejs,jenkins-jnlp" \
      release="1"

ENV PYTHON_VERSION=3.5 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PIP_NO_CACHE_DIR=off \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable"

COPY contrib/bin/scl_enable /usr/local/bin/scl_enable

# We need to call 2 (!) yum commands before being able to enable repositories properly
# This is a workaround for https://bugzilla.redhat.com/show_bug.cgi?id=1479388
RUN yum repolist > /dev/null && \
    yum install -y yum-utils && \
    yum-config-manager --disable \* &> /dev/null && \
    yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    INSTALL_PKGS="rh-python35 rh-python35-python-devel rh-python35-python-setuptools rh-python35-python-pip \
	nss_wrapper httpd24 httpd24-httpd-devel httpd24-mod_ssl httpd24-mod_auth_kerb httpd24-mod_ldap httpd24-mod_session \
        atlas-devel gcc-gfortran libffi-devel libtool-ltdl rh-nodejs6 rh-nodejs6-nodejs-nodemon" && \
    ln -s /usr/lib/node_modules/nodemon/bin/nodemon.js /usr/bin/nodemon && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    # Remove redhat-logos (httpd dependency) to keep image size smaller.
    rpm -e --nodeps redhat-logos && \
    yum clean all -y

# In order to drop the root user, we have to make some directories world
# writable as OpenShift default security model is to run the container under
# random UID.
RUN mkdir -p /opt/app-root  && \
    chown -R 1001:0 /opt/app-root && \
    chmod -R og+rwx /opt/app-root 
    
USER 1001
