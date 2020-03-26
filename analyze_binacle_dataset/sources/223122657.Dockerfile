FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

# Install alarm-manager and dependencies
COPY alarm-manager.py /opt/ccp/bin/
COPY requirements.txt /tmp/requirements.txt
COPY config-files /etc/alarm-manager/

RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && useradd --user-group alarm-manager \
    && usermod -a -G microservices alarm-manager \
    && chown -R alarm-manager: /etc/alarm-manager \
    && chmod 755 /opt/ccp/bin/alarm-manager.py \
    && rm -f /tmp/requirements.txt

USER alarm-manager
