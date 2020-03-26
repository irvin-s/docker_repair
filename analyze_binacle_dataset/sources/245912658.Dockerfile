FROM BASE_IMAGE
COPY jre /app
CMD ["/app/bin/java", "-m", "http.server"]
