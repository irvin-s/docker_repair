FROM mongo
WORKDIR /
COPY users.json assets.json import.sh /
RUN chmod +x /import.sh
CMD /import.sh
