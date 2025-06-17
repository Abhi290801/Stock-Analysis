package com.example.stockadvisor.service;

import com.example.stockadvisor.model.Stock;
import com.example.stockadvisor.model.StockAnalysis;
import com.example.stockadvisor.model.User;
import com.example.stockadvisor.repository.StockAnalysisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ta4j.core.BarSeries;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public class AnalysisService {
    
    @Autowired
    private MarketService marketService;
    
    @Autowired
    private ChatGPTService chatGPTService;
    
    @Autowired
    private StockAnalysisRepository stockAnalysisRepository;
    
    public StockAnalysis createAnalysis(String symbol, User analyst) throws IOException, InterruptedException {
        Stock stock = marketService.findOrCreateStock(symbol);
        BarSeries series = marketService.getStockData(symbol);
        Map<String, Double> indicators = marketService.analyzeStock(series);
        String chartPath = marketService.generateChartImage(series, symbol);
        String aiRecommendation = chatGPTService.generateStockAdvice(symbol, indicators);
        
        StockAnalysis analysis = new StockAnalysis();
        analysis.setStock(stock);
        analysis.setAnalyst(analyst);
        analysis.setCurrentPrice(indicators.get("price"));
        
        // Determine recommendation based on RSI and EMA
        double rsi = indicators.get("rsi");
        double ema20 = indicators.get("ema20");
        double ema50 = indicators.get("ema50");
        
        if (rsi < 30 && ema20 > ema50) {
            analysis.setRecommendation("BUY");
            analysis.setPortfolioPercentage(15.0);
        } else if (rsi > 70 && ema20 < ema50) {
            analysis.setRecommendation("SELL");
            analysis.setPortfolioPercentage(20.0);
        } else if (ema20 > ema50) {
            analysis.setRecommendation("HOLD/BUY");
            analysis.setPortfolioPercentage(10.0);
        } else {
            analysis.setRecommendation("HOLD/SELL");
            analysis.setPortfolioPercentage(10.0);
        }
        
        analysis.setTechnicalAnalysis("RSI: " + indicators.get("rsi") + 
                                     ", EMA20: " + indicators.get("ema20") + 
                                     ", EMA50: " + indicators.get("ema50"));
        analysis.setAiRecommendation(aiRecommendation);
        analysis.setChartImagePath(chartPath);
        
        return stockAnalysisRepository.save(analysis);
    }
    
    public List<StockAnalysis> getAnalysesByAnalyst(Long analystId) {
        return stockAnalysisRepository.findByAnalystId(analystId);
    }
    
    public List<StockAnalysis> getAnalysesByInvestor(Long investorId) {
        return stockAnalysisRepository.findByInvestorId(investorId);
    }
    
    public List<StockAnalysis> getAnalysesByStockAndInvestor(Long stockId, Long investorId) {
        return stockAnalysisRepository.findByStockIdAndInvestorId(stockId, investorId);
    }
}