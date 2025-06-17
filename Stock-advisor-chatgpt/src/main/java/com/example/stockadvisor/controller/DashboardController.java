package com.example.stockadvisor.controller;

import com.example.stockadvisor.model.Portfolio;
import com.example.stockadvisor.model.StockAnalysis;
import com.example.stockadvisor.model.User;
import com.example.stockadvisor.service.AnalysisService;
import com.example.stockadvisor.service.PortfolioService;
import com.example.stockadvisor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class DashboardController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private AnalysisService analysisService;
    
    @Autowired
    private PortfolioService portfolioService;
    
    @GetMapping("/")
    public String home() {
        return "redirect:/dashboard";
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userService.findByEmail(auth.getName()).orElseThrow();
        
        model.addAttribute("user", user);
        
        if ("ANALYST".equals(user.getRole())) {
            List<StockAnalysis> analyses = analysisService.getAnalysesByAnalyst(user.getId());
            List<User> investors = userService.findInvestorsByAnalystId(user.getId());
            
            model.addAttribute("analyses", analyses);
            model.addAttribute("investors", investors);
            return "analyst/dashboard";
        } else {
            List<StockAnalysis> analyses = analysisService.getAnalysesByInvestor(user.getId());
            List<Portfolio> portfolios = portfolioService.getInvestorPortfolio(user.getId());
            List<User> analysts = userService.findAnalystsByInvestorId(user.getId());
            
            model.addAttribute("analyses", analyses);
            model.addAttribute("portfolios", portfolios);
            model.addAttribute("analysts", analysts);
            return "investor/dashboard";
        }
    }
}