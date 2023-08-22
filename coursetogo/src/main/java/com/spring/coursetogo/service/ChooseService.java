//package com.spring.coursetogo.service;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.mongodb.core.MongoTemplate;
//import org.springframework.stereotype.Service;
//
//import com.spring.dto.SearchDataDTO;
//@Service
//public class ChooseService {
//	
//	   private final MongoTemplate mongoTemplate;
//
//	    @Autowired
//	    public SearchService(MongoTemplate mongoTemplate) {
//	        this.mongoTemplate = mongoTemplate;
//	    }
//
//	    public void saveSearchKeyword(int i, String keyword) {
//	        SearchDataDTO searchData = new SearchDataDTO(i, keyword);
//	        mongoTemplate.save(searchData, "searchData");
//	    }
//}
