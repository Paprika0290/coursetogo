package com.spring.coursetogo.service;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.coursetogo.dto.CourseDTO;
import com.spring.coursetogo.dto.CourseInformDTO;
import com.spring.coursetogo.dto.PageRequestDTO;
import com.spring.coursetogo.dto.SearchKeyword;
import com.spring.coursetogo.mapper.CourseMapper;
import com.spring.coursetogo.mapper.RestaurantMapper;

import lombok.RequiredArgsConstructor;

@Service
public class CourseService {
	@Autowired
	CourseMapper courseMapper;
	


	public int insertCourse(CourseDTO course) throws Exception {
		int courseId = -1;
				
		 courseMapper.insertCourse(course);
		 courseId = course.getCourseId();	
//		 System.out.println();
			if(courseId == -1) {
				throw new Exception("no sequence");
			} else {
			
			}
				
			return courseId;
		
	}
	public List<CourseInformDTO>  getAllCourses() throws Exception {
	
		List<CourseInformDTO> res=new ArrayList<>();
				 res= courseMapper.getAllCourses();
//				System.out.println(res);
				if(!res.isEmpty()) {
					
				} else {
					throw new Exception("no data");
				}
				
				return res;
		
	}
	public CourseInformDTO  getCourseInformByCourseId(int courseId) throws Exception {
		
		CourseInformDTO res=null;
				 res= courseMapper.getCourseInformByCourseId(courseId);
//				System.out.println(res);
				if(res!=null) {
					
				} else {
					throw new Exception("no data");
				}
				
				return res;
		
	}
	public List<CourseInformDTO>  getCourseInformByUserId(int userId) throws Exception {
		
		List<CourseInformDTO> res=null;
				 res= courseMapper.getCourseInformByUserId(userId);
//				System.out.println(res);
				if(res!=null) {
					
				} else {
					throw new Exception("no data");
				}
				
				return res;
		
	}
	public CourseDTO getCourseById(int courseId) throws SQLException {
		CourseDTO res;
//		System.out.println("service = " +courseId);
		 res= courseMapper.getCourseById(courseId);
		System.out.println(res);
		if(res==null
				) {
			
		} else {
//			throw new Exception("no data");
		}
		
		return res;
	}

	
	public int getTotalCount(PageRequestDTO pageRequest) throws SQLException {
		return courseMapper.getTotalCount(pageRequest);
	}
	public List<CourseInformDTO> getCourseWithPageRequest(PageRequestDTO pageRequest) throws Exception {
		List<CourseInformDTO> res;
//		System.out.println("service = " +courseId);
		 res= courseMapper. getCourseWithPageRequest(pageRequest);
//		System.out.println(res);
	
		
		return res;
	}



	
	
	// 코스작성왕
	public List<Integer> getCourseTop3() throws SQLException	{
		return courseMapper.getCourseTop3();
	}
}