FROM damsl/k3-vanilla:latest
RUN apt-get update && apt-get install -y postgresql postgresql-contrib
