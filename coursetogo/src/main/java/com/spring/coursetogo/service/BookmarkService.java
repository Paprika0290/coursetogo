package com.spring.coursetogo.service;

import java.sql.SQLException;
import java.util.List;

import com.spring.coursetogo.dto.UserBookmarkCourseDTO;
import com.spring.coursetogo.mapper.BookmarkMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookmarkService {
	
	@Autowired
	private BookmarkMapper bkMapper;
	
	// 유저 아이디를 통해 유저가 북마크한 코스 객체 리스트 반환 ----------------------------------
	public List<UserBookmarkCourseDTO> getUserBookmarkListByUserId(int userId) throws SQLException {
		return bkMapper.getUserBookmarkListByUserId(userId);
	}	
	
	// userId와 courseId를 받아와 db에 저장---------------------------------------------------------------
	public boolean insertCourseBookmark(int userId, int courseId) throws SQLException{
		int result = bkMapper.insertCourseBookmark(userId, courseId);
		
		if(result != 0) {
			return true;
		}
		return false;
	}
	
	// userId와 courseId를 통해 db 값 삭제----------------------------------------------------------------
	public boolean deleteCourseBookmarkById(int userId, int courseId) throws Exception{
		boolean result = false;
		
		int res = bkMapper.deleteCourseBookmarkById(userId, courseId);
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("찜 해제 실패");
		}
		
		return result;
	}
}