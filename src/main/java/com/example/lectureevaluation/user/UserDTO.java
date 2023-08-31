package com.example.lectureevaluation.user;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserDTO {
    private String userID;
    private String userPassword;
    private String userEmail;
    private String userEmailHash;
    private boolean userEmailChecked;

}