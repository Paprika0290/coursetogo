package com.spring.coursetogo.dto;

import java.util.Date;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;


@Document(collection = "courseData")
public class ChooseCourseDTO {

    @Id
    private String id;
    private int userId;
    private String courseId;

    private Date timestamp;

    public ChooseCourseDTO(int i, String courseId) {
        this.userId = i;
        this.courseId = courseId;
        this.timestamp = new Date();
    }

    // Getters, Setters, toString 등의 메소드
}