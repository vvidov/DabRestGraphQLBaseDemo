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
