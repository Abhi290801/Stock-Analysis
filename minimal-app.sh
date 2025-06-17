#!/bin/bash

cd Stock-advisor-chatgpt

# Create minimal structure
mkdir -p src/main/java/com/example/stockadvisor/controller
mkdir -p src/main/resources/templates
mkdir -p src/main/resources/static

# Create minimal pom.xml
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

# Create application.properties
cat > src/main/resources/application.properties << 'EOF'
server.port=8080
EOF

# Create main application class
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

# Create controller
cat > src/main/java/com/example/stockadvisor/controller/StockController.java << 'EOF'
package com.example.stockadvisor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller
public class StockController {
    
    private final Random random = new Random();
    
    @GetMapping("/")
    public String home() {
        return "index";
    }
    
    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }
    
    @PostMapping("/analyze")
    public String analyze(@RequestParam String symbol, Model model) {
        model.addAttribute("symbol", symbol);
        model.addAttribute("price", 100 + random.nextDouble() * 900);
        model.addAttribute("change", -5 + random.nextDouble() * 10);
        
        Map<String, Double> indicators = new HashMap<>();
        indicators.put("RSI", 30 + random.nextDouble() * 40);
        indicators.put("EMA20", 100 + random.nextDouble() * 50);
        indicators.put("EMA50", 90 + random.nextDouble() * 60);
        model.addAttribute("indicators", indicators);
        
        return "result";
    }
}
EOF

# Create templates
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
                <form action="/analyze" method="post">
                    <div class="form-group">
                        <label for="symbol">Stock Symbol</label>
                        <input type="text" id="symbol" name="symbol" class="form-control" placeholder="e.g. AAPL" required>
                    </div>
                    <button type="submit" class="btn">Analyze</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
EOF

cat > src/main/resources/templates/result.html << 'EOF'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Stock Analysis Result</title>
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
        .stock-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .stock-symbol {
            font-size: 24px;
            font-weight: bold;
        }
        .stock-price {
            font-size: 20px;
            font-weight: bold;
        }
        .stock-change {
            font-size: 16px;
        }
        .positive {
            color: #28a745;
        }
        .negative {
            color: #dc3545;
        }
        .indicators {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }
        .indicator {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            min-width: 120px;
            text-align: center;
        }
        .indicator-name {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 5px;
        }
        .indicator-value {
            font-size: 20px;
            font-weight: 600;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4a90e2;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="/" class="navbar-brand">Stock Advisor</a>
    </nav>
    
    <div class="container">
        <div class="card">
            <div class="card-header">Analysis Result</div>
            <div class="card-body">
                <div class="stock-header">
                    <div>
                        <div class="stock-symbol" th:text="${symbol}">AAPL</div>
                    </div>
                    <div>
                        <div class="stock-price" th:text="${'$' + #numbers.formatDecimal(price, 1, 2)}">$150.25</div>
                        <div th:class="${change >= 0 ? 'stock-change positive' : 'stock-change negative'}" 
                             th:text="${(change >= 0 ? '+' : '') + #numbers.formatDecimal(change, 1, 2) + '%'}">+1.25%</div>
                    </div>
                </div>
                
                <h3>Technical Indicators</h3>
                <div class="indicators">
                    <div class="indicator" th:each="entry : ${indicators}">
                        <div class="indicator-name" th:text="${entry.key}">RSI</div>
                        <div class="indicator-value" th:text="${#numbers.formatDecimal(entry.value, 1, 2)}">45.67</div>
                    </div>
                </div>
                
                <h3>Recommendation</h3>
                <p th:if="${indicators.RSI < 30}">The stock appears to be <strong>oversold</strong>. Consider buying.</p>
                <p th:if="${indicators.RSI > 70}">The stock appears to be <strong>overbought</strong>. Consider selling.</p>
                <p th:if="${indicators.RSI >= 30 && indicators.RSI <= 70}">The stock is in a <strong>neutral</strong> position. Monitor for clearer signals.</p>
                
                <a href="/dashboard" class="btn">Back to Dashboard</a>
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