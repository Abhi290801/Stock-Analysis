#!/bin/bash

cd Stock-advisor-chatgpt

# Remove model classes with JPA dependencies
rm -rf src/main/java/com/example/stockadvisor/model

# Create minimal pom.xml without JPA
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

# Create simple model classes without JPA
mkdir -p src/main/java/com/example/stockadvisor/model

cat > src/main/java/com/example/stockadvisor/model/Stock.java << 'EOF'
package com.example.stockadvisor.model;

public class Stock {
    private Long id;
    private String symbol;
    private String name;
    private double currentPrice;
    private double change;
    private double changePercent;
    
    public Stock() {}
    
    public Stock(String symbol, String name, double currentPrice, double change, double changePercent) {
        this.symbol = symbol;
        this.name = name;
        this.currentPrice = currentPrice;
        this.change = change;
        this.changePercent = changePercent;
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getSymbol() {
        return symbol;
    }
    
    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public double getCurrentPrice() {
        return currentPrice;
    }
    
    public void setCurrentPrice(double currentPrice) {
        this.currentPrice = currentPrice;
    }
    
    public double getChange() {
        return change;
    }
    
    public void setChange(double change) {
        this.change = change;
    }
    
    public double getChangePercent() {
        return changePercent;
    }
    
    public void setChangePercent(double changePercent) {
        this.changePercent = changePercent;
    }
}
EOF

cat > src/main/java/com/example/stockadvisor/model/User.java << 'EOF'
package com.example.stockadvisor.model;

public class User {
    private Long id;
    private String username;
    private String password;
    private String role;
    private String fullName;
    
    public User() {}
    
    public User(String username, String password, String role, String fullName) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.fullName = fullName;
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
EOF

# Create simple controller
mkdir -p src/main/java/com/example/stockadvisor/controller
cat > src/main/java/com/example/stockadvisor/controller/HomeController.java << 'EOF'
package com.example.stockadvisor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.example.stockadvisor.model.Stock;

@Controller
public class HomeController {
    
    private final Random random = new Random();
    
    @GetMapping("/")
    public String home() {
        return "index";
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        List<Stock> stocks = new ArrayList<>();
        stocks.add(new Stock("AAPL", "Apple Inc.", 170.50 + random.nextDouble() * 10, 2.30 + random.nextDouble() * 2, 1.2 + random.nextDouble()));
        stocks.add(new Stock("MSFT", "Microsoft Corp.", 330.20 + random.nextDouble() * 10, 1.50 + random.nextDouble() * 2, 0.8 + random.nextDouble()));
        stocks.add(new Stock("GOOGL", "Alphabet Inc.", 140.80 + random.nextDouble() * 10, -1.20 + random.nextDouble() * 2, -0.5 + random.nextDouble()));
        
        model.addAttribute("stocks", stocks);
        return "dashboard";
    }
}
EOF

# Create application.properties
mkdir -p src/main/resources
cat > src/main/resources/application.properties << 'EOF'
server.port=8080
EOF

# Create main application class
mkdir -p src/main/java/com/example/stockadvisor
cat > src/main/java/com/example/stockadvisor/StockAdvisorApplication.java << 'EOF'
package com.example.stockadvisor;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StockAdvisorApplication {
    public static void main(String[] args) {
        SpringApplication.run(StockAdvisorApplication.class, args);
    }
}
EOF

# Create templates
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
            padding: 0;
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
<html xmlns:th="http://www.thymeleaf.org">
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
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f8f9fa;
        }
        .positive {
            color: #28a745;
        }
        .negative {
            color: #dc3545;
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
            <div class="card-header">Popular Stocks</div>
            <div class="card-body">
                <table>
                    <thead>
                        <tr>
                            <th>Symbol</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Change</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr th:each="stock : ${stocks}">
                            <td th:text="${stock.symbol}">AAPL</td>
                            <td th:text="${stock.name}">Apple Inc.</td>
                            <td th:text="${'$' + #numbers.formatDecimal(stock.currentPrice, 1, 2)}">$150.25</td>
                            <td th:class="${stock.change >= 0 ? 'positive' : 'negative'}" 
                                th:text="${(stock.change >= 0 ? '+' : '') + #numbers.formatDecimal(stock.change, 1, 2) + ' (' + #numbers.formatDecimal(stock.changePercent, 1, 2) + '%)'}"
                                >+2.30 (1.5%)</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
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