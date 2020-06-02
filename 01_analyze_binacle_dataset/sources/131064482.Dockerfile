FROM mono:5.10.0.160 as builder
COPY . /tmp/
WORKDIR /tmp
RUN mono .nuget/nuget.exe restore && msbuild EU4.Savegame.sln /p:Configuration=Release

FROM mono:5.10.0.160
COPY --from=builder /tmp/EU4.Stats.Web/server/bin/ /eu4stats/bin
EXPOSE 8888
VOLUME /eu4stats/games
VOLUME /tmp
CMD cd /eu4stats/bin && mono EU4.Stats.Web.exe -d
