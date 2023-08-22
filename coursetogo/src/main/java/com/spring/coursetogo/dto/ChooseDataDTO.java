package com.spring.coursetogo.dto;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "chooseData")
public class ChooseDataDTO {

    @Id
    private String id;
    private int userId;
    private String placeId;

    private Date timestamp;

    public ChooseDataDTO(int i, String placeId) {
        this.userId = i;
        this.placeId = placeId;
        this.timestamp = new Date();
    }

    // Getters, Setters, toString 등의 메소드
}
