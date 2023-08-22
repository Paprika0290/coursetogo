package com.spring.coursetogo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.coursetogo.dto.CourseDTO;

import com.spring.coursetogo.dto.PlaceDTO;
import com.spring.coursetogo.mapper.CourseMapper;
import com.spring.coursetogo.mapper.PlaceMapper;

@Service
public class PlaceService {
	
	@Autowired
	PlaceMapper mapper;
	//public boolean insertPlace(PlaceDTO place) throws Exception {
	//	boolean result = false;
	//			
	//			int res = mapper.insertPlace(place);
	//			
	//			if(res != 0) {
	//				result = true;
	//			} else {
	//				throw new Exception("");
	//			}
	//			
	//			return result;
	//	
	//}

	public PlaceDTO getPlaceByPlaceId(int placeId) throws Exception { 
		PlaceDTO placedto = mapper.getPlaceByPlaceId(placeId);
//		System.out.println(placedto);		
						
	//	if(dept == null) {
	//		throw new Exception("");
	//	}
		
		return placedto; 
	}

	
	public List<PlaceDTO> getAllPlaces() {
		return mapper.getAllPlaces();
	}

//	public List<PlaceDTO> searchPlaces(String keyword) {
//		return mapper.searchPlaces(keyword);
//	}


	public List<PlaceDTO> searchPlacesByPlaceName(String placeName) {
		
		return mapper.searchPlacesByPlaceName(placeName);
	}


	public List<PlaceDTO> searchPlaces(String placeName) {
		
		return mapper.searchPlaces(placeName);
	}


//	public List<PlaceDTO> searchPlacesByJoin(int areaId, int categoryId) {
//        return mapper.searchPlacesByJoin(areaId, categoryId);
//    }


	public List<PlaceDTO> searchPlacesByArea(String areaName) {
		
		return mapper.searchPlacesByArea(areaName);
	}


	public List<PlaceDTO> searchPlacesByCategory(String categoryName) {
		
		return mapper.searchPlacesByCategory(categoryName);
	}


	public List<PlaceDTO> searchPlacesByAreaOrCategory(String areaName, String categoryName) {
		Map<String, String> params = new HashMap<>();
		params.put("categoryName", categoryName);
		params.put("areaName", areaName);
		return mapper.searchPlacesByAreaOrCategory(params);
	}


}