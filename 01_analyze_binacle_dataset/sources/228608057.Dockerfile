FROM dws/mvn-front-end

ENV DISPLAY=:1.0

RUN echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list && \
		apt-get update && \
		apt-get install -y --force-yes xvfb firefox

ENTRYPOINT ["Xvfb", ":1"]