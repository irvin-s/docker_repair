FROM oracle/graalvm-ce:1.0.0-rc15 as graalvm
COPY . /home/app/my-api-app
WORKDIR /home/app/my-api-app
RUN native-image --no-server -cp build/libs/my-api-app-*.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/my-api-app .
ENTRYPOINT ["./my-api-app"]
