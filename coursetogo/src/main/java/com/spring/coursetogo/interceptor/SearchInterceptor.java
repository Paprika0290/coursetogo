package com.spring.coursetogo.interceptor;

import org.apache.ibatis.plugin.Intercepts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.spring.coursetogo.dto.PageRequestDTO;
import com.spring.coursetogo.dto.PageResponseDTO;
import com.spring.coursetogo.service.SearchService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Date;
@Component
public class SearchInterceptor implements HandlerInterceptor {

    private final SearchService searchService;

    @Autowired
    public SearchInterceptor(SearchService searchService) {
        this.searchService = searchService;
    }



    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 요청이 컨트롤러에 도달하기 전에 실행됩니다.
        // 검색 키워드를 추출하여 로깅 작업을 수행합니다.
//        PageResponseDTO pageResponse = (PageResponseDTO) request.getAttribute("pageInfo");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        String keyword = request.getParameter("keyword");
//        System.out.println("keyword = " + keyword);
        if (userId != null) {
            // 세션에서 userId 값이 존재하는 경우 처리
            // ...
        } else {
            // 세션에서 userId 값이 없는 경우 처리
            // ...
        }




        // 가져온 값을 로깅 또는 다른 처리에 활용
        if(keyword !=null)searchService.saveSearchKeyword(userId, keyword);


        return true; // true를 반환하여 요청을 계속 진행합니다.
    }
}
