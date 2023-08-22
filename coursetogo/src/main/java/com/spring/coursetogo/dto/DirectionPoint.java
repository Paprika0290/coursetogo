package com.spring.coursetogo.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@Setter
@Getter
public class DirectionPoint {

    private double mapYCoordinate;
    private double mapXCoordinate;

    @Builder
    public DirectionPoint( double mapYCoordinate, double mapXCoordinate
    ) {


        this.mapYCoordinate = mapYCoordinate;
        this.mapXCoordinate = mapXCoordinate;

    }

}
