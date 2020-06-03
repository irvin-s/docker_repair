FROM clojure

COPY ./install_stan.sh /opt/install_stan.sh
WORKDIR /opt

RUN ./install_stan.sh

ENV STAN_HOME /opt/cmdstan
