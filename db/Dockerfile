FROM mcr.microsoft.com/mssql/server:2019-latest

USER root
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites and SQL Server tools
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy initialization script
COPY instnwnd.sql /1.sql

RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'set -e' >> /entrypoint.sh && \
    echo '/opt/mssql/bin/sqlservr & sleep 30' >> /entrypoint.sh && \
    echo '/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "IF DB_ID('\''Northwind'\'') IS NOT NULL DROP DATABASE Northwind"' >> /entrypoint.sh && \
    echo '/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "CREATE DATABASE Northwind"' >> /entrypoint.sh && \
    echo '/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d Northwind -i /1.sql' >> /entrypoint.sh && \
    echo 'tail -f /dev/null' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    chown mssql:root /entrypoint.sh /1.sql

USER mssql
CMD ["/entrypoint.sh"]
