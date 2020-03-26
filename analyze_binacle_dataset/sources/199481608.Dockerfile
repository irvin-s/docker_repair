FROM mongo:latest

ADD data data

ENTRYPOINT [ \
  "mongorestore", \
  "--drop", \
  "--db", "dev", \
  "--host", "mongo", \
  "data" \
]
