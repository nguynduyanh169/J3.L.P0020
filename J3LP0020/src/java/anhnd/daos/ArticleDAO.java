/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.daos;

import anhnd.dtos.AccountDTO;
import anhnd.dtos.ArticleDTO;
import anhnd.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author anhnd
 */
public class ArticleDAO {

    public ArticleDAO() {
    }

    public List<ArticleDTO> getArticleForUser(String searchContent, int pageIndex, int pageSize) throws SQLException, NamingException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        ArticleDTO articleDTO = null;
        List<ArticleDTO> result = null;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Select articleId, shortDescription, articleContent, author, postingDate, status form Article where articleContent like N'%" + searchContent + "%' and status = 1 "
                    + "order by postingDate desc "
                    + "offset ? rows fetch next ? rows only";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, (pageIndex - 1) * pageSize);
            preparedStatement.setInt(2, pageSize);
            resultSet = preparedStatement.executeQuery();
            result = new ArrayList<>();
            while (resultSet.next()) {
                String articleId = resultSet.getString("articleId");
                String shortDescription = resultSet.getString("shortDescription");
                String articleContent = resultSet.getString("articleContent");
                String author = resultSet.getString("author");
                Date postingDate = resultSet.getDate("postingDate");
                int status = resultSet.getInt("status");
                articleDTO = new ArticleDTO(articleId, shortDescription, articleContent, author, postingDate, status);
                result.add(articleDTO);
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

    public int countArticleForUser(String searchContent) throws NamingException, SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int result = 0;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Select count(articleId) form Article where articleContent like N'%" + searchContent + "%' and status = 1 ";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                result = resultSet.getInt(1);
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

}
