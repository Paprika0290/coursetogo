package com.spring.coursetogo.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CtgUserDTO {

    private int userId;

    // 네이버API에서 돌려주는 값--------------------------------
    @JsonProperty("id")
    private String naverId;

    @JsonProperty("name")
    private String userName;

    @JsonProperty("nickname") // 이 값은 회원가입 진행시 수정값에 따라 변경되어 insert.
    private String userNickname;

    @JsonProperty("email")
    private String userEmail;

    @JsonProperty("birthyear")
    private int userBirthYear;
    // 네이버API에서 돌려주는 값----------------------------------

    // 회원가입시 기본값: 1(int)로 insert 실행
    private int userAdmin;

    // 회원가입시 기본값: 기본 이미지 URL(string)로 insert 실행
    private String userPhoto;

    private String userIntroduce; // 이 값은 회원가입 진행시 수정값에 따라 변경되어 insert.

    @Builder // 회원가입 전 유저정보 확인용 builder
    public CtgUserDTO(String naverId, String userName, String userNickname, String userEmail,
                      int userBirthYear) {
        this.naverId = naverId;
        this.userName = userName;
        this.userNickname = userNickname;
        this.userEmail = userEmail;
//		this.userBirthYear = userBirthYear;
    }

    @Builder // 회원가입용 builder
    public CtgUserDTO(String naverId, String userName, String userNickname, String userEmail,
                      int userBirthYear, String userIntroduce) {
        this.naverId = naverId;
        this.userName = userName;
        this.userNickname = userNickname;
        this.userEmail = userEmail;
//		this.userBirthYear = userBirthYear;
        this.userIntroduce = userIntroduce;
    }

    @Builder // 세션부여용 builder
    public CtgUserDTO(int userId, String userName, String userNickname,
                      String userEmail, String userPhoto, String userIntroduce) {
        this.userId = userId;
        this.userName = userName;
        this.userNickname = userNickname;
        this.userEmail = userEmail;
        this.userPhoto = userPhoto;
        this.userIntroduce = userIntroduce;
    }

}