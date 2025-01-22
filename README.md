# Northwind DAB REST API Demo

A modern REST API built with Microsoft Data API Builder (DAB) using the classic Northwind database. This project demonstrates how to create a containerized REST and GraphQL API with automatic Swagger documentation.

## 🚀 Features

- **REST API** endpoints for Northwind database entities
- **GraphQL API** with full query capabilities
- **Swagger/OpenAPI** documentation
- **Docker** containerization
- **SQL Server** database with Northwind sample data
- **Cross-Origin Resource Sharing (CORS)** enabled
- **Anonymous access** for easy testing

## 🛠️ Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [PowerShell](https://github.com/PowerShell/PowerShell)

## 🏃‍♂️ Quick Start

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd dabrestreactdemo
   ```

2. Start the containers:
   ```powershell
   .\start.ps1
   ```

3. Access the APIs:
   - Swagger UI: http://localhost:8080/swagger
   - REST API: http://localhost:8080/api
   - GraphQL Playground: http://localhost:8080/graphql

## 🔌 DAB API Container

The Data API Builder (DAB) container acts as a universal database middleware, automatically generating REST and GraphQL APIs from your database schema. This makes it perfect as a template for any database-driven API project.

### Features
- **Automatic API Generation**: 
  - REST endpoints with CRUD operations
  - GraphQL API with flexible querying
  - Swagger documentation
- **Database Agnostic**: Works with SQL Server, PostgreSQL, MySQL, and more
- **Configuration-Based**: No coding required, just update the config file
- **Flexible Routing**: Customize API endpoints and entity mappings

### Using as a Template
To adapt this for your own database:

1. Keep the DAB container setup:
   ```dockerfile
   # dab/Dockerfile remains unchanged
   FROM mcr.microsoft.com/dotnet/sdk:8.0
   RUN dotnet tool install -g Microsoft.DataApiBuilder
   ```

2. Update database connection in `dab-config.json`:
   ```json
   {
     "data-source": {
       "database-type": "mssql",  // or postgresql, mysql, etc.
       "connection-string": "Server=db;Database=YourDatabase;..."
     }
   }
   ```

3. Define your entities:
   ```json
   {
     "entities": {
       "YourEntity": {
         "source": "DatabaseTable",
         "rest": {
           "path": "/your-endpoint"
         },
         "permissions": [
           {
             "role": "anonymous",
             "actions": ["*"]
           }
         ]
       }
     }
   }
   ```

Benefits:
- Zero-code API development
- Automatic documentation
- Built-in GraphQL support
- Easy configuration
- Production-ready middleware

## 📚 API Endpoints

### REST API

- Categories: `GET /api/categories`
- Products: `GET /api/products`
- Suppliers: `GET /api/suppliers`

All endpoints support standard HTTP methods (GET, POST, PUT, DELETE) for CRUD operations.

### GraphQL

Access the GraphQL playground at `/graphql` to:
- Write and test queries
- Explore the schema
- View documentation

## 🗄️ Database Container

The project uses a Microsoft SQL Server container (`mcr.microsoft.com/mssql/server:2019-latest`) that can be customized for any database:

### Current Setup
- Base Image: SQL Server 2019
- Database: Northwind (sample database)
- Initialization: Automatic via `init.sql` script
- Credentials: Configurable via environment variables

### Customizing the Database
You can easily modify this setup for your own database:

1. Replace the initialization script:
   ```dockerfile
   # db/Dockerfile
   COPY init.sql /docker-entrypoint-initdb.d/
   ```
   - Replace `init.sql` with your own database schema and data

2. Update environment variables in `docker-compose.yml`:
   ```yaml
   environment:
     - ACCEPT_EULA=Y
     - SA_PASSWORD=YourPassword
     - MSSQL_PID=Developer
   ```

3. Modify DAB configuration:
   ```json
   // dab/dab-config.json
   {
     "data-source": {
       "database-type": "mssql",
       "connection-string": "Server=db;Database=YourDatabase;..."
     }
   }
   ```

This containerized approach ensures:
- Consistent database setup across environments
- Easy database version control
- Portable development environment
- Quick setup for new team members

## 🏗️ Project Structure

```
dabrestreactdemo/
├── dab/                    # Data API Builder configuration
│   ├── Dockerfile         # DAB API container setup
│   └── dab-config.json    # DAB configuration
├── db/                    # Database setup
│   ├── Dockerfile        # SQL Server container setup
│   └── init.sql          # Database initialization script
├── docker-compose.yml    # Container orchestration
├── start.ps1            # Startup script
└── README.md           # This file
```

## 🛡️ Security Note

This demo uses anonymous authentication for simplicity. In a production environment, you should:
- Implement proper authentication
- Use HTTPS
- Restrict CORS settings
- Secure database credentials

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is open-source and available under the MIT License.
