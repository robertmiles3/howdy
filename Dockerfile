FROM microsoft/dotnet:2.1.403-sdk-alpine AS builder
WORKDIR /app

# Copy csproj and restore as distinct layers
# (so that this layer caches unless one of these files changes)
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./ ./
# Using ARG forces everything below to run afresh without cached layers
ARG APP_VERSION=0.0.0.0
RUN sed -i "s/<Version>.*<\/Version>/<Version>$APP_VERSION<\/Version>/" howdy.csproj
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1.5-aspnetcore-runtime-alpine
WORKDIR /app
COPY --from=builder /app/out .
ENV TZ=America/New_York
ENTRYPOINT ["dotnet", "howdy.dll"]
