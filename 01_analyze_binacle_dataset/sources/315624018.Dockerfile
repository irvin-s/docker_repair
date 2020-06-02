FROM homeassistant/home-assistant

COPY config /config
COPY run_hass.sh /root/run_hass.sh

RUN pip install -U "ibmiotf==0.3.4"

EXPOSE 8123

CMD /root/run_hass.sh
