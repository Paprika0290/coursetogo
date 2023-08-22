package com.spring.coursetogo.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface AreaMapper {

    List<String> getRecommendations(String query) throws SQLException;

}
