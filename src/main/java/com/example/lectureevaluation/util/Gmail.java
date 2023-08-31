package com.example.lectureevaluation.util;


import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        final String user = "gwakmanager@gmail.com";
        final String password = "cwikrismrspjkvzd";
        return new PasswordAuthentication(user, password);
    }

}
