package com.spring.coursetogo.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.coursetogo.dto.CourseInformDTO;
import com.spring.coursetogo.dto.CtgUserDTO;
import com.spring.coursetogo.dto.PlaceDTO;
import com.spring.coursetogo.service.CourseReviewService;
import com.spring.coursetogo.service.CourseService;
import com.spring.coursetogo.service.PlaceReviewService;
import com.spring.coursetogo.service.PlaceService;
import com.spring.coursetogo.service.RankingService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NaverAPIController {

    // application.properties에 저장된 값들-------------------------
    @Value("${naver.api.login.client.id}")
    private String clientId;

    @Value("${naver.api.login.client.secret}")
    private String clientSecret;

    @Value("${naver.api.login.callbackURL}")
    private String callbackURL;

    @Value("${naver.api.new.access.token.apiURL}")
    private String newAccessTokenApiURL;
    // ----------------------------------------------------------

    @Autowired
    private NaverAPIProfileController profileController;

    @Autowired
    private CtgUserController userController;

    @Autowired
    private RankingService rankingService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private PlaceService placeService;

    @Autowired
    private CourseReviewService courseReviewService;

    @Autowired
    private PlaceReviewService placeReviewService;

    // localhost:----/test 로 callback URL을 설정. 출력해줄 jsp는 myPage.jsp입니다
    @GetMapping(value = "/callback")
    public String loginPOSTNaver(@RequestParam("code") String code,
                                 @RequestParam("state") String state,
                                 HttpSession session, Model model) {
        log.info("login 시도");
        String redirectURI = "";

        try {
            redirectURI = URLEncoder.encode(callbackURL, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 접근 토큰 발급 요청 URL
        String apiURL;
        apiURL = newAccessTokenApiURL;
        apiURL += "client_id=" + clientId;
        apiURL += "&client_secret=" + clientSecret;
        apiURL += "&redirect_uri=" + redirectURI;
        apiURL += "&code=" + code;
        apiURL += "&state=" + state;
        //log.info("접근 토큰 발급 요청 apiURL = "+apiURL); //<-접근 토큰 발급 요청 URL 확인하고 싶으면 활성화
        JSONObject json = null; // 접근 토큰(json객체)
        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();
            log.info("접근 토큰 응답 코드 = "+responseCode); // <- 응답받은 접근 토큰 '응답 코드' 확인 200:성공

            BufferedReader br;
            if(responseCode==200) { // 정상 호출시 connection에서 가져온 정보 입력
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생시
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer res = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                res.append(inputLine);
            }
            log.info("접근 토근 응답 json 확인 :" + res); // <- 응답받은 접근 '토큰 내용' 확인
            log.info("여기까지 접근 토큰 요청 과정");

            br.close();

            if(responseCode==200) { // 정상 호출시 응답받은 토큰을 JSONObject로 변환
                json = new JSONObject(res.toString());
//		          System.out.println("json : " + json);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        CtgUserDTO user = profileController.getMemberProfile(json); // 접근 토큰을 이용해 네이버에서 유저 프로필을 가져와 user 객체에 맵핑해 돌려주는 메서드

        // 맵핑한 user객체정보로 DB접속, 기존 등록된 회원인지 확인
        CtgUserDTO searchUser = userController.getCtgUserByNaverIdAndName(user.getNaverId().substring(0, 10),
                user.getNaverId().substring(user.getNaverId().length() -10),
                user.getUserName());

        // 등록된 회원이 아니면
        if (searchUser == null) {
            session.setAttribute("newUser", user);
            return "myPage";
        }else {
            // 등록된 회원이라면
            CtgUserDTO userForSession = new CtgUserDTO(searchUser.getUserId(), searchUser.getUserName(),
                    searchUser.getUserNickname(), searchUser.getUserEmail(),
                    searchUser.getUserPhoto(), searchUser.getUserIntroduce());
            session.setMaxInactiveInterval(3600);
            session.setAttribute("user", userForSession);



            // 코스 추천
            List<String> courseIdList = rankingService.sortCourseIdByCount();
            List<String> placeIdList = rankingService.sortPlaceIdByCount();

            List<CourseInformDTO> courseInformDTOList = new ArrayList<CourseInformDTO>();
            List<String> courseDetailPageList = new ArrayList<String>();
            List<PlaceDTO> placeDTOList = new ArrayList<PlaceDTO>();

            // 코스작성왕, 코스리뷰왕, 장소리뷰왕
            List<Integer> courseMakeKingUserIds = new ArrayList<Integer>();
            List<Integer> courseReviewKingUserIds = new ArrayList<Integer>();
            List<Integer> placeReviewKingUserIds = new ArrayList<Integer>();
            List<String> courseMakeKingUserNicknames = new ArrayList<String>();
            List<String> courseReviewKingUserNicknames = new ArrayList<String>();
            List<String> placeReviewKingUserNicknames = new ArrayList<String>();

            for(String courseId : courseIdList) {
                CourseInformDTO courseInform = null;

                try {
                    courseInform = courseService.getCourseInformByCourseId(Integer.parseInt(courseId));
                } catch (Exception e) {
                    courseInform = null;
                }
                //임시방편. 무조건 5점으로 출력됨. 추후 테이블 수정봐야 함.
                courseInform.setCourseAvgScore(5.0);
                courseInformDTOList.add(courseInform);
            }

            for (CourseInformDTO course : courseInformDTOList) {
                int courseId = course.getCourseId();
                int courseNumber = course.getCourseNumber();
                String thisCoursePlaceIdList = course.getCourseIdList();

                String[] placeIds = thisCoursePlaceIdList.split(",");
                String query = "";

                query += ("courseId="+ String.valueOf(courseId)+"&");

                for(int i= 0; i< courseNumber; i++) {
                    query+="placeId"+(i+1) + "="+placeIds[i];
                    if (i!= courseNumber-1) {
                        query+="&";
                    }
                    else{
                    }
                }
                courseDetailPageList.add(query);
            }

            for(String placeId : placeIdList) {
                PlaceDTO place = null;

                try {
                    place = placeService.getPlaceByPlaceId(Integer.parseInt(placeId));
                } catch (Exception e) {
                    e.printStackTrace();
                }

                placeDTOList.add(place);
            }

            try {
                courseMakeKingUserIds = courseService.getCourseTop3();
                courseReviewKingUserIds = courseReviewService.getReviewTop3();
                placeReviewKingUserIds = placeReviewService.getReviewTop3();

            } catch (SQLException e) {
                e.printStackTrace();
            }



            String userNickname = null;

            for(int userId : courseMakeKingUserIds) {
                userNickname = userController.getCtgUserByUserId(userId).getUserNickname();
                if(userNickname == null) {
                    courseMakeKingUserNicknames.add("---");
                }else {
                    courseMakeKingUserNicknames.add(userNickname);
                }
            }

            for(int userId : courseReviewKingUserIds) {
                userNickname = userController.getCtgUserByUserId(userId).getUserNickname();
                if(userNickname == null) {
                    courseReviewKingUserNicknames.add("---");
                }else {
                    courseReviewKingUserNicknames.add(userNickname);
                }
            }

            for(int userId : placeReviewKingUserIds) {
                userNickname = userController.getCtgUserByUserId(userId).getUserNickname();
                if(userNickname == null) {
                    placeReviewKingUserNicknames.add("---");
                }else {
                    placeReviewKingUserNicknames.add(userNickname);
                }
            }


            //임시방편
            if(courseInformDTOList.size() >=3)	{
                List<CourseInformDTO> courseInformDTOSubList = courseInformDTOList.subList(0, 3);
                model.addAttribute("courseInformDTOList", courseInformDTOSubList);
            }

            if(placeDTOList.size() >=3)	{
                List<PlaceDTO> placeDTOSubList = placeDTOList.subList(0, 3);
                model.addAttribute("placeDTOList", placeDTOSubList);
            }

            model.addAttribute("courseMakeKingUserIds", courseMakeKingUserIds);
            model.addAttribute("courseReviewKingUserIds", courseReviewKingUserIds);
            model.addAttribute("placeReviewKingUserIds", placeReviewKingUserIds);
            model.addAttribute("courseMakeKingUserNicknames", courseMakeKingUserNicknames);
            model.addAttribute("courseReviewKingUserNicknames", courseReviewKingUserNicknames);
            model.addAttribute("placeReviewKingUserNicknames", placeReviewKingUserNicknames);

            model.addAttribute("courseDetailPageList", courseDetailPageList);

            return "home";
        }
    }
}
