package com.spring.coursetogo.dto;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "searchData")
public class SearchDataDTO {

    @Id
    private String id;
    private int userId;
    private String keyword;
    private Date timestamp;

    public SearchDataDTO(int i, String keyword) {
        this.userId = i;
        this.keyword = keyword;
        this.timestamp = new Date();
    }

}
