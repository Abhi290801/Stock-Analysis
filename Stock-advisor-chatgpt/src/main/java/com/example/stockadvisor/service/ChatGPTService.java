package com.example.stockadvisor.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ChatGPTService {
    
    @Value("${openai.key}")
    private String apiKey;
    
    public String generateStockAdvice(String symbol, Map<String, Double> indicators) {
        // In a real application, this would call the OpenAI API
        // For now, we'll generate a simple recommendation based on the indicators
        
        double price = indicators.get("price");
        double rsi = indicators.get("rsi");
        double ema20 = indicators.get("ema20");
        double ema50 = indicators.get("ema50");
        
        StringBuilder advice = new StringBuilder();
        advice.append("Analysis for ").append(symbol).append(":\n\n");
        
        // RSI Analysis
        advice.append("RSI Analysis: ");
        if (rsi > 70) {
            advice.append("The RSI value of ").append(String.format("%.2f", rsi))
                  .append(" indicates that the stock is currently overbought. ");
            advice.append("This suggests a potential reversal or correction in the near future.\n\n");
        } else if (rsi < 30) {
            advice.append("The RSI value of ").append(String.format("%.2f", rsi))
                  .append(" indicates that the stock is currently oversold. ");
            advice.append("This suggests a potential buying opportunity if other indicators confirm.\n\n");
        } else {
            advice.append("The RSI value of ").append(String.format("%.2f", rsi))
                  .append(" is in the neutral zone. ");
            advice.append("This suggests neither overbought nor oversold conditions.\n\n");
        }
        
        // Moving Average Analysis
        advice.append("Moving Average Analysis: ");
        if (ema20 > ema50) {
            advice.append("The 20-day EMA (").append(String.format("%.2f", ema20))
                  .append(") is above the 50-day EMA (").append(String.format("%.2f", ema50))
                  .append("), indicating a bullish trend. ");
            advice.append("This suggests upward momentum in the stock price.\n\n");
        } else {
            advice.append("The 20-day EMA (").append(String.format("%.2f", ema20))
                  .append(") is below the 50-day EMA (").append(String.format("%.2f", ema50))
                  .append("), indicating a bearish trend. ");
            advice.append("This suggests downward pressure on the stock price.\n\n");
        }
        
        // Recommendation
        advice.append("Recommendation: ");
        if (rsi < 30 && ema20 > ema50) {
            advice.append("BUY - Consider allocating 15% of your portfolio to this stock. ");
            advice.append("The oversold condition combined with a bullish trend suggests a good entry point.");
        } else if (rsi > 70 && ema20 < ema50) {
            advice.append("SELL - Consider reducing your position by 20%. ");
            advice.append("The overbought condition combined with a bearish trend suggests taking profits.");
        } else if (ema20 > ema50) {
            advice.append("HOLD/BUY - Consider allocating 10% of your portfolio to this stock. ");
            advice.append("The bullish trend suggests potential upside, but monitor for better entry points.");
        } else {
            advice.append("HOLD/SELL - Consider reducing your position by 10% if you already own the stock. ");
            advice.append("The bearish trend suggests caution, but monitor for potential trend reversals.");
        }
        
        return advice.toString();
    }
}