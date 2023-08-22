package com.spring.coursetogo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.coursetogo.dto.PlaceDTO;
import com.spring.coursetogo.service.AreaService;
import com.spring.coursetogo.service.PlaceService;

@Controller
public class SearchController {
    @Autowired
    private PlaceService placeService;
    @Autowired
    private AreaService areaService;
    @GetMapping("/places")
    public ResponseEntity<List<PlaceDTO>> getAllPlaces(){
        List<PlaceDTO> places = placeService.getAllPlaces();
        return new ResponseEntity<>(places, HttpStatus.OK);
    }

    @PostMapping("/search")
    public ResponseEntity<List<PlaceDTO>> searchPlaces(@RequestParam("placeName") String placeName){
        List<PlaceDTO> searchResults = placeService.searchPlaces(placeName);
        return new ResponseEntity<>(searchResults, HttpStatus.OK);
    }
    @ResponseBody
    @GetMapping("/search")
    public List<String> getSearchSuggestions(@RequestParam("query") String query) {
        // 검색어를 기반으로 추천 결과 생성
        List<String> suggestions= new ArrayList<String>();
//    	System.out.println(query);
        try {
            suggestions = areaService.getRecommendations(query);

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return suggestions;
    }





    @GetMapping("/jSearchAC")
    @ResponseBody
    public List<PlaceDTO> searchPlacesByAreaOrCategory(@RequestParam("areaName") String areaName, @RequestParam("categoryName") String categoryName, Model model3) {
//    	System.out.println("jSearchAC");
//
        System.out.println(areaName);
        System.out.println(categoryName);
//
        List<PlaceDTO> searchResults4 = placeService.searchPlacesByAreaOrCategory(areaName, categoryName);


        if (searchResults4.isEmpty()) {
            System.out.println("검색결과 없음.");
        }

        return searchResults4;
    }





}

