FROM gradle:4.5.1-jdk8

CMD ["gradle", "bootRun"]

EXPOSE 8080
