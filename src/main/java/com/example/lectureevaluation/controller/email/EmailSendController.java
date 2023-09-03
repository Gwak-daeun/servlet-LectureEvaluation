package com.example.lectureevaluation.controller.email;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.user.UserDAO;
import com.example.lectureevaluation.util.Gmail;
import com.example.lectureevaluation.util.SHA256;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

public class EmailSendController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 해주세요.');");
            script.println("location.href = 'userLogin.jsp'");
            script.println("</script>");
            script.close();
            return null;
        }

        boolean emailChecked = userDAO.getUserEmailChecked(userID);
        if (emailChecked) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 인증된 회원입니다.');");
            script.println("location.href = 'index.jsp'");
            script.println("</script>");
            script.close();
            return null;
        }

        String host = "http://localhost:8080/";
        String from = "gwakmanager@gmail.com";
        String to = userDAO.getUserEmail(userID);
        String subject = "강의평가를 위한 이메일 인증 메일입니다.";
        String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." + "<a href='" + host + "emailCheck.do?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";

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
            script.println("alert('오류가 발생했습니다.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }
        return null;
    }
}
