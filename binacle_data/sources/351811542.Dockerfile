FROM mongo

COPY data.json /data.json
CMD mongoimport --host mongo --db graphql-example --collection profiles --type json --file /data.json --jsonArray
