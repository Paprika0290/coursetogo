package com.spring.coursetogo.interceptor;

import org.apache.ibatis.plugin.Intercepts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.spring.coursetogo.dto.CtgUserDTO;
import com.spring.coursetogo.dto.PageRequestDTO;
import com.spring.coursetogo.dto.PageResponseDTO;
import com.spring.coursetogo.service.SearchService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Component
public class ChooseInterceptor implements HandlerInterceptor {

    private final SearchService searchService;

    @Autowired
    public ChooseInterceptor(SearchService searchService) {
        this.searchService = searchService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 요청이 컨트롤러에 도달하기 전에 실행됩니다.
        // 검색 키워드를 추출하여 로깅 작업을 수행합니다.
//        PageResponseDTO pageResponse = (PageResponseDTO) request.getAttribute("pageInfo");

        HttpSession session = request.getSession();
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        int userId = -1;

        if (user != null) {
            // If the "user" session attribute exists, retrieve the user ID.
            userId = user.getUserId();
        }
        List<String> placeIdList = new ArrayList<>();
        String courseId = request.getParameter("courseId");

        String placeId1 = request.getParameter("placeId1");
        if(placeId1 != null)placeIdList.add(placeId1);
        String placeId2 = request.getParameter("placeId2");
        if(placeId2 != null)placeIdList.add(placeId2);
        String placeId3 = request.getParameter("placeId3");
        if(placeId3 != null)placeIdList.add(placeId3);
        String placeId4 = request.getParameter("placeId4");
        if(placeId4 != null)placeIdList.add(placeId4);
        String placeId5 = request.getParameter("placeId5");
        if(placeId5 != null)placeIdList.add(placeId5);
//        System.out.println("courseId = " + courseId);
//        System.out.println(placeIdList);

        // 가져온 값을 로깅 또는 다른 처리에 활용

        searchService.saveChooseOne(userId, placeIdList );
        searchService.saveCourse(userId, courseId);

        return true; // true를 반환하여 요청을 계속 진행합니다.
    }
}

