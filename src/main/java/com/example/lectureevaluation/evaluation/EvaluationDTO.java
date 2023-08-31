package com.example.lectureevaluation.evaluation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EvaluationDTO {
    int evaluationID;
    String userID;
    String lectureName;
    String professorName;
    int lectureYear;
    String semesterDivide;
    String lectureDivide;
    String evaluationTitle;
    String evaluationContent;
    String totalScore;
    String creditScore;
    String comfortableScore;
    String lectureScore;
    int likeCount;

}
