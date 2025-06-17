package com.example.stockadvisor.config;

import com.example.stockadvisor.model.Stock;
import com.example.stockadvisor.model.User;
import com.example.stockadvisor.repository.StockRepository;
import com.example.stockadvisor.repository.UserRepository;
import com.example.stockadvisor.service.PortfolioService;
import com.example.stockadvisor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private StockRepository stockRepository;
    
    @Autowired
    private PortfolioService portfolioService;
    
    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // Create sample users
        User analyst = new User("analyst@example.com", "password", "John Analyst", "ANALYST");
        User investor = new User("investor@example.com", "password", "Jane Investor", "INVESTOR");
        
        analyst = userService.registerUser(analyst);
        investor = userService.registerUser(investor);
        
        // Create sample stocks
        Stock apple = new Stock("AAPL", "Apple Inc.", "Technology", "Consumer Electronics");
        Stock microsoft = new Stock("MSFT", "Microsoft Corporation", "Technology", "Software");
        Stock google = new Stock("GOOGL", "Alphabet Inc.", "Technology", "Internet Services");
        Stock amazon = new Stock("AMZN", "Amazon.com Inc.", "Consumer Cyclical", "Internet Retail");
        Stock tesla = new Stock("TSLA", "Tesla Inc.", "Consumer Cyclical", "Auto Manufacturers");
        
        stockRepository.save(apple);
        stockRepository.save(microsoft);
        stockRepository.save(google);
        stockRepository.save(amazon);
        stockRepository.save(tesla);
        
        // Assign investor to analyst
        analyst.addInvestor(investor);
        userRepository.save(analyst);
        
        // Add stocks to investor's portfolio
        portfolioService.addToPortfolio(investor, "AAPL", 10, 150.0);
        portfolioService.addToPortfolio(investor, "MSFT", 5, 300.0);
        portfolioService.addToPortfolio(investor, "GOOGL", 2, 2800.0);
    }
}