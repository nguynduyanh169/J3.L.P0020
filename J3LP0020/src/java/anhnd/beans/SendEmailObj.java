/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.beans;

import java.io.Serializable;

/**
 *
 * @author anhnd
 */
public class SendEmailObj implements Serializable {

    private String name;
    private String email;
    private String code;

    public SendEmailObj(String name, String email, String code) {
        this.name = name;
        this.email = email;
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    
    
}
