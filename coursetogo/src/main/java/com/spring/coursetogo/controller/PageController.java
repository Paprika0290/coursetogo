package com.spring.coursetogo.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.coursetogo.dto.CourseInformDTO;
import com.spring.coursetogo.dto.CourseReviewDTO;
import com.spring.coursetogo.dto.CtgUserDTO;
import com.spring.coursetogo.dto.PlaceDTO;
import com.spring.coursetogo.dto.UserBookmarkCourseDTO;
import com.spring.coursetogo.service.CourseReviewService;
import com.spring.coursetogo.service.CourseService;
import com.spring.coursetogo.service.PlaceReviewService;
import com.spring.coursetogo.service.PlaceService;
import com.spring.coursetogo.service.RankingService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PageController {
    // 페이지이동, 세션관리를 담당하는 컨트롤러

    @Autowired
    private CtgUserController userController;
    @Autowired
    private CourseService courseService;
    @Autowired
    private PlaceService placeService;
    @Autowired
    private BookmarkController bookmarkController;
    @Autowired
    private CourseReviewService courseReviewService;
    @Autowired
    private PlaceReviewService placeReviewService;
    @Autowired
    private RankingService rankingService;
    @Value("${naver.api.login.client.id}")
    private String clientId;
    @Value("${naver.api.login.callbackURL}")
    private String callbackURL;
    @Value("${naver.api.login.apiURL}")
    private String apiURL;


    @GetMapping(value = "/")
    public String home() {
        return "redirect:/home";
    }

     //home으로 접속시 네이버 로그인 화면으로 이동하는  "apiURL"주소를 세션에 저장하여 home.jsp로 이동. "접근 토큰 요청" 메서드
    @GetMapping(value = "/home")
    public String login(HttpSession session, Model model) {
//		log.info("home 화면 출력");

        String redirectURI="";

        try {
            redirectURI = URLEncoder.encode(callbackURL, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();

        apiURL += "&client_id=" + clientId;
        apiURL += "&redirect_uri=" + redirectURI;
        apiURL += "&state=" + state;

        session.setAttribute("apiURL", apiURL);

        //코스 추천
        List<String> courseIdList = rankingService.sortCourseIdByCount();
        List<String> placeIdList = rankingService.sortPlaceIdByCount();

        List<CourseInformDTO> courseInformDTOList = new ArrayList<CourseInformDTO>();
        List<String> courseDetailPageList = new ArrayList<String>();
        List<PlaceDTO> placeDTOList = new ArrayList<PlaceDTO>();

        //코스작성왕, 코스리뷰왕, 장소리뷰왕
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

    // 회원 정보를 수정하는 페이지로 이동하는 메서드----------------------------------------------------
    // 나의 코스, 찜한코스, 나의 리뷰 개수를 가져오는 코드 추가
    @GetMapping(value = "/myPageInformModify")
    public String updateCtgUserForm(HttpSession session){
        CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
        int userId = user.getUserId();
        int myCourseCount = 0;
        int myBookmarkCount = 0;
        int myReviewCount = 0;

        myCourseCount = userController.getMyCourseCount(userId);
        myBookmarkCount = userController.getMyBookmarkCount(userId);
        myReviewCount = userController.getMyReviewCount(userId);

        session.setAttribute("myCourseCount", myCourseCount);
        session.setAttribute("myBookmarkCount", myBookmarkCount);
        session.setAttribute("myReviewCount", myReviewCount);

        return "myPageInformModify";
    }

    // 닉네임 중복 확인 메서드(개인정보 수정 페이지)------------------------------------------------------------------
    @RequestMapping(value = "/myPageInformModify/nicknameCheck")
    @ResponseBody
    public int nicknameCheck1(String userNickname, HttpSession session) {
        int res = 0;

        if(userNickname == null || userNickname == "") {
            res = -1;
            return res;
        } else {
            res = userController.nicknameCheck(userNickname);
            return res;
        }
    }

    // 닉네임 중복 확인 메서드(회원가입 페이지)------------------------------------------------------------------
    @RequestMapping(value = "/signupDone/nicknameCheck")
    @ResponseBody
    public int nicknameCheck2(String userNickname) {
        int res = 0;

        if(userNickname == null || userNickname == "") {
            res = -1;
            return res;
        } else {
            res = userController.nicknameCheck(userNickname);
            return res;
        }
    }

    @PostMapping(value = "/signupDone")
    public String signupDone(@ModelAttribute("userNickname") String newUserNickname,
                             @ModelAttribute("userIntroduce") String newUserIntroduce,
                             Model model, HttpSession session) {

        CtgUserDTO newUser = (CtgUserDTO)session.getAttribute("newUser");
        newUser.setUserNickname(newUserNickname);
        newUser.setUserIntroduce(newUserIntroduce);

        boolean result = userController.insertCtgUser(newUser);

        if (result) {
            CtgUserDTO user = userController.getCtgUserByNaverIdAndName(newUser.getNaverId().substring(0, 10),
                    newUser.getNaverId().substring(newUser.getNaverId().length() -10),
                    newUser.getUserName());
            CtgUserDTO userForSession = new CtgUserDTO(user.getUserId(), user.getUserName(),
                    user.getUserNickname(), user.getUserEmail(),
                    user.getUserPhoto(), user.getUserIntroduce());

            session.setMaxInactiveInterval(3600);
            session.setAttribute("user", userForSession);
            return "signupDone";
        }
        return "home";

    }

    // 로그아웃 시 세션 소멸
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        if(session != null) {
            session.invalidate();
        }
        return "redirect:/home";
    }

    // 회원 정보 수정 페이지에서 입력된 닉네임과 자기소개를 받아 수정하는 메서드---------------------------------
    // 성공하면 : true / 실패하면 : false
    @PostMapping(value = "/myPageInformModify")
    public String updateCtgUser(@ModelAttribute("userNickname") String userNickname,
                                @ModelAttribute("userIntroduce") String userIntroduce,
                                @ModelAttribute("userPhoto") String userPhoto,
                                HttpSession session) {
        CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
        CtgUserDTO DBuser = userController.getCtgUserByUserId(user.getUserId());

        DBuser.setUserNickname(userNickname);
        user.setUserNickname(userNickname);
        DBuser.setUserIntroduce(userIntroduce);
        user.setUserIntroduce(userIntroduce);
        DBuser.setUserPhoto(userPhoto);
        user.setUserPhoto(userPhoto);

        boolean result = false;

        try {
            result = userController.updateCtgUser(DBuser);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(result) {
            session.setAttribute("user", user);
            return "myPageInformModify";
        }
        return "redirect:/home";

    }

    @GetMapping(value = "/courseList")
    public String getCourseListPage(HttpSession session,
                                    Model model) {

        List<CourseInformDTO> courseInformList = new ArrayList<>();

        try {
            courseInformList = courseService.getAllCourses();
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("CourseInformList", courseInformList);
        return "CourseList";
    }

    @GetMapping(value = "/naverMap")
    public String getCourseMakePage(HttpSession session) {
//		CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
//		System.out.println(user);

        return "naverMap";
    }

    @GetMapping(value = "/userContents")
    public String getUserContentsPage(HttpSession session, Model model) {
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");

        List<CourseInformDTO> courseInformList = new ArrayList<CourseInformDTO>();
        List<String> courseMakerUserNameList = new ArrayList<String>();
        List<String> courseDetailPageList = new ArrayList<String>();

        try {
            courseInformList = courseService.getCourseInformByUserId(user.getUserId());

            for(CourseInformDTO courseInformDTO : courseInformList) {
                String userNickname = courseInformDTO.getUserNickName();
                courseMakerUserNameList.add(userNickname);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        for (CourseInformDTO course : courseInformList) {
            int courseId = course.getCourseId();
            String courseIdList = course.getCourseIdList();
            String[] placeIds = courseIdList.split(",");
            String query = "";
            int courseNumber = course.getCourseNumber();

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


        model.addAttribute("courseInformList", courseInformList);
        model.addAttribute("courseMakerUserNameList", courseMakerUserNameList);
        model.addAttribute("courseDetailPageList", courseDetailPageList);


        return "userContents";
    }

    // 나의 북마크
    @GetMapping(value = "/userBookmarkList")
    public String getUserBookmarkListPage(HttpSession session,
                                          Model model) {
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");

        List<UserBookmarkCourseDTO> userBookmarkList = bookmarkController.getUserBookmarkListByUserId(user.getUserId());

        List<CourseInformDTO> courseInformList = new ArrayList<CourseInformDTO>();
        List<String> courseMakerUserNameList = new ArrayList<String>();
        List<String> courseDetailPageList = new ArrayList<String>();

        for(UserBookmarkCourseDTO userBookmark : userBookmarkList) {

            int courseId = userBookmark.getCourseId();
            CourseInformDTO courseInform = null;

            try {
                courseInform = courseService.getCourseInformByCourseId(courseId);
            } catch (Exception e) {
                e.printStackTrace();
            }

            courseInformList.add(courseInform);
        }

        for(CourseInformDTO courseInformDTO : courseInformList) {
            String userNickname ="";
            userNickname = courseInformDTO.getUserNickName();

            if(userNickname == null) {
                courseMakerUserNameList.add("---");
            } else {
                courseMakerUserNameList.add(userNickname);
            }
        }

        for (CourseInformDTO course : courseInformList) {
            int courseId = course.getCourseId();
            String courseIdList = course.getCourseIdList();
            String[] placeIds = courseIdList.split(",");
            String query = "";
            int courseNumber = course.getCourseNumber();

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

        model.addAttribute("courseInformList", courseInformList);
        model.addAttribute("courseMakerUserNameList", courseMakerUserNameList);
        model.addAttribute("courseDetailPageList", courseDetailPageList);

        return "userCourseList";
    }

    // 나의 코스
    @GetMapping(value = "/userCourse")
    public String getUserCourseListPage(HttpSession session, Model model) {
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");

        List<CourseInformDTO> courseInformList = new ArrayList<CourseInformDTO>();
        List<String> courseMakerUserNameList = new ArrayList<String>();
        List<String> courseDetailPageList = new ArrayList<String>();

        try {
            courseInformList = courseService.getCourseInformByUserId(user.getUserId());
        } catch (Exception e) {
            e.printStackTrace();
        }

        for(CourseInformDTO courseInformDTO : courseInformList) {
            String userNickname ="";
            userNickname = courseInformDTO.getUserNickName();

            if(userNickname == null) {
                courseMakerUserNameList.add("---");
            } else {
                courseMakerUserNameList.add(userNickname);
            }
        }

        for (CourseInformDTO course : courseInformList) {
            int courseId = course.getCourseId();
            String courseIdList = course.getCourseIdList();
            String[] placeIds = courseIdList.split(",");
            String query = "";
            int courseNumber = course.getCourseNumber();

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

        model.addAttribute("courseInformList", courseInformList);
        model.addAttribute("courseMakerUserNameList", courseMakerUserNameList);
        model.addAttribute("courseDetailPageList", courseDetailPageList);

        return "userCourseList";
    }

    // 나의 리뷰
    @GetMapping(value = "userReview")
    public String getUserReviewPage(HttpSession session, Model model) {
        CtgUserDTO user = (CtgUserDTO) session.getAttribute("user");
        List<CourseReviewDTO> courseReviewList = new ArrayList<CourseReviewDTO>();
        List<CourseInformDTO> courseInformDTOList = new ArrayList<CourseInformDTO>();
        List<String> courseDetailPageList = new ArrayList<String>();

        try {
            courseReviewList = courseReviewService.getCourseReviewByUserId(user.getUserId());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        for(CourseReviewDTO review : courseReviewList) {
            CourseInformDTO courseInform = null;

            try {
                courseInform = courseService.getCourseInformByCourseId(review.getCourseId());
                if(courseInform.getUserNickName() == null) {
                    courseInform.setUserNickName("---");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            courseInformDTOList.add(courseInform);
        }

        for (CourseInformDTO course : courseInformDTOList) {
            int courseId = course.getCourseId();
            String courseIdList = course.getCourseIdList();
            String[] placeIds = courseIdList.split(",");
            String query = "";
            int courseNumber = course.getCourseNumber();

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


        model.addAttribute("courseReviewList", courseReviewList);
        model.addAttribute("courseInformDTOList", courseInformDTOList);
        model.addAttribute("courseDetailPageList", courseDetailPageList);

        return "userReviewList";
    }

}
