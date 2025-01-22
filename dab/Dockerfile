FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

ENV DEBIAN_FRONTEND=noninteractive

# Install Microsoft.DataApiBuilder
RUN dotnet tool install -g Microsoft.DataApiBuilder

# Add .NET Core tools to PATH
ENV PATH="${PATH}:/root/.dotnet/tools"

WORKDIR /app

# Copy DAB configuration
COPY dab-config.json ./

EXPOSE 8080

ENTRYPOINT ["dab", "start", "--config", "dab-config.json"]
