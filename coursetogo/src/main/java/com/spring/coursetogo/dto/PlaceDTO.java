package com.spring.coursetogo.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PlaceDTO {
    private int placeId;
    private String placeName;
    private double latitude;
    private double longitude;
    private String address;
    private double placeAvgScore;
    @Override
    public String toString() {
        return "PlaceDTO{" +
                "placeId=" + placeId +
                ", placeName='" + placeName + '\'' +
                ", latitude=" + latitude +
                ", longitude=" + longitude +
                ", address='" + address + '\'' +
                ", placeAvgScore=" + placeAvgScore +
                '}';
    }
}
