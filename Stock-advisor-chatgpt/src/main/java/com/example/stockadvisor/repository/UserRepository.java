package com.example.stockadvisor.repository;

import com.example.stockadvisor.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    
    List<User> findByRole(String role);
    
    @Query("SELECT u FROM User u JOIN u.analysts a WHERE a.id = :analystId")
    List<User> findInvestorsByAnalystId(Long analystId);
    
    @Query("SELECT u FROM User u JOIN u.investors i WHERE i.id = :investorId")
    List<User> findAnalystsByInvestorId(Long investorId);
}