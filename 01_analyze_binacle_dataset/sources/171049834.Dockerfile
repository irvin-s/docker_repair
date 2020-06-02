from ubuntu:14.10

RUN apt-get update
RUN apt-get install -y socat

# Listen without forever on $PORT waiting for at least some input before initiating connection. Each time the connection is terminated
# wait for a new one.
CMD socat TCP-LISTEN:$PORT,fork TCP:$TARGET:$PORT
