FROM {{BASE_IMAGE}}

CMD ["redis-server", "--appendfsync", "no", "--save", "", "--appendonly", "no"]
