#!/bin/bash

cd Stock-advisor-chatgpt

# Remove problematic files
rm -rf src/main/java/com/example/stockadvisor/config/SecurityConfig.java
rm -rf src/main/java/com/example/stockadvisor/controller/DashboardController.java

# Create a simple controller without security dependencies
mkdir -p src/main/java/com/example/stockadvisor/controller
cat > src/main/java/com/example/stockadvisor/controller/HomeController.java << 'EOF'
package com.example.stockadvisor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home() {
        return "index";
    }
    
    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }
}
EOF

# Create simple templates
mkdir -p src/main/resources/templates
cat > src/main/resources/templates/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Stock Advisor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            max-width: 500px;
        }
        h1 {
            color: #4a90e2;
        }
        .btn {
            display: inline-block;
            background-color: #4a90e2;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Stock Advisor</h1>
        <p>Welcome to the Stock Advisor application!</p>
        <a href="/dashboard" class="btn">Go to Dashboard</a>
    </div>
</body>
</html>
EOF

cat > src/main/resources/templates/dashboard.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Stock Advisor - Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
        }
        .navbar {
            background-color: #343a40;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .dashboard-header {
            margin-bottom: 30px;
        }
        .dashboard-title {
            font-size: 28px;
            color: #343a40;
        }
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }
        .card-header {
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            font-weight: 600;
            font-size: 18px;
        }
        .card-body {
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            background-color: #4a90e2;
            color: white;
        }
        .btn:hover {
            background-color: #357ab8;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="/" class="navbar-brand">Stock Advisor</a>
    </nav>
    
    <div class="container">
        <div class="dashboard-header">
            <h1 class="dashboard-title">Dashboard</h1>
        </div>
        
        <div class="card">
            <div class="card-header">Stock Analysis</div>
            <div class="card-body">
                <form id="analysisForm">
                    <div class="form-group">
                        <label for="symbol">Stock Symbol</label>
                        <input type="text" id="symbol" class="form-control" placeholder="e.g. AAPL">
                    </div>
                    <button type="submit" class="btn">Analyze</button>
                </form>
                
                <div id="result" style="margin-top: 20px;"></div>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('analysisForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const symbol = document.getElementById('symbol').value.trim().toUpperCase();
            if (symbol) {
                document.getElementById('result').innerHTML = 
                    `<h3>${symbol}</h3>
                     <p>Analysis for ${symbol} would appear here in the full application.</p>
                     <p>This is a simplified version without API calls.</p>`;
            }
        });
    </script>
</body>
</html>
EOF

# Update pom.xml to remove security dependencies
cat > pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.0</version>
        <relativePath/>
    </parent>
    <groupId>com.example</groupId>
    <artifactId>stock-advisor</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>stock-advisor</name>
    <description>Stock Advisor App</description>
    
    <properties>
        <java.version>11</java.version>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>2.7.0</version>
            </plugin>
        </plugins>
    </build>
</project>
EOF

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