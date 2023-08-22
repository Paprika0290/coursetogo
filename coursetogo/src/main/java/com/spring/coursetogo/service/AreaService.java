package com.spring.coursetogo.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.coursetogo.mapper.AreaMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AreaService {
	@Autowired
	AreaMapper areaMapper;

	public List<String> getRecommendations(String query) throws Exception {
		
		List<String> result=  new ArrayList<>();
		result = areaMapper.getRecommendations(query);
		if(result!=null) {
			
		}
		else {
			throw new Exception("no data");
		}
		return 	result;
	}
}
