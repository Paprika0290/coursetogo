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
public class CoursePlaceDTO {
    private int courseId;
    private int placeId;
    private int selectionOrder;


    @Builder
    public CoursePlaceDTO(int courseId, int placeId, int selectionOrder) {
        this.courseId = courseId;
        this.placeId = placeId;
        this.selectionOrder = selectionOrder;
    }


}
