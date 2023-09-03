package com.example.lectureevaluation.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface Controller {
    String handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
