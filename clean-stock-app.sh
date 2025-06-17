#!/bin/bash

# Remove existing project files
rm -rf Stock-advisor-chatgpt/src
rm -rf Stock-advisor-chatgpt/pom.xml

# Create directory structure
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/controller
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/service
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/model
mkdir -p Stock-advisor-chatgpt/src/main/resources/templates

# Create pom.xml
cat > Stock-advisor-chatgpt/pom.xml << 'EOF'
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
cat > Stock-advisor-chatgpt/src/main/resources/application.properties << 'EOF'
# Server
server.port=8080
EOF

# Create main application class
cat > Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/StockAdvisorApplication.java << 'EOF'
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

# Create StockService
cat > Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/service/StockService.java << 'EOF'
package com.example.stockadvisor.service;

import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class StockService {
    public Map<String, Object> analyzeStock(String symbol) {
        Map<String, Double> indicators = new HashMap<>();
        indicators.put("RSI", 45.67);
        indicators.put("EMA20", 152.34);
        indicators.put("EMA50", 148.92);
        
        String advice = "Based on the technical indicators, " + symbol + " appears to be in a neutral position. " +
                        "The RSI of 45.67 is in the middle range, suggesting neither overbought nor oversold conditions. " +
                        "The EMA20 is above the EMA50, which indicates a potential bullish trend. " +
                        "Recommendation: HOLD - Monitor for clearer signals.";
        
        Map<String, Object> result = new HashMap<>();
        result.put("indicators", indicators);
        result.put("advice", advice);
        
        return result;
    }
}
EOF

# Create StockController
cat > Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/controller/StockController.java << 'EOF'
package com.example.stockadvisor.controller;

import com.example.stockadvisor.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
@RequestMapping("/api/stocks")
public class StockController {
    @Autowired 
    private StockService stockService;

    @GetMapping("/analyze/{symbol}")
    public Map<String, Object> analyze(@PathVariable String symbol) {
        return stockService.analyzeStock(symbol);
    }
}
EOF

# Create PageController
cat > Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/controller/PageController.java << 'EOF'
package com.example.stockadvisor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
    @GetMapping("/")
    public String home() {
        return "redirect:/dashboard";
    }
    
    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }
}
EOF

# Create dashboard.html
cat > Stock-advisor-chatgpt/src/main/resources/templates/dashboard.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Stock Advisor</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { border: 1px solid #ddd; border-radius: 4px; padding: 15px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { padding: 8px; width: 100%; box-sizing: border-box; }
        button { padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
        ul { padding-left: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Stock Advisor Dashboard</h1>
        
        <div class="card">
            <h2>Stock Analysis</h2>
            <form id="stockForm">
                <div class="form-group">
                    <label for="symbol">Stock Symbol:</label>
                    <input type="text" id="symbol" placeholder="e.g. AAPL">
                </div>
                <button type="submit">Analyze</button>
            </form>
        </div>
        
        <div class="card">
            <h2>Results</h2>
            <div id="results">
                <p>Enter a stock symbol to analyze</p>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('stockForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const symbol = document.getElementById('symbol').value;
            if (!symbol) return;
            
            document.getElementById('results').innerHTML = '<p>Loading...</p>';
            
            fetch(`/api/stocks/analyze/${symbol}`)
                .then(response => response.json())
                .then(data => {
                    let html = `<h3>${symbol}</h3>`;
                    html += '<h4>Technical Indicators:</h4>';
                    html += '<ul>';
                    for (const [key, value] of Object.entries(data.indicators)) {
                        html += `<li>${key}: ${value.toFixed(2)}</li>`;
                    }
                    html += '</ul>';
                    html += '<h4>AI Recommendation:</h4>';
                    html += `<p>${data.advice}</p>`;
                    document.getElementById('results').innerHTML = html;
                })
                .catch(error => {
                    document.getElementById('results').innerHTML = 
                        `<p style="color: red;">Error: ${error.message}</p>`;
                });
        });
    </script>
</body>
</html>
EOF

# Download Maven if not present
if [ ! -d "Stock-advisor-chatgpt/maven" ]; then
    echo "Downloading Maven..."
    mkdir -p Stock-advisor-chatgpt/maven
    cd Stock-advisor-chatgpt/maven
    wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
    tar -xzf apache-maven-3.8.8-bin.tar.gz
    cd ../..
fi

# Run the application
cd Stock-advisor-chatgpt
MAVEN_HOME="$(pwd)/maven/apache-maven-3.8.8"
MAVEN_BIN="$MAVEN_HOME/bin/mvn"
chmod +x $MAVEN_BIN

echo "Building and running the application..."
$MAVEN_BIN clean spring-boot:run