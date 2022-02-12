FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ProgrammingFire.Api/ProgrammingFire.Api.csproj", "ProgrammingFire.Api/"]
RUN dotnet restore "ProgrammingFire.Api/ProgrammingFire.Api.csproj"
COPY . .
WORKDIR "/src/ProgrammingFire.Api"
RUN dotnet build "ProgrammingFire.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ProgrammingFire.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ProgrammingFire.Api.dll"]
