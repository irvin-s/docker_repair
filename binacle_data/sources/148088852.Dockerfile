FROM rodolpheche/wiremock:2.22.0

CMD ["java", "-cp", "/var/wiremock/lib/*:/var/wiremock/extensions/*", "com.github.tomakehurst.wiremock.standalone.WireMockServerRunner", "--port", "8082", "--verbose", "--root-dir", "/home/wiremock"]