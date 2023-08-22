package com.spring.coursetogo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.coursetogo.dto.CoursePlaceDTO;
import com.spring.coursetogo.mapper.CoursePlaceMapper;

@Service
public class CoursePlaceService {
	
@Autowired
CoursePlaceMapper mapper;
public boolean insertCoursePlace(CoursePlaceDTO CoursePlace) throws Exception {
	boolean result = false;
			
			int res = mapper.insertCoursePlace(CoursePlace);
			
			if(res != 0) {
				result = true;
			} else {
				throw new Exception("");
			}
			
			return result;
	
}

//public PlaceDTO getPlaceByPlaceId(int placeId) throws Exception { 
//	PlaceDTO placedto = mapper.getPlaceByPlaceId(placeId);
//					
//					
////	if(dept == null) {
////		throw new Exception("");
////	}
//	
//	return placedto; 
//}

}