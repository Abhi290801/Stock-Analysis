#!/bin/bash

# Define the port we want to use
PORT=23456

# Find and kill any process using our port
echo "Checking if port $PORT is in use..."
PID=$(lsof -t -i:$PORT)
if [ ! -z "$PID" ]; then
    echo "Killing process $PID that is using port $PORT"
    kill -9 $PID
fi

# Kill any lingering Java processes
echo "Killing any lingering Java processes..."
pkill -9 java || echo "No Java processes found"

# Update application.properties with the new port
echo "Updating application.properties with port $PORT..."
cat > Stock-advisor-chatgpt/src/main/resources/application.properties << EOF
# Server Configuration
server.port=$PORT

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
openai.key=your_openai_api_key
alpha.key=your_alpha_vantage_api_key

# File Upload Configuration
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB

# Logging Configuration
logging.level.org.springframework=INFO
logging.level.com.example.stockadvisor=DEBUG
EOF

# Run the application
echo "Running the application on port $PORT..."
cd Stock-advisor-chatgpt

# Download Maven if not present
if [ ! -d "maven" ]; then
    echo "Downloading Maven..."
    mkdir -p maven
    cd maven
    wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
    tar -xzf apache-maven-3.8.8-bin.tar.gz
    cd ..
fi

# Set Maven path
MAVEN_HOME="$(pwd)/maven/apache-maven-3.8.8"
MAVEN_BIN="$MAVEN_HOME/bin/mvn"

# Make Maven executable
chmod +x $MAVEN_BIN

# Clean and run
echo "Building and running the application..."
$MAVEN_BIN clean spring-boot:run