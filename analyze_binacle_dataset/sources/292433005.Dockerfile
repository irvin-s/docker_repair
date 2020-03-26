FROM gcc:7.3 as builder
RUN apt-get update && apt-get install -y libboost-system1.62 libboost-dev
COPY main.cpp server_http.hpp status_code.hpp utility.hpp /app/
RUN cd /app && g++ -Wall -O3 -lpthread -lboost_system -o fn main.cpp

FROM debian:buster-slim
COPY --from=builder /app/fn /bin/fn
RUN apt-get update && apt-get install -y libboost-system1.62.0
CMD ["/bin/fn"]
