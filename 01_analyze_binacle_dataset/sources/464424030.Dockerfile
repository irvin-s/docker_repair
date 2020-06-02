#
# Dockerfile to build sample Docker operator upload image for DIRBS
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

FROM ubuntu:16.04

# Set environment (set proper unicode locale, hush debconfig, etc.
# Set PATH so that subsequent pip3 commands install into virtualenv.
# activate command does not work within Docker for some reason
ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    PATH=/usr/lib/postgresql/9.6/bin:$PATH \
    GOSU_VERSION=1.10

#
# - Set default shell to bash,
# - Update package lists
# - Install APT depdendencies
#
RUN set -x && \
    unlink /bin/sh; ln -s bash /bin/sh && \
    apt-get -q update --fix-missing && \
    apt-get -q install -y --no-install-recommends locales wget ca-certificates openssh-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
# Set default locale
#
RUN update-locale LC_ALL=C.UTF-8 LANG=C.UTF-8

# Install gosu
RUN set -x && \
    wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

# Add DIRBS user and group
RUN set -x && \
    groupadd -g 9001 dirbs && \
    useradd -m -d /home/dirbs -s /bin/bash -u 9001 -g dirbs dirbs && \
    chmod 700 /home/dirbs

# Copy authorized keys file
COPY docker/prd/processing/authorized_keys /home/dirbs/.ssh/

# Configure Open SSH
RUN set -x && \
    mkdir -p /var/run/sshd && \
    chmod 700 /var/run/sshd && \
    mkdir -p /home/dirbs/.ssh && \
    chown -R dirbs.dirbs /home/dirbs/.ssh && \
    chmod -R 700 /home/dirbs/.ssh && \
    chmod 600 /home/dirbs/.ssh/authorized_keys && \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Copy entrypoint
COPY docker/prd/upload/entrypoint.sh /

# Make sure both scripts have permissions set correctly
RUN set -x && chmod a+x /entrypoint.sh

# Export port for SSH server
EXPOSE 22

# Mark volumes - want persistent host keys, so make /etc/ssh persistent
VOLUME ["/data", "/etc/ssh"]

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set command
CMD ["/usr/sbin/sshd", "-D", "-e"]
