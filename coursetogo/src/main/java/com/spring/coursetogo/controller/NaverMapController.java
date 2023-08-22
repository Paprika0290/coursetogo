package com.spring.coursetogo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NaverMapController {

    @RequestMapping(value = "/courseMake")
    public String naverMap() {

        return "naverMap";
    }

}

