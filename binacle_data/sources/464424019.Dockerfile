#
# Dockerfile to build Docker API image for DIRBS
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

# Copy wheel, opensource requirements and uwsgi.ini into build
COPY opensource_requirements.txt *.whl docker/prd/api/uwsgi.ini /home/dirbs/

# Install dependencies, wheel
#
# Note that these are run as root, so we need to fix ownership and permissions
# here so that the DIRBS user can run. Also, uwsgitop installs simplejson
# which is incompatible with Flask/Werkzeug, so we need to uninstall that after
# installing uwsgitop
RUN set -x && \
    pip3 install -r /home/dirbs/opensource_requirements.txt && \
    pip3 install /home/dirbs/*.whl && \
    pip3 install uwsgi==2.0.15 && \
    pip3 install uwsgitop==0.10 && \
    pip3 uninstall -y simplejson && \
    chown -R dirbs.dirbs /home/dirbs/dirbs-venv && \
    chmod 755 /home/dirbs/dirbs-venv/bin/uwsgitop

# Copy other files into build
COPY docker/prd/api/entrypoint.sh /entrypoint.sh
COPY etc/ /opt/dirbs/etc

# Install config
RUN set -x && \
    cp /opt/dirbs/etc/config.yml /home/dirbs/.dirbs.yml && \
    chown dirbs.dirbs /home/dirbs/.dirbs.yml

# Make sure permissions are set properly on entrypoint
RUN set -x && chmod a+x /entrypoint.sh

# Expose port 5000 for API server
EXPOSE 5000

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
CMD ["gosu", "dirbs", "uwsgi", "--ini", "/home/dirbs/uwsgi.ini"]
