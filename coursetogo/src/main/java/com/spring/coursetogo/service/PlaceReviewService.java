package com.spring.coursetogo.service;

import java.sql.SQLException;
import java.util.List;

import com.spring.coursetogo.dto.PlaceReviewDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.coursetogo.mapper.PlaceReviewMapper;


@Service
public class PlaceReviewService {
	
	@Autowired
	PlaceReviewMapper mapper;
	
	/* 장소 리뷰 아이디 검색 */ 
	public PlaceReviewDTO getPlaceReviewByReviewId(int placeReviewId) throws Exception {
        return mapper.getPlaceReviewByReviewId(placeReviewId);
	}

	
	/* 장소 리뷰 등록 */
	public boolean insertPlaceReview(PlaceReviewDTO placereview) throws SQLException, Exception {
		
		boolean result = false;
		
		int res = mapper.insertPlaceReview(placereview);
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("장소 리뷰 등록 실패");
		}
		
		return result;
	}

	
	/* 장소 리뷰 수정 */
	public boolean updatePlaceReview(PlaceReviewDTO placereview) throws SQLException, Exception {
		boolean result = false;
		
		int res = mapper.updatePlaceReview(placereview);
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("장소 리뷰 수정 실패");
		}
		
		return result;
	}
	
	/* 장소 리뷰 삭제 */
	public boolean deletePlaceReviewByReviewId(int placeReviewId) throws SQLException, Exception {
		boolean result = false;
		
		int res = mapper.deletePlaceReviewByReviewId(placeReviewId);
		
		if(res != 0) {
			result = true;
		} else {
			throw new Exception("장소 리뷰 삭제 실패");
		}
		
		return result;
	}
	
    // UserId와 PlaceId로 placeReview 검색하기
    public PlaceReviewDTO getPlaceReviewByUserIdAndPlaceId(int userId, int placeId) throws SQLException {
        return mapper.getPlaceReviewByUserIdAndPlaceId(userId, placeId);
    }
    
    // 장소리뷰왕   
	public List<Integer> getReviewTop3() throws SQLException{
		return mapper.getReviewTop3();
	}	
    
    
}
