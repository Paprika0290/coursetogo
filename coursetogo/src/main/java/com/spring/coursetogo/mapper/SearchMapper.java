package com.spring.coursetogo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchMapper {

    int saveSearchKeyword(String query);

}
