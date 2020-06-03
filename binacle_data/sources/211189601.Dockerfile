# syntax=docker/dockerfile:1.0.0-experimental
FROM alpine:3.8

COPY --from=hairyhenderson/gomplate:slim /gomplate /usr/bin/gomplate
COPY encrypted.json /encrypted.json

ENV EJSON_KEY_FILE=/run/secrets/thesecret

# obviously saving the password to disk is stupid. this is just a demo!
RUN --mount=type=secret,id=thesecret \
	gomplate -c config=/encrypted.json \
		-i 'The password is {{ print .config.password "\n" }}' \
		-o out

CMD [ "cat", "out"]
