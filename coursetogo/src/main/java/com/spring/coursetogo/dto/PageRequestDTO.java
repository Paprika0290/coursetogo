package com.spring.coursetogo.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class PageRequestDTO{
    //현재 페이지 번호
    private int pageNum;
    private int userId;
    private String keyword;
    //페이지당 출력할 데이터 개수
    private int amount;

    public PageRequestDTO() {
        this(1, 10);
    }
    @Builder
    public PageRequestDTO(int pageNum, int amount, String keyword) {
        this.pageNum = pageNum;
        this.amount = amount;
        this.keyword = keyword;
    }
    public PageRequestDTO(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
