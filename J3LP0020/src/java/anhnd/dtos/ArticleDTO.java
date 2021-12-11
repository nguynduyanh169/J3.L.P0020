/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.dtos;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author anhnd
 */
public class ArticleDTO implements Serializable{
    private String articleId;
    private String shortDescription;
    private String articleContent;
    private String author;
    private Date postingDate;
    private int status;
    private String title;
    private String authorName;
    private Timestamp postingDateTime;

    public ArticleDTO(String articleId, String title, String shortDescription, String articleContent, String author, Date postingDate, int status, String authorName) {
        this.articleId = articleId;
        this.shortDescription = shortDescription;
        this.articleContent = articleContent;
        this.author = author;
        this.postingDate = postingDate;
        this.status = status;
        this.title = title;
        this.authorName = authorName;
    }

    public Timestamp getPostingDateTime() {
        return postingDateTime;
    }

    public void setPostingDateTime(Timestamp postingDateTime) {
        this.postingDateTime = postingDateTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArticleId() {
        return articleId;
    }

    public void setArticleId(String articleId) {
        this.articleId = articleId;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getPostingDate() {
        return postingDate;
    }

    public void setPostingDate(Date postingDate) {
        this.postingDate = postingDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    
    
}
