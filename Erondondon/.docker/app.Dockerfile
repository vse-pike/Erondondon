FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /App
COPY . ./

RUN apt-get update  \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs 

WORKDIR /App/wwwroot

RUN npm install

WORKDIR /App

RUN dotnet restore

RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Erondondon.dll"]
