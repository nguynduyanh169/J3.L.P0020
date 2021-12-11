/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author anhnd
 */
public class CommentDTO implements Serializable{
    private String commentId;
    private String commentContent;
    private String articleId;
    private int status;
    private String commentBy;
    private Date commentDate;

    public CommentDTO(String commentId, String commentContent, String articleId, int status, String commentBy, Date commentDate) {
        this.commentId = commentId;
        this.commentContent = commentContent;
        this.articleId = articleId;
        this.status = status;
        this.commentBy = commentBy;
        this.commentDate = commentDate;
    }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getArticleId() {
        return articleId;
    }

    public void setArticleId(String articleId) {
        this.articleId = articleId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCommentBy() {
        return commentBy;
    }

    public void setCommentBy(String commentBy) {
        this.commentBy = commentBy;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }
    
    
}
