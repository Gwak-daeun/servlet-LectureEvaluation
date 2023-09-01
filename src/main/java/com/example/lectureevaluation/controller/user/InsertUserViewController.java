package com.example.lectureevaluation.controller.user;

import com.example.lectureevaluation.controller.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InsertUserViewController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("회원가입 화면으로 이동");
        return "insertUser";
    }
}
