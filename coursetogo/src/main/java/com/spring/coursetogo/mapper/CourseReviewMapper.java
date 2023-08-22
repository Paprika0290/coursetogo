package com.spring.coursetogo.mapper;

import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.coursetogo.dto.CourseReviewDTO;


@Mapper
public interface CourseReviewMapper {

    /* 코스 리뷰 아이디 검색 */
    public CourseReviewDTO getCourseReviewByReviewId (int courseReviewId);

    /* 코스 리뷰 작성하기 */
    public int insertCourseReview(CourseReviewDTO coursereview) throws SQLException;

    /* 코스 리뷰 수정하기 */
    public int updateCourseReview(CourseReviewDTO coursereview) throws SQLException;

    /* 코스 리뷰  삭제하기 */
    public int deleteCourseReviewByReviewId(int courseReviewId)throws SQLException;

    /* 코스 아이디 검색 */
    public List<CourseReviewDTO> getCourseReviewByCourseId (int courseId) throws SQLException;

    // userId로 CourseReview 객체 리스트 반환
    public List<CourseReviewDTO> getCourseReviewByUserId(int userId) throws SQLException;

    // userId와 courseId로 CourseReview 객체 리스트 반환
    public CourseReviewDTO getCourseReviewByUserIdAndCourseId(@Param("userId") int userId, @Param("courseId") int courseId) throws SQLException;

    // 코스리뷰왕
    public List<Integer> getReviewTop3() throws SQLException;



}

