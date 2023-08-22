package com.spring.coursetogo.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.coursetogo.dto.CourseDTO;
import com.spring.coursetogo.mapper.DirectionMapper;
import com.spring.coursetogo.dto.DirectionDTO;
@Service
public class DirectionService {
	@Autowired
	DirectionMapper directionMapper;
	

	public int insertDirections(String responseBody, int courseId, int startnum) {
		// TODO Auto-generated method stub
		 ObjectMapper objectMapper = new ObjectMapper();
		 int directionOrder = startnum;	
		 try {
	            JsonNode rootNode = objectMapper.readTree(responseBody);
	            JsonNode pathNode = rootNode.path("route").path("traoptimal").get(0).path("path");
	            List<DirectionDTO> directionDTOList = new ArrayList<>();
	            
	            if (pathNode.isArray()) {
	                
	                for (JsonNode coordinateNode : pathNode) {
	                    double longitude = coordinateNode.get(0).asDouble();
	                    double latitude = coordinateNode.get(1).asDouble();
	                    DirectionDTO directionDTO = DirectionDTO.builder()
	                            .courseId(courseId)
	                            .directionOrder(directionOrder++)
	                            .latitude(latitude)
	                            .longitude(longitude)
	                            .build();
	                    directionDTOList.add(directionDTO);
	                }
	            }
//	            System.out.println(directionDTOList);
	            directionMapper.insertDirectionList(directionDTOList);
	}
		 catch (IOException e) {
	            e.printStackTrace();
	        }
		 
		 return directionOrder++;
}
	
	  public List<DirectionDTO> getDirectionsByCourseId(int courseId) {
	        return directionMapper.getDirectionsByCourseId(courseId);
	    }
	
}