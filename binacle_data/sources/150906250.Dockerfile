
from   node:6.9



run mkdir /logger
add . /logger

run npm install /logger

expose  5000
expose  5001

cmd ["sh", "-c","node /logger/bin/logster.js server -wuc --addr 0.0.0.0 --redis-addr ${DB_PORT_6379_TCP_ADDR} --redis-port ${DB_PORT_6379_TCP_PORT} --redis-auth ${DB_ENV_REDIS_PASS}"]