FROM microsoft/dotnet:1.1.1-sdk
WORKDIR /integration
COPY . ./
# COPY ../../Output/Artifacts/NuGets/Release ./nugets
# RUN dotnet restore
RUN chmod +x ./docker_init.sh
RUN chmod +x ./multi-wait-for-it.sh
ENV OPERATING_SYSTEM=debian

CMD ["./docker_init.sh"]