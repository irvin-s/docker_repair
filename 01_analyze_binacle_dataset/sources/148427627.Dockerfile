FROM plone/plone:4.3.15

LABEL Name="Identidade Digital para o Governo Brasileiro Federal para Plone" \
      maintainer="Carlos Vieira <edu.carlos.vieira@gmail.com>" \
      Version="1.4" \
      Architecture="x86_64" \
      Dockerfile_location="/root/buildinfo"

USER plone
COPY site.cfg /plone/instance/

USER root
COPY Dockerfile /root/buildinfo

# Para Pillow
RUN buildDeps="curl sudo python-setuptools python-dev build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev libjpeg62-turbo-dev libyaml-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo -u plone bin/buildout -c site.cfg -t 300 \
 && SUDO_FORCE_REMOVE=yes apt-get purge -y --auto-remove $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /plone/buildout-cache/downloads/* \
 && apt-get clean \
 && find /plone \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' +

USER plone

