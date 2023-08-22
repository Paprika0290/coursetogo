package com.spring.coursetogo.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.spring.coursetogo.dto.PlaceReviewDTO;


@Mapper
public interface PlaceReviewMapper {

    /* 장소 리뷰 아이디 검색 */
    public PlaceReviewDTO getPlaceReviewByReviewId (int placeReviewId) throws SQLException;

    /* 장소 리뷰 별점 매기기 */
    public int insertPlaceReview(PlaceReviewDTO placereview) throws SQLException;

    /* 장소 리뷰 수정하기 */
    public int updatePlaceReview(PlaceReviewDTO placereview) throws SQLException;

    /* 장소 리뷰  삭제하기 */
    public int deletePlaceReviewByReviewId(int placeReviewId)throws SQLException;

    // UserId와 PlaceId로 placeReview 검색하기
    public PlaceReviewDTO getPlaceReviewByUserIdAndPlaceId(@Param("userId") int userId, @Param("placeId") int placeId) throws SQLException;

    // 장소리뷰왕
    public List<Integer> getReviewTop3() throws SQLException;
}

