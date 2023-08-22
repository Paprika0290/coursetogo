package com.spring.coursetogo.dto;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class PlaceReviewDTO {

    private int placeReviewId; // 장소 리뷰 아이디
    private int userId; // 사용자
    private int placeId;   // 장소 아이디
    private Date reviewDate; // 리뷰가 작성된 날짜
    private int placeScore; // 리뷰 평점

    @Builder
    public PlaceReviewDTO(int userId, int placeId, int placeScore) {
        this.userId = userId;
        this.placeId = placeId;
        this.placeScore = placeScore;
    }

}
