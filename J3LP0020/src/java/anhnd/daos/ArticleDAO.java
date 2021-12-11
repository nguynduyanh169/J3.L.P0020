/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.daos;

import anhnd.dtos.ArticleDTO;
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
            String sql = "Select articleId, title, shortDescription, articleContent, author, postingDate, status, authorName from Article where articleContent like N'%" + searchContent + "%' and status = 1 "
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
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("authorName");
                Timestamp postingDateTime = resultSet.getTimestamp("postingDate");
                articleDTO = new ArticleDTO(articleId, title, shortDescription, articleContent, author, postingDate, status, authorName);
                articleDTO.setPostingDateTime(postingDateTime);
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
            String sql = "Select count(articleId) from Article where articleContent like N'%" + searchContent + "%' and status = 1 ";
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

    public List<ArticleDTO> getArticleForAdmin(String searchContent, int pageIndex, int pageSize, int selectedStatus) throws SQLException, NamingException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        ArticleDTO articleDTO = null;
        List<ArticleDTO> result = null;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Select articleId, title, shortDescription, articleContent, author, postingDate, status, authorName from Article where articleContent like N'%" + searchContent + "%' and status = ? "
                    + "order by postingDate desc "
                    + "offset ? rows fetch next ? rows only";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, selectedStatus);
            preparedStatement.setInt(2, (pageIndex - 1) * pageSize);
            preparedStatement.setInt(3, pageSize);
            resultSet = preparedStatement.executeQuery();
            result = new ArrayList<>();
            while (resultSet.next()) {
                String articleId = resultSet.getString("articleId");
                String shortDescription = resultSet.getString("shortDescription");
                String articleContent = resultSet.getString("articleContent");
                String author = resultSet.getString("author");
                Date postingDate = resultSet.getDate("postingDate");
                int status = resultSet.getInt("status");
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("authorName");
                Timestamp postingDateTime = resultSet.getTimestamp("postingDate");
                articleDTO = new ArticleDTO(articleId, title, shortDescription, articleContent, author, postingDate, status, authorName);
                articleDTO.setPostingDateTime(postingDateTime);
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

    public int countArticleForAdmin(String searchContent, int selectedStatus) throws NamingException, SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int result = 0;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Select count(articleId) from Article where articleContent like N'%" + searchContent + "%' and status = ? ";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, selectedStatus);
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

    public ArticleDTO getArticleById(String articleId) throws NamingException, SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        ArticleDTO articleDTO = null;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Select title, shortDescription, articleContent, author, postingDate, status, authorName from Article where articleId = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, articleId);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String shortDescription = resultSet.getString("shortDescription");
                String articleContent = resultSet.getString("articleContent");
                String author = resultSet.getString("author");
                Date postingDate = resultSet.getDate("postingDate");
                int status = resultSet.getInt("status");
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("authorName");
                Timestamp postingDateTime = resultSet.getTimestamp("postingDate");
                articleDTO = new ArticleDTO(articleId, title, shortDescription, articleContent, author, postingDate, status, authorName);
                articleDTO.setPostingDateTime(postingDateTime);
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
        return articleDTO;

    }

    public boolean insertArticle(ArticleDTO articleDTO) throws NamingException, SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean check = false;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Insert into Article(articleId, title, shortDescription, articleContent, author, postingDate, status, authorName) values(?,?,?,?,?,GETDATE(),?,?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, articleDTO.getArticleId());
            preparedStatement.setString(2, articleDTO.getTitle());
            preparedStatement.setString(3, articleDTO.getShortDescription());
            preparedStatement.setString(4, articleDTO.getArticleContent());
            preparedStatement.setString(5, articleDTO.getAuthor());
            preparedStatement.setInt(6, articleDTO.getStatus());
            preparedStatement.setString(7, articleDTO.getAuthorName());
            int row = preparedStatement.executeUpdate();
            if (row > 0) {
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

    public boolean changeArticleStatus(int status, String articleId) throws NamingException, SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean check = false;
        try {
            connection = DBUtils.makeConnection();
            String sql = "Update Article set status = ? where articleId = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, status);
            preparedStatement.setString(2, articleId);
            int row = preparedStatement.executeUpdate();
            if (row > 0) {
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
