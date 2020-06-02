FROM mongo:3.6.1-jessie

COPY ./subjects.json /subjects.json
COPY ./import.sh /import.sh

EXPOSE 27017