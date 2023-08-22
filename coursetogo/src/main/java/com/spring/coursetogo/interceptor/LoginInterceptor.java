package com.spring.coursetogo.interceptor;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.spring.coursetogo.dto.CtgUserDTO;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        boolean isSessionValid = false;

        log.info("Login 상태인지 세션 확인");
        CtgUserDTO user = (CtgUserDTO)session.getAttribute("user");

        if(user != null) {
            isSessionValid =  true;
        } else {
            response.sendRedirect("/home");
        }

        return isSessionValid;
    }

}
