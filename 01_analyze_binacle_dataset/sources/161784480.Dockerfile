FROM microsoft/dotnet:2.1-sdk
WORKDIR /app

COPY SolidifyProject.Engine.Configuration/.   ./SolidifyProject.Engine.Configuration/.
COPY SolidifyProject.Engine.Infrastructure/.  ./SolidifyProject.Engine.Infrastructure/.
COPY SolidifyProject.Engine.Services/.        ./SolidifyProject.Engine.Services/.
COPY SolidifyProject.Engine.Utils/.           ./SolidifyProject.Engine.Utils/.

COPY Test/SolidifyProject.Engine.Test.Unit/.          ./Test/SolidifyProject.Engine.Test.Unit/.
COPY Test/SolidifyProject.Engine.Test.Integration/.   ./Test/SolidifyProject.Engine.Test.Integration/.


RUN dotnet build Test/SolidifyProject.Engine.Test.Unit/
RUN dotnet build Test/SolidifyProject.Engine.Test.Integration/

CMD ["dotnet", "test", "--no-restore", "--no-build", "--logger", "trx;LogFileName=test.trx", "--results-directory", "/app/test-results/", "--verbosity:normal", "/app/Test/SolidifyProject.Engine.Test.Unit"]
