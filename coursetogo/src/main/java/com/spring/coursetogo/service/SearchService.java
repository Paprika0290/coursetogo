package com.spring.coursetogo.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.coursetogo.dto.ChooseCourseDTO;
import com.spring.coursetogo.dto.ChooseDataDTO;
import com.spring.coursetogo.dto.SearchDataDTO;
import com.spring.coursetogo.mapper.AreaMapper;
import com.spring.coursetogo.mapper.SearchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

@Service
public class SearchService {

    private final MongoTemplate mongoTemplate;

    @Autowired
    public SearchService(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    public void saveSearchKeyword(String i, String keyword) {
    	if(i != null) {   SearchDataDTO searchData = new SearchDataDTO(Integer.parseInt(i), keyword);
        mongoTemplate.save(searchData, "searchData");
    }
    	}

	public void saveChooseOne(int userId, List<String> placeIdList) {
		// TODO Auto-generated method stub
		ChooseDataDTO chooseData = null;
		for(String temp : placeIdList) {
			 chooseData = new ChooseDataDTO(userId, temp);
			  mongoTemplate.save(chooseData, "chooseData");
		}
		if(chooseData != null) {
			
		}
		
	}

	public void saveCourse(int userId, String courseId) {
		// TODO Auto-generated method stub
		ChooseCourseDTO courseData = null;
	
		courseData = new ChooseCourseDTO(userId, courseId);
			  mongoTemplate.save(courseData, "courseData");
	
		if( courseData != null) {
			
		}
	}
}
