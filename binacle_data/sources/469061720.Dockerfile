#This docker builds a container for the Seeestudio Raspberry Pi LoRaWaN gateway
FROM sdthirlwall/raspberry-pi-cross-compiler as builder
RUN apt-get install -y git
RUN git clone https://github.com/Lora-net/packet_forwarder.git
RUN git clone https://github.com/Lora-net/lora_gateway.git
# For RAK833 based modules
RUN sed -i "s|# write output for SX1301 reset|echo \"0\" > /sys/class/gpio/gpio\$IOT_SK_SX1301_RESET_PIN/value; WAIT_GPIO|g" ./lora_gateway/reset_lgw.sh
WORKDIR /build/packet_forwarder
RUN ./compile.sh
WORKDIR /build


FROM arm32v7/debian:stretch-slim as exec
WORKDIR /LoRa
COPY --from=builder /build/packet_forwarder/lora_pkt_fwd/lora_pkt_fwd .
COPY --from=builder /build/packet_forwarder/lora_pkt_fwd/global_conf.json .
COPY --from=builder /build/packet_forwarder/lora_pkt_fwd/global_conf.json global_conf.eu.json
COPY --from=builder /build/lora_gateway/reset_lgw.sh .
COPY local_conf.json .
COPY  global_conf.us.json .
COPY start_pktfwd.sh .
ENTRYPOINT ["./start_pktfwd.sh"]