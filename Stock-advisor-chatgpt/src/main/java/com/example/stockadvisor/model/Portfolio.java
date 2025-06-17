package com.example.stockadvisor.model;

import javax.persistence.*;

@Entity
@Table(name = "portfolios")
public class Portfolio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "investor_id", nullable = false)
    private User investor;
    
    @ManyToOne
    @JoinColumn(name = "stock_id", nullable = false)
    private Stock stock;
    
    @Column(nullable = false)
    private int quantity;
    
    @Column(nullable = false)
    private double purchasePrice;
    
    public Portfolio() {}
    
    public Portfolio(User investor, Stock stock, int quantity, double purchasePrice) {
        this.investor = investor;
        this.stock = stock;
        this.quantity = quantity;
        this.purchasePrice = purchasePrice;
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public User getInvestor() {
        return investor;
    }
    
    public void setInvestor(User investor) {
        this.investor = investor;
    }
    
    public Stock getStock() {
        return stock;
    }
    
    public void setStock(Stock stock) {
        this.stock = stock;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getPurchasePrice() {
        return purchasePrice;
    }
    
    public void setPurchasePrice(double purchasePrice) {
        this.purchasePrice = purchasePrice;
    }
    
    public double getTotalValue() {
        return quantity * purchasePrice;
    }
}