package com.spring.coursetogo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.spring.coursetogo.dto.PlaceDTO;

@Mapper
public interface PlaceMapper {

//	public int insertPlace(PlaceDTO place) throws SQLException;

    public PlaceDTO getPlaceByPlaceId(int placeId);

    public List<PlaceDTO> getAllPlaces();

    public List<PlaceDTO> searchPlaces(String placeName);

    public List<PlaceDTO> searchPlacesByPlaceName(String placeName);

//	public List<PlaceDTO> searchPlacesByJoin(int areaId, int categoryId);

    public List<PlaceDTO> searchPlacesByArea(String areaName);

    public List<PlaceDTO> searchPlacesByCategory(String categoryName);

    public List<PlaceDTO> searchPlacesByAreaOrCategory(String categoryName, String areaName);

    public List<PlaceDTO> searchPlacesByAreaOrCategory(Map<String, String> params);



}

