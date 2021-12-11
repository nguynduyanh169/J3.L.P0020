/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.daos;

import anhnd.dtos.ArticleDTO;
import anhnd.dtos.CommentDTO;
import anhnd.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author anhnd
 */
public class CommentDAO {

    public CommentDAO() {
    }

    public List<CommentDTO> getCommentByArticleId(String articleId) throws SQLException, NamingException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        CommentDTO commentDTO = null;
        List<CommentDTO> result = null;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Select commentId, commentContent, status, commentBy, commentDate from Comment where articleId = ? and status = 1 order by commentDate desc";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, articleId);
            resultSet = preparedStatement.executeQuery();
            result = new ArrayList<>();
            while (resultSet.next()) {                
                String commentId = resultSet.getString("commentId");
                String commentContent = resultSet.getString("commentContent");
                int status = resultSet.getInt("status");
                String commentBy = resultSet.getString("commentBy");
                Date commentDate = resultSet.getDate("commentDate");
                Timestamp commentDateTime = resultSet.getTimestamp("commentDate");
                commentDTO = new CommentDTO(commentId, commentContent, articleId, status, commentBy, commentDate);
                commentDTO.setCommentDateTime(commentDateTime);
                result.add(commentDTO);
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
        return result;
    }
    
    public boolean insertComment(CommentDTO commentDTO) throws SQLException, NamingException{
         Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean check = false;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Insert into Comment(commentId, commentContent, status, commentBy, commentDate, articleId) values(?,?,?,?,GETDATE(),?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, commentDTO.getCommentId());
            preparedStatement.setString(2, commentDTO.getCommentContent());
            preparedStatement.setInt(3, commentDTO.getStatus());
            preparedStatement.setString(4, commentDTO.getCommentBy());
            preparedStatement.setString(5, commentDTO.getArticleId());
            int row = preparedStatement.executeUpdate();
            if(row > 0){
                check = true;
            }
        } finally {
            
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return check;
    }
}
