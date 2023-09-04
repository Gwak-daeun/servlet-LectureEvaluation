package com.example.lectureevaluation.controller;

import com.example.lectureevaluation.controller.email.EmailCheckController;
import com.example.lectureevaluation.controller.email.EmailSendController;
import com.example.lectureevaluation.controller.evaluation.EvaluationDeleteController;
import com.example.lectureevaluation.controller.evaluation.EvaluationListController;
import com.example.lectureevaluation.controller.evaluation.EvaluationRegisterController;
import com.example.lectureevaluation.controller.evaluation.MainViewController;
import com.example.lectureevaluation.controller.like.LikeController;
import com.example.lectureevaluation.controller.report.ReportController;
import com.example.lectureevaluation.controller.user.*;

import java.util.HashMap;
import java.util.Map;

public class HandlerMapping {
    //Controller를 구현한 객체들을 저장하는 Map
    private final Map<String, Controller> mappings;

    public HandlerMapping() {
    //Key-value형태로 수많은 Controller를 등록한다.
        mappings = new HashMap<String, Controller>();
        mappings.put("/insertUserView.do", new UserInsertViewController());
        mappings.put("/insertUser.do", new UserInsertController());
        mappings.put("/evaluationRegister.do", new EvaluationRegisterController());
        mappings.put("/evaluationDelete.do", new EvaluationDeleteController());
        mappings.put("/report.do", new ReportController());
        mappings.put("/like.do", new LikeController());
        mappings.put("/login.do", new UserLoginController());
        mappings.put("/loginView.do", new UserLoginViewController());
        mappings.put("/logout.do", new UserLogoutController());
        mappings.put("/emailSend.do", new EmailSendController());
        mappings.put("/emailCheck.do", new EmailCheckController());
        mappings.put("/searchList.do", new EvaluationListController());
        mappings.put("/mainView.do", new MainViewController());

    }

    public Controller getController(String path) {
        //Map에 등록된 Controller들 중에서
        //특정 경로(path)에 해당하는 Controller를 리턴한다.
        return mappings.get(path);
    }

}
