#!/bin/bash

# Create a new directory for deployment
mkdir -p ~/railway-deploy

# Copy only the project files
cp -r /home/abhishek/Project/Stock-advisor-chatgpt/* ~/railway-deploy/

# Create necessary Railway configuration files
cat > ~/railway-deploy/Procfile << EOF
web: java -jar target/stock-advisor-0.0.1-SNAPSHOT.jar
EOF

cat > ~/railway-deploy/system.properties << EOF
java.runtime.version=11
EOF

# Update application.properties to use environment variables
cat > ~/railway-deploy/src/main/resources/application.properties << EOF
# Server Configuration
server.port=\${PORT:8080}

# Database Configuration
spring.datasource.url=jdbc:h2:mem:stockdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# JPA Configuration
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true

# Thymeleaf Configuration
spring.thymeleaf.cache=false

# API Keys
openai.key=\${OPENAI_KEY:your_openai_api_key}
alpha.key=\${ALPHA_KEY:your_alpha_vantage_api_key}

# Error Handling
server.error.include-message=always
server.error.include-binding-errors=always
server.error.include-stacktrace=never
server.error.include-exception=false
EOF

echo "Project prepared for Railway deployment in ~/railway-deploy"
echo "Next steps:"
echo "1. cd ~/railway-deploy"
echo "2. git init"
echo "3. git add ."
echo "4. git commit -m \"Initial commit\""
echo "5. Create a GitHub repository and push your code"
echo "6. Deploy on Railway using the GitHub repository"