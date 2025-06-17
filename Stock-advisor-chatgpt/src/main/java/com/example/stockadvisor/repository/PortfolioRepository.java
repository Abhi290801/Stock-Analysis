package com.example.stockadvisor.repository;

import com.example.stockadvisor.model.Portfolio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PortfolioRepository extends JpaRepository<Portfolio, Long> {
    List<Portfolio> findByInvestorId(Long investorId);
    
    Optional<Portfolio> findByInvestorIdAndStockId(Long investorId, Long stockId);
}