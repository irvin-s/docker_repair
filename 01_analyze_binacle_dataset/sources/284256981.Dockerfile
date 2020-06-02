# Licensed to Datalayer (https://datalayer.io) under one or more
# contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. Datalayer licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM jupyterhub/jupyterhub:0.9.4

# Install dockerspawner, oauth, postgres.
RUN /opt/conda/bin/conda install -yq psycopg2=2.7 jupyterlab && \
    /opt/conda/bin/conda clean -tipsy && \
    /opt/conda/bin/pip install --no-cache-dir \
        oauthenticator==0.8.* \
        dockerspawner==0.9.*

# Copy TLS certificate and key
# ENV SSL_CERT /srv/jupyterhub/secrets/jupyterhub.crt
# ENV SSL_KEY /srv/jupyterhub/secrets/jupyterhub.key
# COPY ./secrets/*.crt $SSL_CERT
# COPY ./secrets/*.key $SSL_KEY
# RUN chmod 700 /srv/jupyterhub/secrets && \
#    chmod 600 /srv/jupyterhub/secrets/*

RUN useradd datalayer && mkdir /home/datalayer && chown datalayer:datalayer /home/datalayer
RUN echo "datalayer:datalayer" | chpasswd

ADD jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
ADD cull_idle_servers.py /srv/jupyterhub/cull_idle_servers.py
ADD ./userlist /srv/jupyterhub/userlist

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
