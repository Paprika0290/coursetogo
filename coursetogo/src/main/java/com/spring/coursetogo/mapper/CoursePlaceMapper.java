package com.spring.coursetogo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.spring.coursetogo.dto.CoursePlaceDTO;
import com.spring.coursetogo.dto.PlaceDTO;

@Mapper
public interface CoursePlaceMapper {

    public int insertCoursePlace(CoursePlaceDTO coursePlace);

}
