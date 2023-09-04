package com.example.lectureevaluation.controller.user;

import com.example.lectureevaluation.controller.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserInsertViewController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("move to Join View");
        return "insertUser";
    }
}
