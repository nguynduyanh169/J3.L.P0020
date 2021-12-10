/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.utils;

import anhnd.beans.SendEmailObj;
import java.io.Serializable;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author anhnd
 */
public class EmailUtils implements Serializable {

    public static String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public static boolean sendVerifyEmail(SendEmailObj sendEmailObj) {
        boolean isSent = false;
        String emailOwner = "anhndse62808@fpt.edu.vn";
        String password = "vtbt0502";
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");

            Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(emailOwner, password);
                }
            });
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailOwner));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(sendEmailObj.getEmail()));
            message.setSubject("Email Verification Link");
            message.setText("Hello " + sendEmailObj.getName() + ". Please verify your account with this code: " + sendEmailObj.getCode());
            Transport.send(message);
            isSent = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSent;
    }
}
