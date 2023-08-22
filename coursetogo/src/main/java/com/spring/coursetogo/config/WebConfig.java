package com.spring.coursetogo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.spring.coursetogo.interceptor.ChooseInterceptor;
import com.spring.coursetogo.interceptor.LoginInterceptor;
import com.spring.coursetogo.interceptor.SearchInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private final SearchInterceptor searchInterceptor;

    @Autowired
    private final ChooseInterceptor chooseInterceptor;

    @Autowired
    private final LoginInterceptor LoginInterceptor;

    @Autowired
    public WebConfig(SearchInterceptor searchInterceptor,
                     ChooseInterceptor chooseInterceptor,
                     LoginInterceptor loginInterceptor) {
        this.searchInterceptor = searchInterceptor;
        this.chooseInterceptor = chooseInterceptor;
        this.LoginInterceptor = loginInterceptor;
    }



    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(searchInterceptor)
                .addPathPatterns("/courseList")
                .addPathPatterns("/courseListWithPagination");

        registry.addInterceptor(chooseInterceptor)
                .addPathPatterns("/courseList/Map");

        //로그인 인터셉터 추가
//        registry.addInterceptor(LoginInterceptor)
//                .addPathPatterns("/**")
//                .excludePathPatterns("/resources/**", "/css/**","/example/**", "/images/**",
//            		  		     	 "/courseList", "/home", "/callback", "/signupDone");
    }
}
