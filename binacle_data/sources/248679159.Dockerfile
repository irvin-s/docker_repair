FROM kibana:4.5

COPY docker-entrypoint.sh /
COPY cert-gen.sh /
RUN /cert-gen.sh localhost logging

EXPOSE 443
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
