package com.example.stockadvisor.repository;

import com.example.stockadvisor.model.StockAnalysis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StockAnalysisRepository extends JpaRepository<StockAnalysis, Long> {
    List<StockAnalysis> findByStockId(Long stockId);
    
    List<StockAnalysis> findByAnalystId(Long analystId);
    
    @Query("SELECT sa FROM StockAnalysis sa WHERE sa.analyst.id IN " +
           "(SELECT a.id FROM User i JOIN i.analysts a WHERE i.id = :investorId)")
    List<StockAnalysis> findByInvestorId(Long investorId);
    
    @Query("SELECT sa FROM StockAnalysis sa WHERE sa.stock.id = :stockId " +
           "AND sa.analyst.id IN (SELECT a.id FROM User i JOIN i.analysts a WHERE i.id = :investorId)")
    List<StockAnalysis> findByStockIdAndInvestorId(Long stockId, Long investorId);
}