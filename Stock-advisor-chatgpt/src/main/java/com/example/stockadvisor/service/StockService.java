package com.example.stockadvisor.service;

import com.example.stockadvisor.model.Stock;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class StockService {
    private final Random random = new Random();
    
    public List<Stock> getPopularStocks() {
        List<Stock> stocks = new ArrayList<>();
        
        stocks.add(new Stock("AAPL", "Apple Inc.", "Technology", "Consumer Electronics"));
        stocks.add(new Stock("MSFT", "Microsoft Corp.", "Technology", "Software"));
        stocks.add(new Stock("GOOGL", "Alphabet Inc.", "Technology", "Internet Services"));
        stocks.add(new Stock("AMZN", "Amazon.com Inc.", "Consumer Cyclical", "Internet Retail"));
        stocks.add(new Stock("TSLA", "Tesla Inc.", "Consumer Cyclical", "Auto Manufacturers"));
        
        return stocks;
    }
}