package com.example.stockadvisor.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "stock_analyses")
public class StockAnalysis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "stock_id", nullable = false)
    private Stock stock;
    
    @ManyToOne
    @JoinColumn(name = "analyst_id", nullable = false)
    private User analyst;
    
    @Column(nullable = false)
    private LocalDateTime createdAt;
    
    @Column(nullable = false)
    private double currentPrice;
    
    @Column(nullable = false)
    private String recommendation; // "BUY", "SELL", "HOLD"
    
    @Column(nullable = false)
    private double portfolioPercentage;
    
    @Column(columnDefinition = "TEXT")
    private String technicalAnalysis;
    
    @Column(columnDefinition = "TEXT")
    private String aiRecommendation;
    
    @Column(columnDefinition = "TEXT")
    private String chartImagePath;
    
    public StockAnalysis() {
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Stock getStock() {
        return stock;
    }
    
    public void setStock(Stock stock) {
        this.stock = stock;
    }
    
    public User getAnalyst() {
        return analyst;
    }
    
    public void setAnalyst(User analyst) {
        this.analyst = analyst;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public double getCurrentPrice() {
        return currentPrice;
    }
    
    public void setCurrentPrice(double currentPrice) {
        this.currentPrice = currentPrice;
    }
    
    public String getRecommendation() {
        return recommendation;
    }
    
    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
    }
    
    public double getPortfolioPercentage() {
        return portfolioPercentage;
    }
    
    public void setPortfolioPercentage(double portfolioPercentage) {
        this.portfolioPercentage = portfolioPercentage;
    }
    
    public String getTechnicalAnalysis() {
        return technicalAnalysis;
    }
    
    public void setTechnicalAnalysis(String technicalAnalysis) {
        this.technicalAnalysis = technicalAnalysis;
    }
    
    public String getAiRecommendation() {
        return aiRecommendation;
    }
    
    public void setAiRecommendation(String aiRecommendation) {
        this.aiRecommendation = aiRecommendation;
    }
    
    public String getChartImagePath() {
        return chartImagePath;
    }
    
    public void setChartImagePath(String chartImagePath) {
        this.chartImagePath = chartImagePath;
    }
}