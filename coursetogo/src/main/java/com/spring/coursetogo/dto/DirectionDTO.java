package com.spring.coursetogo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@Getter
@Setter
@ToString
public class DirectionDTO {
    private int courseId;
    private int directionOrder;
    private double latitude;
    private double longitude;



    @Builder
    public DirectionDTO(int courseId, int directionOrder, double latitude, double longitude) {
        this.courseId = courseId;
        this.directionOrder= directionOrder;
        this.latitude = latitude;
        this.longitude = longitude;

    }
}
