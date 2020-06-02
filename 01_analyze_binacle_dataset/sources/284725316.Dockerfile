FROM gcr.io/stacksmith-images/minideb:jessie-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=phabricator \
    BITNAMI_IMAGE_VERSION=2016.53-r0 \
    PATH=/opt/bitnami/arcanist/bin:/opt/bitnami/php/bin:/opt/bitnami/mysql/bin:$PATH

# System packages required
RUN install_packages --no-install-recommends libssl1.0.0 libaprutil1 libapr1 libc6 libuuid1 libexpat1 libpcre3 libldap-2.4-2 libsasl2-2 libgnutls-deb0-28 zlib1g libp11-kit0 libtasn1-6 libnettle4 libhogweed2 libgmp10 libffi6 libxslt1.1 libtidy-0.99-0 libreadline6 libncurses5 libtinfo5 libsybdb5 libmcrypt4 libstdc++6 libpng12-0 libjpeg62-turbo libbz2-1.0 libxml2 libcurl3 libfreetype6 libicu52 libgcc1 libgcrypt20 libgssapi-krb5-2 liblzma5 libidn11 librtmp1 libssh2-1 libkrb5-3 libk5crypto3 libcomerr2 libgpg-error0 libkrb5support0 libkeyutils1

# Additional modules required
RUN bitnami-pkg unpack apache-2.4.25-0 --checksum 8b46af7d737772d7d301da8b30a2770b7e549674e33b8a5b07480f53c39f5c3f
RUN bitnami-pkg unpack php-5.6.29-0 --checksum 66b0c4957774cb45bcf4ef2755f434cc2e9aea5dbb3284859d28690bce35b632
RUN bitnami-pkg install libphp-5.6.29-0 --checksum 29fc0f3a08ad7bc23423a1de714c4c598059b3d10e7e33e9f3dff9371e547c33
RUN bitnami-pkg install git-2.10.1-1 --checksum 454e9eb6fb781c8d492f9937439dcdfc1a931959d948d4c70e79716d2ea51a2b
RUN bitnami-pkg install mysql-client-10.1.20-0 --checksum 14d20929072b157b5e819deb440504ad0f33f583493b5adeb283c329ea58d513

# Install phabricator
RUN bitnami-pkg unpack phabricator-2016.53-0 --checksum cefb6796e0e26652bb57d6d3d831a3c130066860a26d66e3cba53750f2b737ce

COPY rootfs /

VOLUME ["/bitnami/phabricator", "/bitnami/apache", "/bitnami/php"]

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["/init.sh"]
