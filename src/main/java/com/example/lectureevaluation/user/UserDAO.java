package com.example.lectureevaluation.user;

import com.example.lectureevaluation.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery(); // executeQuery() 데이터 검색, 조회 시에 쓰는 함수
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 틀림
                }
            }
            return -1; //아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {if (conn != null) {conn.close();}} catch (Exception e){e.printStackTrace();}
            try {if (pstmt != null) {pstmt.close();}} catch (Exception e){e.printStackTrace();}
            try {if (rs != null) {rs.close();}} catch (Exception e){e.printStackTrace();}

        }
        return -2; //데이터베이스 오류
    }

    public int join(UserDTO user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        System.out.println("회원가입 아이디 : " + user.getUserID() + ", 비밀번호 : " + user.getUserPassword());
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserEmail());
            pstmt.setString(4, user.getUserEmailHash());

            return pstmt.executeUpdate(); // insert, update, delete 를 처리하는 함수. 영향을 받은 데이터의 갯수를 반환한다.
            // 값 1을 반환하면 회원가입이 성공적으로 된것

        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {if (conn != null) {conn.close();}} catch (Exception e){e.printStackTrace();}
            try {if (pstmt != null) {pstmt.close();}} catch (Exception e){e.printStackTrace();}
            try {if (rs != null) {rs.close();}} catch (Exception e){e.printStackTrace();}
        }
        return -1; //데이터베이스 오류 혹은 회원가입 실패
    }

    public boolean getUserEmailChecked(String userID) {
        String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) { // 존재하는 사용자의 ID인 경우
                return rs.getBoolean(1); //userEmailChecked 속성 반환(true)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {if (conn != null) {conn.close();}} catch (Exception e){e.printStackTrace();}
            try {if (pstmt != null) {pstmt.close();}} catch (Exception e){e.printStackTrace();}
            try {if (rs != null) {rs.close();}} catch (Exception e){e.printStackTrace();}

        }
        return false; //데이터베이스 오류
    }

    public String getUserEmail(String userID) {
        String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {if (conn != null) {conn.close();}} catch (Exception e){e.printStackTrace();}
            try {if (pstmt != null) {pstmt.close();}} catch (Exception e){e.printStackTrace();}
            try {if (rs != null) {rs.close();}} catch (Exception e){e.printStackTrace();}

        }
        return null; //데이터베이스 오류
    }

    // 특정한 사용자가 이메일 검증을 통해 이메일 인증 완료 처리를 하는 메소드
    public boolean setUserEmailChecked(String userID) {
        String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.executeUpdate();
            return true; // 이미 이메일 인증을 한 경우라도 다시 이메일 인증을 할 수 있도록
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {if (conn != null) {conn.close();}} catch (Exception e){e.printStackTrace();}
            try {if (pstmt != null) {pstmt.close();}} catch (Exception e){e.printStackTrace();}
            try {if (rs != null) {rs.close();}} catch (Exception e){e.printStackTrace();}

        }
        return false; //데이터베이스 오류
    }

}