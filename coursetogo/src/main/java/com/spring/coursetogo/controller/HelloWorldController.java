package com.spring.coursetogo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloWorldController {

    @GetMapping(value = "/test/hello")
    @ResponseBody
    public String helloRuckus(Model model) {
        return "Hello Ruckus";
    }

}
