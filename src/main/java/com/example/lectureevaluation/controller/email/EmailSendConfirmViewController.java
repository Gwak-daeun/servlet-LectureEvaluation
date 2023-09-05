package com.example.lectureevaluation.controller.email;

import com.example.lectureevaluation.controller.Controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EmailSendConfirmViewController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Move to emailSendConfirmView");



        return "emailSend.do";
    }
}
