/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.dtos;

import anhnd.utils.DBUtils;
import anhnd.utils.TextUtils;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author anhnd
 */
public class AccountDAO {

    public AccountDAO() {
    }
    
    public AccountDTO checkLogin(String email, String password) throws SQLException, NamingException, NoSuchAlgorithmException {
        AccountDTO accountDTO = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = DBUtils.makeConnection();
            if (connection != null) {
                connection = DBUtils.makeConnection();
                if (connection != null) {
                    String sql = "Select email, fullName, role, status from Account where email=? and password=?";
                    preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, email);
                    preparedStatement.setString(2, TextUtils.encrypt(password));
                    resultSet = preparedStatement.executeQuery();
                    if (resultSet.next()) {
                        String fullName = resultSet.getString("fullName");
                        int status = resultSet.getInt("status");
                        int role = resultSet.getInt("role");
                        accountDTO = new AccountDTO(email, fullName, role, status);
                    }
                }
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return accountDTO;
    }
    
    public boolean insertAccount(AccountDTO dto) throws NamingException, SQLException, NoSuchAlgorithmException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = DBUtils.makeConnection();
            if (connection != null) {
                String sql = "Insert into Account(email, fullName, password, role, status) values(?,?,?,?,?)";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, dto.getEmail());
                preparedStatement.setString(2, dto.getFullName());
                preparedStatement.setString(3, TextUtils.encrypt(dto.getPassword()));
                preparedStatement.setInt(4, dto.getRole());
                preparedStatement.setInt(5, dto.getStatus());
                int row = preparedStatement.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return false;
    }
    
}
