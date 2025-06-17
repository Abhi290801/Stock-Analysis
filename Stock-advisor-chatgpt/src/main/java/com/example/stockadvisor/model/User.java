package com.example.stockadvisor.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    @Column(nullable = false)
    private String password;
    
    @Column(nullable = false)
    private String fullName;
    
    @Column(nullable = false)
    private String role; // "ANALYST" or "INVESTOR"
    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "analyst_investor",
        joinColumns = @JoinColumn(name = "analyst_id"),
        inverseJoinColumns = @JoinColumn(name = "investor_id")
    )
    private Set<User> investors = new HashSet<>();
    
    @ManyToMany(mappedBy = "investors", fetch = FetchType.EAGER)
    private Set<User> analysts = new HashSet<>();
    
    public User() {}
    
    public User(String email, String password, String fullName, String role) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
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
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public Set<User> getInvestors() {
        return investors;
    }
    
    public void setInvestors(Set<User> investors) {
        this.investors = investors;
    }
    
    public Set<User> getAnalysts() {
        return analysts;
    }
    
    public void setAnalysts(Set<User> analysts) {
        this.analysts = analysts;
    }
    
    public void addInvestor(User investor) {
        this.investors.add(investor);
        investor.getAnalysts().add(this);
    }
    
    public void removeInvestor(User investor) {
        this.investors.remove(investor);
        investor.getAnalysts().remove(this);
    }
}