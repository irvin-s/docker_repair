FROM mongo
COPY data-import/ /data-import/
RUN chmod +x /data-import/import.sh
CMD /data-import/import.sh