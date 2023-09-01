package com.example.lectureevaluation.controller;

import com.example.lectureevaluation.util.Gmail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

@WebServlet("/report")
public class ReportController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String userID = null;

        if ( session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 해주세요.');");
            script.println("location.href = 'userLogin.jsp'");
            script.println("</script>");
            script.close();
            return;
        }


        String reportTitle = null;
        String reportContent = null;
        if (request.getParameter("reportTitle") != null) {
            reportTitle = request.getParameter("reportTitle");
        }
        if (request.getParameter("reportContent") != null) {
            reportContent = request.getParameter("reportContent");
        }
        if (reportTitle == null || reportContent == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 부분이 있어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        }

        String host = "http://localhost:8080/";
        String from = "gwakmanager@gmail.com";
        String to = "gwakmanager@gmail.com";
        String subject = "강의평가 사이트에서 접수된 신고 메일.";
        String content = "신고자: " + userID + "<br> 제목 : " + reportTitle + "<br> 내용 : " + reportContent;

        Properties p = new Properties();
        p.put("mail.smtp.user", from);
        p.put("mail.smtp.host", "smtp.googlemail.com");
        p.put("mail.smtp.port", "465");
        p.put("mail.smtp.starttls.enable", "true");
        p.put("mail.smtp.auth", "true");
        p.put("mail.smtp.debug", "true");
        p.put("mail.smtp.socketFactory.port", "465");
        p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        p.put("mail.smtp.socketFactory.fallback", "false");

        try {
            Authenticator auth = new Gmail();
            Session ses = Session.getInstance(p, auth);
            ses.setDebug(true);
            MimeMessage msg = new MimeMessage(ses);
            msg.setSubject(subject);
            Address fromAddr = new InternetAddress(from);
            msg.setFrom(fromAddr);
            Address toAddr = new InternetAddress(to);
            msg.addRecipient(Message.RecipientType.TO, toAddr);
            msg.setContent(content,"text/html;charset=UTF8");
            Transport.send(msg);
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('오류가 발생했어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        }
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('신고가 정상적으로 접수되었어요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

}
