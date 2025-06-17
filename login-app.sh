#!/bin/bash

cd Stock-advisor-chatgpt

# Clean up everything
rm -rf src
rm -f pom.xml

# Create minimal structure
mkdir -p src/main/java/com/example/stockadvisor/controller
mkdir -p src/main/java/com/example/stockadvisor/model
mkdir -p src/main/java/com/example/stockadvisor/service
mkdir -p src/main/resources/templates
mkdir -p src/main/resources/static/css

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

# Create User model
cat > src/main/java/com/example/stockadvisor/model/User.java << 'EOF'
package com.example.stockadvisor.model;

public class User {
    private String email;
    private String password;
    private String fullName;
    
    public User() {}
    
    public User(String email, String password, String fullName) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
EOF

# Create Stock model
cat > src/main/java/com/example/stockadvisor/model/Stock.java << 'EOF'
package com.example.stockadvisor.model;

public class Stock {
    private String symbol;
    private String name;
    private double price;
    private double change;
    
    public Stock(String symbol, String name, double price, double change) {
        this.symbol = symbol;
        this.name = name;
        this.price = price;
        this.change = change;
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
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public double getChange() {
        return change;
    }
    
    public void setChange(double change) {
        this.change = change;
    }
}
EOF

# Create UserService
cat > src/main/java/com/example/stockadvisor/service/UserService.java << 'EOF'
package com.example.stockadvisor.service;

import com.example.stockadvisor.model.User;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    private Map<String, User> users = new HashMap<>();
    
    public UserService() {
        // Add a demo user
        users.put("demo@example.com", new User("demo@example.com", "password", "Demo User"));
    }
    
    public boolean register(User user) {
        if (users.containsKey(user.getEmail())) {
            return false;
        }
        users.put(user.getEmail(), user);
        return true;
    }
    
    public User login(String email, String password) {
        User user = users.get(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
EOF

# Create StockService
cat > src/main/java/com/example/stockadvisor/service/StockService.java << 'EOF'
package com.example.stockadvisor.service;

import com.example.stockadvisor.model.Stock;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class StockService {
    private Random random = new Random();
    
    public List<Stock> getPopularStocks() {
        List<Stock> stocks = new ArrayList<>();
        stocks.add(new Stock("AAPL", "Apple Inc.", 170.50 + random.nextDouble() * 10, 2.30 + random.nextDouble() * 2));
        stocks.add(new Stock("MSFT", "Microsoft Corp.", 330.20 + random.nextDouble() * 10, 1.50 + random.nextDouble() * 2));
        stocks.add(new Stock("GOOGL", "Alphabet Inc.", 140.80 + random.nextDouble() * 10, -1.20 + random.nextDouble() * 2));
        stocks.add(new Stock("AMZN", "Amazon.com Inc.", 180.30 + random.nextDouble() * 10, 3.40 + random.nextDouble() * 2));
        stocks.add(new Stock("TSLA", "Tesla Inc.", 240.10 + random.nextDouble() * 10, -2.80 + random.nextDouble() * 2));
        return stocks;
    }
}
EOF

# Create AuthController
cat > src/main/java/com/example/stockadvisor/controller/AuthController.java << 'EOF'
package com.example.stockadvisor.controller;

import com.example.stockadvisor.model.User;
import com.example.stockadvisor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/")
    public String home() {
        return "index";
    }
    
    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }
    
    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, 
                        HttpSession session, RedirectAttributes redirectAttributes) {
        User user = userService.login(email, password);
        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/dashboard";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid email or password");
            return "redirect:/login";
        }
    }
    
    @GetMapping("/register")
    public String registerForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }
    
    @PostMapping("/register")
    public String register(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        boolean success = userService.register(user);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "Registration successful. Please login.");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "Email already exists");
            return "redirect:/register";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
EOF

# Create DashboardController
cat > src/main/java/com/example/stockadvisor/controller/DashboardController.java << 'EOF'
package com.example.stockadvisor.controller;

import com.example.stockadvisor.model.User;
import com.example.stockadvisor.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class DashboardController {
    
    @Autowired
    private StockService stockService;
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("user", user);
        model.addAttribute("stocks", stockService.getPopularStocks());
        return "dashboard";
    }
}
EOF

# Create CSS
mkdir -p src/main/resources/static/css
cat > src/main/resources/static/css/style.css << 'EOF'
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f7fa;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.auth-container {
    max-width: 400px;
    margin: 100px auto;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 30px;
}

.home-container {
    text-align: center;
    margin-top: 100px;
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

.navbar-nav {
    display: flex;
    align-items: center;
}

.nav-link {
    color: white;
    text-decoration: none;
    margin-left: 20px;
}

h1, h2, h3 {
    color: #343a40;
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
}

.btn-primary {
    background-color: #4a90e2;
    color: white;
}

.btn-primary:hover {
    background-color: #357ab8;
}

.btn-link {
    background: none;
    color: #4a90e2;
    text-decoration: underline;
    padding: 0;
}

.alert {
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 4px;
}

.alert-danger {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}

.alert-success {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
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
EOF

# Create templates
cat > src/main/resources/templates/index.html << 'EOF'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Stock Advisor</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
</head>
<body>
    <div class="home-container">
        <h1>Welcome to Stock Advisor</h1>
        <p>Your personal assistant for stock market analysis</p>
        <div style="margin-top: 30px;">
            <a href="/login" class="btn btn-primary" style="margin-right: 10px;">Login</a>
            <a href="/register" class="btn btn-primary">Register</a>
        </div>
    </div>
</body>
</html>
EOF

cat > src/main/resources/templates/login.html << 'EOF'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Login - Stock Advisor</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
</head>
<body>
    <div class="auth-container">
        <h2>Login</h2>
        
        <div th:if="${error}" class="alert alert-danger" th:text="${error}"></div>
        <div th:if="${message}" class="alert alert-success" th:text="${message}"></div>
        
        <form action="/login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        
        <div style="margin-top: 20px; text-align: center;">
            <p>Don't have an account? <a href="/register">Register</a></p>
            <p>Demo account: demo@example.com / password</p>
        </div>
    </div>
</body>
</html>
EOF

cat > src/main/resources/templates/register.html << 'EOF'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Register - Stock Advisor</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
</head>
<body>
    <div class="auth-container">
        <h2>Register</h2>
        
        <div th:if="${error}" class="alert alert-danger" th:text="${error}"></div>
        
        <form action="/register" method="post">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>
        
        <div style="margin-top: 20px; text-align: center;">
            <p>Already have an account? <a href="/login">Login</a></p>
        </div>
    </div>
</body>
</html>
EOF

cat > src/main/resources/templates/dashboard.html << 'EOF'
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Dashboard - Stock Advisor</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
</head>
<body>
    <nav class="navbar">
        <a href="/" class="navbar-brand">Stock Advisor</a>
        <div class="navbar-nav">
            <span th:text="${'Welcome, ' + user.fullName}" style="margin-right: 20px;"></span>
            <a href="/logout" class="nav-link">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <h1>Dashboard</h1>
        
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
                            <td th:text="${'$' + #numbers.formatDecimal(stock.price, 1, 2)}">$150.25</td>
                            <td th:class="${stock.change >= 0 ? 'positive' : 'negative'}" 
                                th:text="${(stock.change >= 0 ? '+' : '') + #numbers.formatDecimal(stock.change, 1, 2)}"
                                >+2.30</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
EOF

# Create application.properties
cat > src/main/resources/application.properties << 'EOF'
server.port=8080
spring.thymeleaf.cache=false
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