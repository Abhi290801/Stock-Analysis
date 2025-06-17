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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/investor")
public class InvestorController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private AnalysisService analysisService;
    
    @Autowired
    private PortfolioService portfolioService;
    
    @GetMapping("/portfolio")
    public String portfolio(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User investor = userService.findByEmail(auth.getName()).orElseThrow();
        
        List<Portfolio> portfolios = portfolioService.getInvestorPortfolio(investor.getId());
        model.addAttribute("portfolios", portfolios);
        return "investor/portfolio";
    }
    
    @GetMapping("/portfolio/add")
    public String addPortfolioForm() {
        return "investor/add-portfolio";
    }
    
    @PostMapping("/portfolio/add")
    public String addPortfolio(@RequestParam String symbol, 
                              @RequestParam int quantity, 
                              @RequestParam double purchasePrice,
                              RedirectAttributes redirectAttributes) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User investor = userService.findByEmail(auth.getName()).orElseThrow();
        
        try {
            portfolioService.addToPortfolio(investor, symbol, quantity, purchasePrice);
            redirectAttributes.addFlashAttribute("success", "Stock added to portfolio successfully");
        } catch (IOException | InterruptedException e) {
            redirectAttributes.addFlashAttribute("error", "Error adding stock to portfolio: " + e.getMessage());
        }
        
        return "redirect:/investor/portfolio";
    }
    
    @PostMapping("/portfolio/update")
    public String updatePortfolio(@RequestParam Long portfolioId, 
                                 @RequestParam int quantity,
                                 RedirectAttributes redirectAttributes) {
        portfolioService.updatePortfolio(portfolioId, quantity);
        redirectAttributes.addFlashAttribute("success", "Portfolio updated successfully");
        return "redirect:/investor/portfolio";
    }
    
    @PostMapping("/portfolio/remove")
    public String removePortfolio(@RequestParam Long portfolioId, RedirectAttributes redirectAttributes) {
        portfolioService.removeFromPortfolio(portfolioId);
        redirectAttributes.addFlashAttribute("success", "Stock removed from portfolio successfully");
        return "redirect:/investor/portfolio";
    }
    
    @GetMapping("/analyses")
    public String analyses(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User investor = userService.findByEmail(auth.getName()).orElseThrow();
        
        List<StockAnalysis> analyses = analysisService.getAnalysesByInvestor(investor.getId());
        model.addAttribute("analyses", analyses);
        return "investor/analyses";
    }
    
    @GetMapping("/analysis/{id}")
    public String viewAnalysis(@PathVariable Long id, Model model) {
        // In a real application, you would fetch the analysis by ID
        // For now, we'll just return the analysis view
        return "investor/analysis";
    }
}