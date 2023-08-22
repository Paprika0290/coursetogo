package com.spring.coursetogo.mapper;

import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.spring.coursetogo.dto.UserBookmarkCourseDTO;

@Mapper
public interface BookmarkMapper {

    public int insertCourseBookmark(@Param("userId") int userId, @Param("courseId") int courseId) throws SQLException;

    public int deleteCourseBookmarkById(@Param("userId") int userId, @Param("courseId") int courseId) throws SQLException;

    // 유저 아이디를 통해 유저가 북마크한 코스 객체 리스트 반환 ----------------------------------
    public List<UserBookmarkCourseDTO> getUserBookmarkListByUserId(int userId) throws SQLException;
}
