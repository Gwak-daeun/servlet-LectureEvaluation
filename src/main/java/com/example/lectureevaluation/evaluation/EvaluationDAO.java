package com.example.lectureevaluation.evaluation;

import com.example.lectureevaluation.util.DatabaseUtil;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EvaluationDAO {
    public int write(EvaluationDTO evaluationDTO) {
        String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, evaluationDTO.getUserID());
            pstmt.setString(2, evaluationDTO.getLectureName());
            pstmt.setString(3, evaluationDTO.getProfessorName());
            pstmt.setInt(4, evaluationDTO.getLectureYear());
            pstmt.setString(5, evaluationDTO.getSemesterDivide());
            pstmt.setString(6, evaluationDTO.getLectureDivide());
            pstmt.setString(7, evaluationDTO.getEvaluationTitle());
            pstmt.setString(8, evaluationDTO.getEvaluationContent());
            pstmt.setString(9, evaluationDTO.getTotalScore());
            pstmt.setString(10, evaluationDTO.getCreditScore());
            pstmt.setString(11, evaluationDTO.getComfortableScore());
            pstmt.setString(12, evaluationDTO.getLectureScore());
            return pstmt.executeUpdate(); // 성공했다면 1 반환

        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {
                if (conn != null) {conn.close();}
                if (pstmt != null) {pstmt.close();}
                if (rs != null) {rs.close();}
            } catch (Exception e){e.printStackTrace();}

        }
        return -1; //데이터베이스 오류
    }

    public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {

        System.out.println("Page Number : " + pageNumber);
        if (lectureDivide.equals("전체")) {
            lectureDivide = "";
        }
        ArrayList<EvaluationDTO> evaluationList = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            if (searchType.equals("최신순")) {
                SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
                        "? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            } else if (searchType.equals("추천순")) {
                SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
                        "? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            }
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + lectureDivide + "%");
            pstmt.setString(2, "%" + search + "%");
            rs = pstmt.executeQuery(); // executeQuery() 데이터 검색, 조회 시에 쓰는 함수
            evaluationList = new ArrayList<EvaluationDTO>();
            while (rs.next()) {
                EvaluationDTO evaluation = new EvaluationDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getInt(14)
                );
                evaluationList.add(evaluation);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {
                if (conn != null) {conn.close();}
                if (pstmt != null) {pstmt.close();}
                if (rs != null) {rs.close();}
            } catch (Exception e){e.printStackTrace();}

        }
        return evaluationList;
    }

    public int like(String evaluationID) {
        String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
           return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {
                if (conn != null) {conn.close();}
                if (pstmt != null) {pstmt.close();}
                if (rs != null) {rs.close();}
            } catch (Exception e){e.printStackTrace();}

        }
        return -1; //데이터베이스 오류
    }

    public int delete(String evaluationID) {
        String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {
                if (conn != null) {conn.close();}
                if (pstmt != null) {pstmt.close();}
                if (rs != null) {rs.close();}
            } catch (Exception e){e.printStackTrace();}

        }
        return -1; //데이터베이스 오류
    }

    public String getUserID(String evaluationID) {
        String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
            rs = pstmt.executeQuery();
            if (rs.next()) { // 존재하는 사용자의 ID인 경우
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            try {
                if (conn != null) {conn.close();}
                if (pstmt != null) {pstmt.close();}
                if (rs != null) {rs.close();}
            } catch (Exception e){e.printStackTrace();}

        }
        return null; //데이터베이스 오류
    }

    public int edit(
            int evaluationID, String lectureName, String professorName, int lectureYear,
            String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent
    ) {
        String SQL = "update evaluation set lectureName = ?, professorName = ?, lectureYear = ?, semesterDivide = ?, lectureDivide = ?, evaluationTitle = ?, evaluationContent = ? where evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {

            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, lectureName);
            pstmt.setString(2, professorName);
            pstmt.setInt(3, lectureYear);
            pstmt.setString(4, semesterDivide);
            pstmt.setString(5, lectureDivide);
            pstmt.setString(6, evaluationTitle);
            pstmt.setString(7, evaluationContent);
            pstmt.setInt(8, evaluationID);
           return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {conn.close();}
                if (pstmt != null) {pstmt.close();}
                if (rs != null) {rs.close();}
            } catch (Exception e){e.printStackTrace();}
        }
        return -1;
    }
}
