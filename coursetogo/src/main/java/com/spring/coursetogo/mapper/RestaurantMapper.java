package com.spring.coursetogo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.spring.coursetogo.dto.Restaurant;
import com.spring.coursetogo.dto.SearchKeyword;

@Mapper
public interface RestaurantMapper {
//    @Select("SELECT 식품인증업소일련번호, 업소_명, 자치구_코드, 자치구_명, 업태_코드, 업태_명, 지도_Y좌표, 지도_X좌표, 전화번호, 도로명주소 FROM 음식점")
//    @ResultMap("restaurantResultMap")

    public List<Restaurant> getRestaurantBySearchKeyword(SearchKeyword searchKeyword);
    public List<Restaurant> getAllRestaurant();
}
