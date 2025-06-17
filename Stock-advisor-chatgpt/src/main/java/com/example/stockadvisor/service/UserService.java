package com.example.stockadvisor.service;

import com.example.stockadvisor.model.User;
import com.example.stockadvisor.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public User registerUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }
    
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public List<User> findAllAnalysts() {
        return userRepository.findByRole("ANALYST");
    }
    
    public List<User> findAllInvestors() {
        return userRepository.findByRole("INVESTOR");
    }
    
    public List<User> findInvestorsByAnalystId(Long analystId) {
        return userRepository.findInvestorsByAnalystId(analystId);
    }
    
    public List<User> findAnalystsByInvestorId(Long investorId) {
        return userRepository.findAnalystsByInvestorId(investorId);
    }
    
    public void assignInvestorToAnalyst(Long analystId, Long investorId) {
        User analyst = userRepository.findById(analystId).orElseThrow();
        User investor = userRepository.findById(investorId).orElseThrow();
        
        analyst.addInvestor(investor);
        userRepository.save(analyst);
    }
    
    public void removeInvestorFromAnalyst(Long analystId, Long investorId) {
        User analyst = userRepository.findById(analystId).orElseThrow();
        User investor = userRepository.findById(investorId).orElseThrow();
        
        analyst.removeInvestor(investor);
        userRepository.save(analyst);
    }
}