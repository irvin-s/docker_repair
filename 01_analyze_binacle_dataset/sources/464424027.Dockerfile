#
# Dockerfile to build Docker data processing image for DIRBS
#
# SPDX-License-Identifier: BSD-4-Clause-Clear
#
# Copyright (c) 2018-2019 Qualcomm Technologies, Inc.
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted (subject to the
# limitations in the disclaimer below) provided that the following conditions are met:
#
#    - Redistributions of source code must retain the above copyright notice, this list of conditions and the following
#      disclaimer.
#    - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
#      following disclaimer in the documentation and/or other materials provided with the distribution.
#    - All advertising materials mentioning features or use of this software, or any deployment of this software,
#      or documentation accompanying any distribution of this software, must display the trademark/logo as per the
#      details provided here: https://www.qualcomm.com/documents/dirbs-logo-and-brand-guidelines
#    - Neither the name of Qualcomm Technologies, Inc. nor the names of its contributors may be used to endorse or
#      promote products derived from this software without specific prior written permission.
#
#
#
# SPDX-License-Identifier: ZLIB-ACKNOWLEDGEMENT
#
# Copyright (c) 2018-2019 Qualcomm Technologies, Inc.
#
# This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable
# for any damages arising from the use of this software. Permission is granted to anyone to use this software for any
# purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following
# restrictions:
#
#    - The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
#      If you use this software in a product, an acknowledgment is required by displaying the trademark/logo as per the
#      details provided here: https://www.qualcomm.com/documents/dirbs-logo-and-brand-guidelines
#    - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original
#      software.
#    - This notice may not be removed or altered from any source distribution.
#
# NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY THIS LICENSE. THIS SOFTWARE IS PROVIDED BY
# THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

FROM dirbs-base

ENV HLL_VERSION=2.10.2

# Make sure /data directory exists and is owned by correct user
RUN mkdir -p /data && chown -R dirbs.dirbs /data

# Install SSH server, PostgreSQL 10 (needed by unit tests) and mark volume as writeable by DIRBS group
RUN set -x && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get -q update --fix-missing && \
    apt-get -q install -y --no-install-recommends postgresql-10 postgresql-contrib-10 postgresql-server-dev-10 \
                                                  openssh-server wget unzip build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy wheel and opensource requirements into build
COPY opensource_requirements.txt test_requirements.txt *.whl /home/dirbs/

# Install dependencies, wheel
RUN set -x && \
    pip3 install -r /home/dirbs/opensource_requirements.txt && \
    pip3 install -r /home/dirbs/test_requirements.txt && \
    pip3 install /home/dirbs/*.whl && \
    chown -R dirbs.dirbs /home/dirbs/dirbs-venv

# Copy other files into build
COPY etc/ /opt/dirbs/etc
COPY tests/ /home/dirbs/tests

# Install config and change permissions
RUN set -x && \
    cp /opt/dirbs/etc/config.yml /home/dirbs/.dirbs.yml && \
    chown dirbs.dirbs /home/dirbs/.dirbs.yml && \
    chown -R dirbs.dirbs /home/dirbs/tests

# Copy authorized keys
COPY docker/prd/processing/authorized_keys /home/dirbs/.ssh/

# Configure Open SSH
RUN set -x && \
    mkdir -p /var/run/sshd && \
    chmod 700 /var/run/sshd && \
    chown -R dirbs.dirbs /home/dirbs/.ssh && \
    chmod -R 700 /home/dirbs/.ssh && \
    chmod 600 /home/dirbs/.ssh/authorized_keys && \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Install hll
RUN set -x && \
    wget -q -O hll.zip https://github.com/citusdata/postgresql-hll/archive/v$HLL_VERSION.zip && \
    unzip hll.zip && \
    cd postgresql-hll-$HLL_VERSION && \
    make install

# Export port for SSH server
EXPOSE 22

# Mark volumes - want persistent host keys, so make /etc/ssh persistent
VOLUME ["/data", "/etc/ssh"]

# Copy entrypoint
COPY docker/prd/processing/entrypoint.sh /

# Make sure both scripts have permissions set correctly
RUN set -x && chmod a+x /entrypoint.sh

# Jenkins build arg
ARG BUILD_TAG
ENV BUILD_TAG ${BUILD_TAG:-No build tag supplied}
RUN echo $BUILD_TAG > /etc/dirbs_build_tag

# Remove default Ubuntu MOTD content
RUN rm /etc/update-motd.d/*

# Add environment and build info to MOTD
COPY docker/base/dirbs-motd.sh /etc/update-motd.d/00-dirbs-text

# Set entry point
ENTRYPOINT ["/entrypoint.sh"]

# Set command
CMD ["/usr/sbin/sshd", "-D", "-e"]
