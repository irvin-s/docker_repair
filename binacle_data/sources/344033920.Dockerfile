FROM tatsushid/tinycore:8.2-x86_64

# Instructions are run with 'tc' user

RUN tce-load -wic gnupg curl bzip2-lib sqlite3 readline \
    && rm -rf /tmp/tce/optional/*

# gpg keys listed at https://github.com/nodejs/node
RUN gpg2 --keyserver pgp.mit.edu \
        --keyserver keyserver.pgp.com \
        --keyserver ha.pool.sks-keyservers.net \
        --recv-keys \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
    6A010C5166006599AA17F08146C2130DFD2497F5 # yarn gpg key

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 8.9.0
ENV YARN_VERSION 1.2.1

RUN tce-load -wic coreutils \
        binutils \
        file \
    && cd /tmp \
    && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v${NODE_VERSION}-linux-x64.tar.gz" \
    && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg2 --verify SHASUMS256.txt.asc \
    && grep " node-v${NODE_VERSION}-linux-x64.tar.gz" SHASUMS256.txt.asc | sha256sum -c - \
    && tar -xzf "node-v${NODE_VERSION}-linux-x64.tar.gz" \
    && rm -f "node-v${NODE_VERSION}-linux-x64.tar.gz" SHASUMS256.txt.asc \
    && cd "/tmp/node-v${NODE_VERSION}-linux-x64" \
    && for F in `find . | xargs file | grep "executable" | grep ELF | grep "not stripped" | cut -f 1 -d :`; do \
            [ -f $F ] && strip --strip-unneeded $F; \
        done \
    && sudo cp -R . /usr/local \
    && cd / \
    && sudo ln -s /lib /lib64 \
    && rm -rf "/tmp/node-v${NODE_VERSION}-linux-x64" \
    && cd /tmp \
    && curl -SLO "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" \
    && curl -SLO "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz.asc" \
    && gpg2 --verify "yarn-v${YARN_VERSION}.tar.gz.asc" \
    && tar -xzf "yarn-v${YARN_VERSION}.tar.gz" \
    && rm -rf "yarn-v${YARN_VERSION}.tar.gz" "yarn-v${YARN_VERSION}.tar.gz.asc" \
    && cd /tmp/yarn-v${YARN_VERSION} \
    && sudo cp -p bin/yarn bin/yarn.js bin/yarnpkg /usr/local/bin/ \
    && sudo cp -p lib/* /usr/local/lib/ \
    && cd / \
    && rm -rf /tmp/yarn-v${YARN_VERSION} \
    && cd /tmp/tce/optional \
    && for PKG in acl.tcz \
                libcap.tcz \
                coreutils.tcz \
                binutils.tcz \
                file.tcz; do \
            echo "Removing $PKG files"; \
            for F in `unsquashfs -l $PKG | grep squashfs-root | sed -e 's/squashfs-root//'`; do \
                [ -f $F -o -L $F ] && sudo rm -f $F; \
            done; \
            INSTALLED=$(echo -n $PKG | sed -e s/.tcz//); \
            sudo rm -f /usr/local/tce.installed/$INSTALLED; \
        done \
    && rm -rf /tmp/tce/optional/*

# Instructions after here are run with 'root' user
USER root

CMD ["node"]
