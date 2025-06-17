package com.example.stockadvisor.controller;

import com.example.stockadvisor.model.StockAnalysis;
import com.example.stockadvisor.model.User;
import com.example.stockadvisor.service.AnalysisService;
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
@RequestMapping("/analyst")
public class AnalystController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private AnalysisService analysisService;
    
    @GetMapping("/analyze")
    public String analyzeForm(@RequestParam(required = false) String symbol, Model model) {
        if (symbol != null && !symbol.isEmpty()) {
            model.addAttribute("symbol", symbol);
        }
        return "analyst/analyze";
    }
    
    @PostMapping("/analyze")
    public String analyze(@RequestParam String symbol, RedirectAttributes redirectAttributes) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User analyst = userService.findByEmail(auth.getName()).orElseThrow();
        
        try {
            StockAnalysis analysis = analysisService.createAnalysis(symbol, analyst);
            redirectAttributes.addFlashAttribute("success", "Analysis created successfully");
            redirectAttributes.addFlashAttribute("symbol", symbol);
            redirectAttributes.addFlashAttribute("stockName", analysisService.getStockName(symbol));
            return "redirect:/analyst/analysis/" + analysis.getId();
        } catch (IOException | InterruptedException e) {
            redirectAttributes.addFlashAttribute("error", "Error creating analysis: " + e.getMessage());
            return "redirect:/analyst/analyze";
        }
    }
    
    @GetMapping("/analysis/{id}")
    public String viewAnalysis(@PathVariable Long id, Model model, 
                              @ModelAttribute("symbol") String symbol,
                              @ModelAttribute("stockName") String stockName) {
        // If we don't have the symbol from flash attributes, use a default
        if (symbol == null || symbol.isEmpty()) {
            symbol = "AAPL";
            stockName = "Apple Inc.";
        }
        
        model.addAttribute("symbol", symbol);
        model.addAttribute("stockName", stockName);
        return "analyst/analysis";
    }
    
    @GetMapping("/investors")
    public String investors(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User analyst = userService.findByEmail(auth.getName()).orElseThrow();
        
        List<User> investors = userService.findInvestorsByAnalystId(analyst.getId());
        List<User> allInvestors = userService.findAllInvestors();
        
        model.addAttribute("investors", investors);
        model.addAttribute("allInvestors", allInvestors);
        return "analyst/investors";
    }
    
    @PostMapping("/investors/assign")
    public String assignInvestor(@RequestParam Long investorId, RedirectAttributes redirectAttributes) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User analyst = userService.findByEmail(auth.getName()).orElseThrow();
        
        userService.assignInvestorToAnalyst(analyst.getId(), investorId);
        redirectAttributes.addFlashAttribute("success", "Investor assigned successfully");
        return "redirect:/analyst/investors";
    }
    
    @PostMapping("/investors/remove")
    public String removeInvestor(@RequestParam Long investorId, RedirectAttributes redirectAttributes) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User analyst = userService.findByEmail(auth.getName()).orElseThrow();
        
        userService.removeInvestorFromAnalyst(analyst.getId(), investorId);
        redirectAttributes.addFlashAttribute("success", "Investor removed successfully");
        return "redirect:/analyst/investors";
    }
}