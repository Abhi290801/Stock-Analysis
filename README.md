# 📈 Stock Advisor with ChatGPT Integration

A sophisticated Spring Boot application that combines advanced technical analysis with ChatGPT's AI capabilities to provide intelligent stock investment recommendations. The platform serves both analysts and investors with real-time market insights and portfolio management tools.

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.0-brightgreen.svg)
![Java](https://img.shields.io/badge/Java-11-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

## 🌟 Key Features

### 📊 Advanced Technical Analysis
- Real-time stock price monitoring and analysis
- Interactive candlestick charts with multiple timeframes
- Technical indicators (RSI, EMA, MACD, Stochastic)
- Volume analysis and trend identification
- Price prediction models

### 🤖 AI-Powered Recommendations
- ChatGPT integration for natural language analysis
- Sentiment analysis of market trends
- Personalized investment recommendations
- Risk assessment and portfolio allocation advice

### 👥 User Roles & Features
- **Analysts:**
  - Create and publish stock analyses
  - Monitor multiple stocks simultaneously
  - Generate detailed technical reports
  - Manage investor relationships

- **Investors:**
  - View personalized stock recommendations
  - Track portfolio performance
  - Access historical analyses
  - Set up price alerts and notifications

### 📱 Interactive Dashboard
- Real-time market overview
- Portfolio performance tracking
- Advanced charting capabilities
- Search history and favorites
- Risk assessment visualization

## 🛠️ Technical Stack

- **Backend:**
  - Spring Boot 2.7.0
  - Spring Security
  - Spring Data JPA
  - H2/PostgreSQL Database

- **Frontend:**
  - Thymeleaf
  - Chart.js & ApexCharts
  - Modern responsive design
  - Interactive data visualization

- **APIs & Libraries:**
  - OpenAI GPT API
  - Alpha Vantage API
  - TA4J (Technical Analysis)
  - JFreeChart

## 📋 Requirements

- Java 11 or higher
- Maven 3.6+
- OpenAI API key
- Alpha Vantage API key
- Modern web browser

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Abhi290801/Stock-Analysis.git
   cd stock-advisor-chatgpt
   ```

2. **Configure application properties:**
   Create `src/main/resources/application.properties`:
   ```properties
   server.port=8080
   spring.datasource.url=jdbc:h2:mem:stockdb
   spring.datasource.username=sa
   spring.datasource.password=
   openai.key=your_openai_api_key
   alpha.key=your_alpha_vantage_api_key
   ```

3. **Run the application:**
   ```bash
   ./run-stock-advisor.sh
   ```

4. **Access the application:**
   - URL: http://localhost:8080
   - Default credentials:
     - Analyst: analyst@example.com / password
     - Investor: investor@example.com / password

## 📊 Features Showcase

### Technical Analysis Dashboard
- Real-time price charts
- Multiple chart types:
  - Candlestick patterns
  - Line charts
  - Volume analysis
  - Technical indicators

### Portfolio Management
- Holdings overview
- Performance tracking
- Risk assessment
- Allocation recommendations

### AI Analysis Features
- Market sentiment analysis
- Trend predictions
- Risk evaluation
- Portfolio optimization

## 🏗️ Project Structure

```
src/main/java/com/example/stockadvisor/
├── config/          # Configuration classes
├── controller/      # Web controllers
├── model/          # Entity classes
├── repository/     # Data access layer
├── service/        # Business logic
└── util/           # Utility classes

src/main/resources/
├── static/         # Static resources
├── templates/      # Thymeleaf templates
└── application.properties
```

## 🔒 Security Features

- Spring Security integration
- Role-based access control
- Secure password handling
- Session management
- CSRF protection

## 📈 Charts and Visualizations

- Interactive stock charts
- Technical indicator overlays
- Volume analysis
- Price prediction visualization
- Risk assessment meters
- Portfolio allocation charts

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Spring Boot team
- OpenAI team
- Alpha Vantage API
- Chart.js and ApexCharts communities
- All contributors and users

---
Made with ❤️ by [Abhishek Raj Kashyap]
