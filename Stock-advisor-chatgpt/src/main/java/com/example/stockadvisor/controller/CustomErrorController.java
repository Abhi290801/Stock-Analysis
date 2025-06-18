package com.example.stockadvisor.controller;

import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.boot.web.error.ErrorAttributeOptions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class CustomErrorController implements ErrorController {

    private final ErrorAttributes errorAttributes;

    public CustomErrorController(ErrorAttributes errorAttributes) {
        this.errorAttributes = errorAttributes;
    }

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        WebRequest webRequest = new ServletWebRequest(request);
        ErrorAttributeOptions options = ErrorAttributeOptions.of(
            ErrorAttributeOptions.Include.MESSAGE,
            ErrorAttributeOptions.Include.BINDING_ERRORS
        );
        
        Map<String, Object> errorInfo = errorAttributes.getErrorAttributes(webRequest, options);
        
        model.addAttribute("timestamp", errorInfo.get("timestamp"));
        model.addAttribute("status", errorInfo.get("status"));
        model.addAttribute("error", errorInfo.get("error"));
        model.addAttribute("message", errorInfo.get("message"));
        model.addAttribute("path", errorInfo.get("path"));
        
        return "error";
    }
}