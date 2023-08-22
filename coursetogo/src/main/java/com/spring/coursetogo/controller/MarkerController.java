package com.spring.coursetogo.controller;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.coursetogo.dto.CourseDTO;
import com.spring.coursetogo.dto.CoursePlaceDTO;
import com.spring.coursetogo.dto.CtgUserDTO;
import com.spring.coursetogo.dto.PlaceDTO;
import com.spring.coursetogo.service.CoursePlaceService;
import com.spring.coursetogo.service.CourseService;
import com.spring.coursetogo.service.DirectionService;
import com.spring.coursetogo.service.PlaceService;

@Controller
public class MarkerController {
    @Autowired
    private CourseService courseService;
    @Autowired
    private CoursePlaceService cpService;
    @Autowired
    private PlaceService placeService;
    @Autowired
    private DirectionService directionService;
    @Transactional
    @PostMapping("/saveMarker")
    public String saveMarker(HttpServletRequest request,
                             @RequestParam String courseName,
                             @RequestParam int courseNumber,
                             @RequestParam String courseContent,
                             @RequestParam(value = "placeId1", required = false, defaultValue = "") String placeId1,
                             @RequestParam(value = "placeId2", required = false, defaultValue = "") String placeId2,
                             @RequestParam(value = "placeId3", required = false, defaultValue = "") String placeId3,
                             @RequestParam(value = "placeId4", required = false, defaultValue = "") String placeId4,
                             @RequestParam(value = "placeId5", required = false, defaultValue = "") String placeId5,
                             RedirectAttributes redirectAttributes,
                             HttpSession session)

    {
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        System.out.println(user);

        if(!placeId1.equals("")&&!placeId1.equals("undefined")) redirectAttributes.addAttribute("placeId1", placeId1);
        if(!placeId2.equals("")&&!placeId2.equals("undefined")) redirectAttributes.addAttribute("placeId2", placeId2);
        if(!placeId3.equals("")&&!placeId3.equals("undefined")) redirectAttributes.addAttribute("placeId3", placeId3);
        if(!placeId4.equals("")&&!placeId4.equals("undefined")) redirectAttributes.addAttribute("placeId4", placeId4);
        if(!placeId5.equals("")&&!placeId5.equals("undefined")) redirectAttributes.addAttribute("placeId5", placeId5);
        redirectAttributes.addAttribute("courseNumber", courseNumber);






        session = request.getSession();
        int userId = (int)user.getUserId();
//        int userId = 1;
        int courseId = -1;
//        System.out.println(courseContent);
        //CourseDTO 생성
        CourseDTO course = CourseDTO.builder().userId(userId)
                .courseName(courseName)
                .courseNumber(courseNumber)
                .courseContent(courseContent)
                .build();


        try {

            //CourseService에 삽입
            courseId = 	courseService.insertCourse(course); // course update
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        Integer[] placeIdList = new Integer[5];
        if(!placeId1.equals("")&&!placeId1.equals("undefined"))placeIdList[0] = Integer.parseInt(placeId1);
        if(!placeId2.equals("")&&!placeId2.equals("undefined"))placeIdList[1] = Integer.parseInt(placeId2);
        if(!placeId3.equals("")&&!placeId3.equals("undefined"))placeIdList[2] = Integer.parseInt(placeId3);
        if(!placeId4.equals("")&&!placeId4.equals("undefined"))placeIdList[3] = Integer.parseInt(placeId4);
        if(!placeId5.equals("")&&!placeId5.equals("undefined"))placeIdList[4] = Integer.parseInt(placeId5);

        System.out.println(courseId);
        redirectAttributes.addAttribute("courseId", courseId);
        for (int i = 0; i < courseNumber; i++) {

            //주어진 코스에 맞게 코스 플레이스 관계형 데이터 삽입
            CoursePlaceDTO coursePlace = CoursePlaceDTO.builder().courseId(courseId).placeId(placeIdList[i]).selectionOrder(i+1).build();
            try {
                cpService.insertCoursePlace(coursePlace); // coursePlace : update
            } catch (Exception e) {
                e.printStackTrace();
            }


        }


        //direction15api를 활용한 실제 경로데이터 삽입 ( 제작시에)
        //1. place1 의 위도 경로 정보

        //2. place + courseNumber 의 위도 경도 정보
        //3. 1~ courseNumber 사이의 경유지 위도 경도 정보

        PlaceDTO place= null;



        String[] longLatList = new String[5];

        String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving";
        for (int i = 0; i < courseNumber; i++) {
            try {
                place = placeService.getPlaceByPlaceId(placeIdList[i]);
                longLatList[i] = place.getLongitude()+","+place.getLatitude();
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }




        HttpHeaders headers = new HttpHeaders();
        headers.set("X-NCP-APIGW-API-KEY-ID",  "8be51s2rte");
        headers.set("X-NCP-APIGW-API-KEY", "QszKDDmeBk91RsYDfJlHIZxQ5y8iyLyfc9KcJE8V");



        RestTemplate restTemplate = new RestTemplate();
        URI uri= null;

        try {
            if(courseNumber >= 2) {

                for(int i = 0 ; i < courseNumber-1; i++) {
                    uri = new URI(apiUrl + "?start=" + longLatList[i] + "&goal=" + longLatList[i+1] );


                    RequestEntity<?> requestEntity = new RequestEntity<>(headers, HttpMethod.GET, uri);

                    ResponseEntity<String> responseEntity = restTemplate.exchange(requestEntity, String.class);
                    String responseBody = responseEntity.getBody();

                    int startNumb = 1;
                    if(responseBody !=null){startNumb = directionService.insertDirections(responseBody, courseId, startNumb);}// 경로 저장}
                }


                return "redirect:/courseList/Map";
            }

            if(courseNumber ==1) {
                return "redirect:/courseList/Map";
            }


        } catch (URISyntaxException e) {
            e.printStackTrace();
            return "CourseList";
        }
        return "redirect:/courseList/Map";
    }
}
