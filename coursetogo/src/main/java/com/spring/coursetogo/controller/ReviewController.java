package com.spring.coursetogo.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.coursetogo.dto.CourseInformDTO;
import com.spring.coursetogo.dto.CourseReviewDTO;
import com.spring.coursetogo.dto.CtgUserDTO;
import com.spring.coursetogo.dto.PlaceDTO;
import com.spring.coursetogo.dto.PlaceReviewDTO;
import com.spring.coursetogo.service.CourseReviewService;
import com.spring.coursetogo.service.CourseService;
import com.spring.coursetogo.service.PlaceReviewService;
import com.spring.coursetogo.service.PlaceService;

@Controller
public class ReviewController {

    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Autowired
    private CourseReviewService coursereviewservice;

    @Autowired
    private PlaceReviewService placereviewservice;

    @Autowired
    private PlaceService placeService;

    @Autowired
    private CourseService courseService;

    @RequestMapping(value = "/setReview", method = RequestMethod.GET)
    public String insertCourseReviewForm(@RequestParam(value = "placeId1", required = false) String placeId1,
                                         @RequestParam(value = "placeId2", required = false) String placeId2,
                                         @RequestParam(value = "placeId3", required = false) String placeId3,
                                         @RequestParam(value = "placeId4", required = false) String placeId4,
                                         @RequestParam(value = "placeId5", required = false) String placeId5,
                                         @RequestParam(value= "courseId") String courseId,
                                         HttpSession session, Model model) {

        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        Integer[] placeIds = new Integer[5]; // Integer 클래스의 배열일 placeId를 선언하여 5개의 요소를 저장할수 있는 배열
        CourseInformDTO courseInform = null;

        try {
            placeIds[0] = placeId1 != null && !placeId1.isEmpty() ? Integer.parseInt(placeId1) : null;
            placeIds[1] = placeId2 != null && !placeId2.isEmpty() ? Integer.parseInt(placeId2) : null;
            placeIds[2] = placeId3 != null && !placeId3.isEmpty() ? Integer.parseInt(placeId3) : null;
            placeIds[3] = placeId4 != null && !placeId4.isEmpty() ? Integer.parseInt(placeId4) : null;
            placeIds[4] = placeId5 != null && !placeId5.isEmpty() ? Integer.parseInt(placeId5) : null;
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<PlaceDTO> placeList = new ArrayList<PlaceDTO>();

        // placeIds 배열에 저장된 각 placeId에 대해 장소 정보를 가져와서 placeList에 추가 하는 방식
        for (Integer placeId : placeIds) {
            if (placeId != null) {
                try {
                    placeList.add(placeService.getPlaceByPlaceId(placeId));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        try {
            courseInform = courseService.getCourseInformByCourseId(Integer.parseInt(courseId));
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("courseId", courseId);
        model.addAttribute("placeList", placeList); // placeId, placeName만 사용
        model.addAttribute("user", user);
        model.addAttribute("courseInform", courseInform);

        return "setReview";
    }

    // models 배열에서 null 이거나 빈 문자열인 요소들을 걸러낸 새로운 문자열 배열을 얻을수 있음
    private String[] filterNullValues(String... models) {
        List<String> filteredValues = new ArrayList<>();
        for (String value : models) {
            if (value != null && !value.isEmpty()) {
                filteredValues.add(value);
            }
        }
        return filteredValues.toArray(new String[filteredValues.size()]);
    }

    /* 코스리뷰 작성 이랑 장소 리뷰 별점 표기  */ // http://localhost:8090/review
    @RequestMapping(value = "/setreview", method= RequestMethod.POST)
    public String insertCouseReview(@ModelAttribute CourseReviewDTO courseReview,
                                    @ModelAttribute("placeScore1") String placeScore1,
                                    @ModelAttribute("placeScore2") String placeScore2,
                                    @ModelAttribute("placeScore3") String placeScore3,
                                    @ModelAttribute("placeScore4") String placeScore4,
                                    @ModelAttribute("placeScore5") String placeScore5,
                                    @ModelAttribute("place1") String placeId1,
                                    @ModelAttribute("place2") String placeId2,
                                    @ModelAttribute("place3") String placeId3,
                                    @ModelAttribute("place4") String placeId4,
                                    @ModelAttribute("place5") String placeId5,
                                    HttpSession session) {

        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        int userId = user.getUserId();

        // filterNullValues는 주어진 문자열 배열에서 null이 아니고 빈 문자열이 아닌 값들만 걸러내는 메서드
        String[] placeScores = filterNullValues(placeScore1, placeScore2, placeScore3, placeScore4, placeScore5);
        String[] placeIds = filterNullValues(placeId1, placeId2, placeId3, placeId4, placeId5);

        int placeCount = 0;
        String query = "";

//      System.out.println("받아온 코스리뷰 출력 : " + courseReview);

        // place 리뷰 남기기-------------------------------------------------------------------
        for (int i = 0; i < placeIds.length; i++) {
            PlaceReviewDTO placereview = null;

            if (placeScores[i] != null && placeIds[i] != null) {
                PlaceReviewDTO insertedPlaceReview = new PlaceReviewDTO(userId, Integer.parseInt(placeIds[i]), Integer.parseInt(placeScores[i]));
                PlaceReviewDTO alreadyInsertedPlaceReview = null;
                boolean result = false;
                //이미 별점을 매긴 장소인지 확인-----------------------
                try {
                    alreadyInsertedPlaceReview = placereviewservice.getPlaceReviewByUserIdAndPlaceId(insertedPlaceReview.getUserId(), insertedPlaceReview.getPlaceId());
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                // 매긴 적 없다면---------------------------------
                if(alreadyInsertedPlaceReview == null) {
                    try {
                        result = placereviewservice.insertPlaceReview(insertedPlaceReview);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    // 매긴 적 있다면---------------------------------
                } else {
                    try {
                        result = placereviewservice.updatePlaceReview(insertedPlaceReview);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if(result) {
                    placeCount++;
                }
            }
        }

        // course 리뷰 남기기-------------------------------------------------------------------
        boolean result = false;

        try {
            result = coursereviewservice.insertCourseReview(courseReview);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(result) {
//                System.out.println("course 리뷰 결과 : " + result);
        }

        query += ("courseId="+ String.valueOf(courseReview.getCourseId())+"&");

        for(int i= 0; i< placeCount; i++) {
            query+="placeId"+(i+1) + "="+placeIds[i];
            if (i!= placeCount-1) {
                query+="&";
            }
            else{
            }
        }

        return "redirect:/courseList/Map?" + query;

    }

    // 코스리뷰 수정 페이지로 이동
    @GetMapping(value = "/review/{courseReviewId}")
    public String updateCourseReviewForm(@PathVariable("courseReviewId") String courseReviewId, Model model, HttpSession session) {

        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        CourseReviewDTO courseReview = null;
        CourseInformDTO courseInform = null;

        // 코스 리뷰 아이디를 통해서 수정하기
        try {
            courseReview = coursereviewservice.getCourseReviewByReviewId(Integer.parseInt(courseReviewId));
            courseInform = courseService.getCourseInformByCourseId(courseReview.getCourseId());
        } catch (Exception e) {
            e.printStackTrace();
        }


        String[] placeIds = courseInform.getCourseIdList().split(",");

        List<PlaceDTO> placeList = new ArrayList<PlaceDTO>();
        List<PlaceReviewDTO> placeReviewList = new ArrayList<PlaceReviewDTO>();


        for(String placeId : placeIds) {
            PlaceReviewDTO placeReview = null;
            PlaceDTO place = null;


            try {
                place = placeService.getPlaceByPlaceId(Integer.parseInt(placeId));
                placeReview = placereviewservice.getPlaceReviewByUserIdAndPlaceId(user.getUserId(), Integer.parseInt(placeId));
            } catch (Exception e) {
                e.printStackTrace();
            }
            placeList.add(place);
            placeReviewList.add(placeReview);
        }

        model.addAttribute("courseInform", courseInform);
        model.addAttribute("courseReview", courseReview);
        model.addAttribute("placeList", placeList);
        model.addAttribute("placeReviewList", placeReviewList);

        return "updateReview";
    }

    // 코스리뷰 수정
    @PostMapping(value = "/review/{courseReviewId}")
    public String updateCourseReview(@PathVariable("courseReviewId") String courseReviewId,
                                     @ModelAttribute CourseReviewDTO courseReview,
                                     @ModelAttribute("placeScore1") String placeScore1,
                                     @ModelAttribute("placeScore2") String placeScore2,
                                     @ModelAttribute("placeScore3") String placeScore3,
                                     @ModelAttribute("placeScore4") String placeScore4,
                                     @ModelAttribute("placeScore5") String placeScore5,
                                     @ModelAttribute("place1") String placeId1,
                                     @ModelAttribute("place2") String placeId2,
                                     @ModelAttribute("place3") String placeId3,
                                     @ModelAttribute("place4") String placeId4,
                                     @ModelAttribute("place5") String placeId5,
                                     HttpSession session) {
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        int userId = user.getUserId();

        String[] placeScores = filterNullValues(placeScore1, placeScore2, placeScore3, placeScore4, placeScore5);
        String[] placeIds = filterNullValues(placeId1, placeId2, placeId3, placeId4, placeId5);

        int placeCount = 0;
        String query = "";

        // place 리뷰 수정하기-------------------------------------------------------------------
        for (int i = 0; i < placeIds.length; i++) {
            PlaceReviewDTO placereview = null;

            if (placeScores[i] != null && placeIds[i] != null) {
                PlaceReviewDTO insertedPlaceReview = new PlaceReviewDTO(userId, Integer.parseInt(placeIds[i]), Integer.parseInt(placeScores[i]));
                boolean result = false;

                try {
                    result = placereviewservice.updatePlaceReview(insertedPlaceReview);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if(result) {
                    placeCount++;
                }
            }
        }

        // course 리뷰 남기기-------------------------------------------------------------------
        boolean result = false;

        try {
            result = coursereviewservice.updateCourseReview(courseReview);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(result) {
            query += ("courseId="+ String.valueOf(courseReview.getCourseId())+"&");

            for(int i= 0; i< placeCount; i++) {
                query+="placeId"+(i+1) + "="+placeIds[i];
                if (i!= placeCount-1) {
                    query+="&";
                }
                else{
                }
            }
            return "redirect:/courseList/Map?" + query;
        }

        return "error";


    }



    /* 코스 리뷰 삭제  */
    @RequestMapping(value = "/setreview/{course_review_id}/delete", method= RequestMethod.POST)
    public String deleteCourse(@PathVariable ("course_review_id") String courseReviewIdStr ) throws Exception {


        Integer courseReviewId = 0;


        try {
            courseReviewId = courseReviewIdStr != null && !courseReviewIdStr.isEmpty() ? Integer.parseInt(courseReviewIdStr) : null;

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        coursereviewservice.deleteCourseReviewByReviewId(courseReviewId);

        return "redirect:/userContents";

    }



}


