FROM pulsesecure/vtm:18.3
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y dnsutils curl iproute2 iptables libxtables11 python python-requests \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY dockerScaler.py runzeus.sh /usr/local/zeus/
# ZEUS_EULA must be set to "accept" otherwise the container will do nothing
ENV ZEUS_EULA=
# ZEUS_LIC can be used to pass a URL from which the container will download a license file
ENV ZEUS_LIC=
# ZEUS_PASS can be used to set a password. By default a password will be generated for you
# ZEUS_PASS=[RANDOM|SIMPLE]: generate a random pass, ZEUS_PASS=STRONG to employ more symbols.
# Or ZEUS_PASS=<your password>
ENV ZEUS_PASS=RANDOM
# ZEUS_DOM can be used to set a domain and ensure the host has a FQDN.
ENV ZEUS_DOM=
# ZEUS_PACKAGES can be used to install additional packages on first run. 
# If you need Java Extensions.... Eg ZEUS_PACKAGES="openjdk-7-jre-headless"
ENV ZEUS_PACKAGES=
# ZEUS_COMMUNITY_EDITION can be used accept the Community Edition license, and avoid being asked on login
ENV ZEUS_COMMUNITY_EDITION=
# ZEUS_CLUSTER_NAME is used to set the DNS name of an existing member of an existing cluster
# we wish to get this new vtm integrated into.
ENV ZEUS_CLUSTER_NAME=
# ZEUS Service Director Registratrions
ENV ZEUS_REGISTER_HOST=
ENV ZEUS_REGISTER_FP=
ENV ZEUS_REGISTER_POLICY=
ENV ZEUS_REGISTER_OWNER=
ENV ZEUS_REGISTER_SECRET=
CMD [ "/usr/local/zeus/runzeus.sh" ]
EXPOSE 9070 9080 9090 9090/udp 80 443
