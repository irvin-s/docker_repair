FROM redis:3.0.7-alpine

COPY configs/* /configs/
CMD ["redis-server", "/configs/1gb-ram.conf"]