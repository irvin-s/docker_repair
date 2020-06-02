FROM jess/stress

RUN apt-get update && apt-get install -y cpulimit
