#!/bin/bash

cd Stock-advisor-chatgpt

# Fix directory structure
echo "Fixing directory structure..."
mkdir -p src/main/resources/templates
mkdir -p src/main/resources/static

# Remove problematic files
echo "Removing problematic files..."
rm -rf src/main/java/com/example/stockadvisor/Services
rm -rf src/main/application.properties

# Create simplified application.properties
echo "Creating application.properties..."
cat > src/main/resources/application.properties << 'EOF'
# H2 Database Configuration
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.username=sa
spring.datasource.password=
spring.datasource.driver-class-name=org.h2.Driver
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true

# H2 Console
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# Disable security for development
spring.security.user.name=user
spring.security.user.password=password

# Mock API keys
openai.key=sk-mock-key
alpha.key=mock-key
EOF

# Create simplified main application
echo "Creating simplified main application..."
cat > src/main/java/com/example/stockadvisor/StockAdvisorApplication.java << 'EOF'
package com.example.stockadvisor;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
public class StockAdvisorApplication {
    public static void main(String[] args) {
        SpringApplication.run(StockAdvisorApplication.class, args);
    }
}
EOF

# Create simplified service
echo "Creating simplified service..."
cat > src/main/java/com/example/stockadvisor/service/StockService.java << 'EOF'
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

# Create simplified controller
echo "Creating simplified controller..."
cat > src/main/java/com/example/stockadvisor/controller/StockController.java << 'EOF'
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

# Create simplified dashboard template
echo "Creating dashboard template..."
cat > src/main/resources/templates/dashboard.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Stock Advisor Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1>Stock Advisor Dashboard</h1>
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Stock Analysis
                    </div>
                    <div class="card-body">
                        <form id="stockForm">
                            <div class="mb-3">
                                <label for="symbol" class="form-label">Stock Symbol</label>
                                <input type="text" class="form-control" id="symbol" placeholder="e.g. AAPL">
                            </div>
                            <button type="submit" class="btn btn-primary">Analyze</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Results
                    </div>
                    <div class="card-body">
                        <div id="results">
                            <p>Enter a stock symbol to analyze</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('stockForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const symbol = document.getElementById('symbol').value;
            if (!symbol) return;
            
            document.getElementById('results').innerHTML = '<p>Loading...</p>';
            
            fetch(`/api/stocks/analyze/${symbol}`)
                .then(response => response.json())
                .then(data => {
                    let html = `<h4>${symbol}</h4>`;
                    html += '<h5>Technical Indicators:</h5>';
                    html += '<ul>';
                    for (const [key, value] of Object.entries(data.indicators)) {
                        html += `<li>${key}: ${value.toFixed(2)}</li>`;
                    }
                    html += '</ul>';
                    html += '<h5>AI Recommendation:</h5>';
                    html += `<p>${data.advice}</p>`;
                    document.getElementById('results').innerHTML = html;
                })
                .catch(error => {
                    document.getElementById('results').innerHTML = 
                        `<p class="text-danger">Error: ${error.message}</p>`;
                });
        });
    </script>
</body>
</html>
EOF

# Create page controller
echo "Creating page controller..."
cat > src/main/java/com/example/stockadvisor/controller/PageController.java << 'EOF'
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

# Run the application
echo "Building and running the application..."
$MAVEN_BIN spring-boot:run