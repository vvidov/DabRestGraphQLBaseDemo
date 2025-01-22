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
COPY instnwnd.sql /docker-entrypoint-initdb.d/1.sql

# Create startup script
COPY <<-"EOF" /docker-entrypoint-initdb.d/init.sh
#!/bin/bash
set -e

# Start SQL Server
/opt/mssql/bin/sqlservr & 

# Wait for SQL Server to be ready
for i in {1..60}; do
    if /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "SELECT 1" -b -y 30 >/dev/null 2>&1; then
        echo "SQL Server is ready"
        break
    fi
    echo "Waiting for SQL Server to start... ($i/60)"
    sleep 1
done

# Drop database if exists and create new one
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "IF DB_ID('Northwind') IS NOT NULL DROP DATABASE Northwind" -b -y 30
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "CREATE DATABASE Northwind" -b -y 30
echo "Created Northwind database"

/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d Northwind -i /docker-entrypoint-initdb.d/1.sql -b -y 30
echo "Initialized Northwind database"

# Keep container running
tail -f /dev/null
EOF

RUN chmod +x /docker-entrypoint-initdb.d/init.sh && \
    chown -R mssql /docker-entrypoint-initdb.d

USER mssql

CMD ["/docker-entrypoint-initdb.d/init.sh"]
