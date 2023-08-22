package com.spring.coursetogo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.coursetogo.dto.DirectionDTO;
import com.spring.coursetogo.dto.PlaceDTO;

@Mapper
public interface DirectionMapper {

    void insertDirectionList(List<DirectionDTO> directionDTOList);

    List<DirectionDTO> getDirectionsByCourseId(int courseId);
}
