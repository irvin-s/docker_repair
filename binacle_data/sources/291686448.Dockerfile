###
### DO NOT MODIFY THIS FILE.  THIS FILE HAS BEEN AUTOGENERATED
###

FROM redis:5.0-rc6-alpine

CMD ["redis-server", "--appendfsync", "no", "--save", "", "--appendonly", "no"]
