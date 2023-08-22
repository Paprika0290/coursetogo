package com.spring.coursetogo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class UserBookmarkCourseDTO {

    private int bookmarkId;
    private int userId;
    private int courseId;

    @Builder // 회원가입 필수정보(userId 제외)만으로 이루어진 builder
    public UserBookmarkCourseDTO(int bookmarkId, int userId, int courseId) {
        this.bookmarkId = bookmarkId;
        this.userId = userId;
        this.courseId = courseId;
    }
}

