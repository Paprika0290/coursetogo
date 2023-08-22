package com.spring.coursetogo.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.coursetogo.dto.CtgUserDTO;
import com.spring.coursetogo.dto.UserBookmarkCourseDTO;
import com.spring.coursetogo.service.BookmarkService;

@Controller
public class BookmarkController {

    @Autowired
    private BookmarkService bkService;

    // 코스 리스트에서 찜하기 기능----------------------------------------------------
    @RequestMapping(value = "/courseListWithPagination", method = RequestMethod.POST)
    @ResponseBody
    public int insertCourseBookmark(@RequestParam("courseId") int courseId,
                                    HttpSession session,
                                    Model model) throws Exception {
        CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
        int userId = user.getUserId();
        boolean res= false;
        try {
            res = bkService.insertCourseBookmark(userId, courseId);
            if(res == true) {
                return 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 찜 해제(db에서 삭제) 기능-------------------------------------------------------
    @RequestMapping(value = "/courseListWithPagination", method = RequestMethod.DELETE)
    @ResponseBody
    public int deleteCourseBookmarkById(@RequestParam("courseId") int courseId,
                                        HttpSession session,
                                        Model model) {
        CtgUserDTO user =  (CtgUserDTO) session.getAttribute("user");
        int userId = user.getUserId();
        boolean res = false;

        try {
            res = bkService.deleteCourseBookmarkById(userId, courseId);

            if(res) {
                return 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1;
    }

    // 유저 아이디를 통해 유저가 북마크한 코스 객체 리스트 반환 ----------------------------------
    public List<UserBookmarkCourseDTO> getUserBookmarkListByUserId(int userId) {

        List<UserBookmarkCourseDTO> bookmarkList = null;

        try {
            bookmarkList = bkService.getUserBookmarkListByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookmarkList;
    }

}
