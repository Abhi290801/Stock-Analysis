package com.example.stockadvisor.service;

import com.example.stockadvisor.model.Portfolio;
import com.example.stockadvisor.model.Stock;
import com.example.stockadvisor.model.User;
import com.example.stockadvisor.repository.PortfolioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class PortfolioService {
    
    @Autowired
    private PortfolioRepository portfolioRepository;
    
    @Autowired
    private MarketService marketService;
    
    public List<Portfolio> getInvestorPortfolio(Long investorId) {
        return portfolioRepository.findByInvestorId(investorId);
    }
    
    public Portfolio addToPortfolio(User investor, String symbol, int quantity, double purchasePrice) throws IOException, InterruptedException {
        Stock stock = marketService.findOrCreateStock(symbol);
        
        Optional<Portfolio> existingPortfolio = portfolioRepository.findByInvestorIdAndStockId(investor.getId(), stock.getId());
        
        if (existingPortfolio.isPresent()) {
            Portfolio portfolio = existingPortfolio.get();
            int newQuantity = portfolio.getQuantity() + quantity;
            double newAvgPrice = ((portfolio.getQuantity() * portfolio.getPurchasePrice()) + (quantity * purchasePrice)) / newQuantity;
            
            portfolio.setQuantity(newQuantity);
            portfolio.setPurchasePrice(newAvgPrice);
            
            return portfolioRepository.save(portfolio);
        } else {
            Portfolio portfolio = new Portfolio(investor, stock, quantity, purchasePrice);
            return portfolioRepository.save(portfolio);
        }
    }
    
    public Portfolio updatePortfolio(Long portfolioId, int quantity) {
        Portfolio portfolio = portfolioRepository.findById(portfolioId).orElseThrow();
        portfolio.setQuantity(quantity);
        return portfolioRepository.save(portfolio);
    }
    
    public void removeFromPortfolio(Long portfolioId) {
        portfolioRepository.deleteById(portfolioId);
    }
}