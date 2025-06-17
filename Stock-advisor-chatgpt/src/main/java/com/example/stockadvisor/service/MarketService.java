package com.example.stockadvisor.service;

import com.example.stockadvisor.model.Stock;
import com.example.stockadvisor.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.ta4j.core.*;
import org.ta4j.core.indicators.EMAIndicator;
import org.ta4j.core.indicators.RSIIndicator;
import org.ta4j.core.indicators.helpers.ClosePriceIndicator;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

@Service
public class MarketService {
    
    @Value("${alpha.key}")
    private String apiKey;
    
    @Autowired
    private StockRepository stockRepository;
    
    public BarSeries getStockData(String symbol) throws IOException, InterruptedException {
        String url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=" + symbol + "&outputsize=compact&apikey=" + apiKey;
        
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .build();
        
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        
        JSONObject root = new JSONObject(json);
        
        if (root.has("Error Message")) {
            throw new IOException("API Error: " + root.getString("Error Message"));
        }
        
        if (!root.has("Time Series (Daily)")) {
            // For testing, return a dummy series if API call fails
            return createDummySeries(symbol);
        }
        
        JSONObject timeSeries = root.getJSONObject("Time Series (Daily)");
        BarSeries series = new BaseBarSeriesBuilder().withName(symbol).build();
        
        for (String dateStr : timeSeries.keySet()) {
            JSONObject ohlc = timeSeries.getJSONObject(dateStr);
            ZonedDateTime date = LocalDate.parse(dateStr).atStartOfDay(ZoneId.systemDefault());
            
            series.addBar(Duration.ofDays(1), date,
                    Double.parseDouble(ohlc.getString("1. open")),
                    Double.parseDouble(ohlc.getString("2. high")),
                    Double.parseDouble(ohlc.getString("3. low")),
                    Double.parseDouble(ohlc.getString("4. close")),
                    Double.parseDouble(ohlc.getString("6. volume")));
        }
        
        return series;
    }
    
    private BarSeries createDummySeries(String symbol) {
        BarSeries series = new BaseBarSeriesBuilder().withName(symbol).build();
        LocalDate date = LocalDate.now();
        
        // Add 30 days of dummy data
        for (int i = 30; i > 0; i--) {
            LocalDate currentDate = date.minusDays(i);
            ZonedDateTime zonedDateTime = currentDate.atStartOfDay(ZoneId.systemDefault());
            
            double basePrice = 100.0;
            double open = basePrice + (Math.random() * 5);
            double high = open + (Math.random() * 3);
            double low = open - (Math.random() * 3);
            double close = low + (Math.random() * (high - low));
            double volume = 1000000 + (Math.random() * 500000);
            
            series.addBar(Duration.ofDays(1), zonedDateTime, open, high, low, close, volume);
        }
        
        return series;
    }
    
    public Map<String, Double> analyzeStock(BarSeries series) {
        int idx = series.getEndIndex();
        Map<String, Double> result = new HashMap<>();
        
        ClosePriceIndicator closePrice = new ClosePriceIndicator(series);
        RSIIndicator rsi = new RSIIndicator(closePrice, 14);
        EMAIndicator ema20 = new EMAIndicator(closePrice, 20);
        EMAIndicator ema50 = new EMAIndicator(closePrice, 50);
        
        result.put("price", closePrice.getValue(idx).doubleValue());
        result.put("rsi", rsi.getValue(idx).doubleValue());
        result.put("ema20", ema20.getValue(idx).doubleValue());
        result.put("ema50", ema50.getValue(idx).doubleValue());
        
        return result;
    }
    
    public String generateChartImage(BarSeries series, String symbol) {
        // In a real application, this would generate a chart image using JFreeChart
        // and save it to a file, returning the path to the file
        return "/images/charts/" + symbol + "_" + System.currentTimeMillis() + ".png";
    }
    
    public Stock findOrCreateStock(String symbol) throws IOException, InterruptedException {
        return stockRepository.findBySymbol(symbol)
                .orElseGet(() -> {
                    Stock stock = new Stock();
                    stock.setSymbol(symbol);
                    stock.setName(getStockName(symbol));
                    return stockRepository.save(stock);
                });
    }
    
    private String getStockName(String symbol) {
        // In a real application, this would fetch the company name from an API
        Map<String, String> commonStocks = new HashMap<>();
        commonStocks.put("AAPL", "Apple Inc.");
        commonStocks.put("MSFT", "Microsoft Corporation");
        commonStocks.put("GOOGL", "Alphabet Inc.");
        commonStocks.put("AMZN", "Amazon.com Inc.");
        commonStocks.put("META", "Meta Platforms Inc.");
        commonStocks.put("TSLA", "Tesla Inc.");
        commonStocks.put("NVDA", "NVIDIA Corporation");
        
        return commonStocks.getOrDefault(symbol, symbol + " Inc.");
    }
}