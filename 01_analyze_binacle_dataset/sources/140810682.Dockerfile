FROM ruby:2.3

# Install Supercronic
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.2/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=cdfde14f50a171cbfc35a3a10429e2ab0709afe0

RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

# Install Node.js (required as execjs runtime)
RUN apt-get update && \
  apt-get install -y --no-install-recommends nodejs && \
  rm -rf /var/lib/apt/lists/*

ADD Gemfile /opt/www.aptible.com/
ADD Gemfile.lock /opt/www.aptible.com/
WORKDIR /opt/www.aptible.com
RUN bundle install

ADD . /opt/www.aptible.com

EXPOSE 4567

CMD ["script/aptible-cmd.sh"]


