/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.servlets;

import anhnd.daos.CommentDAO;
import anhnd.dtos.AccountDTO;
import anhnd.dtos.ArticleDTO;
import anhnd.dtos.CommentDTO;
import anhnd.utils.TextUtils;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author anhnd
 */
public class SaveCommentServlet extends HttpServlet {

    private static final String MEMBER_VIEW_ARTICLE = "member_view_article.jsp";
        private static final Logger LOG = Logger.getLogger(SaveCommentServlet.class.getName());


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = MEMBER_VIEW_ARTICLE;
        String errorMsg = "";
        boolean isError = false;
        try {
            String commentContent = request.getParameter("txtComment");
            if (commentContent.isEmpty() || commentContent.length() > 100) {
                errorMsg = "Comment field lenght is 0-100!";
                isError = true;
            }
            if (isError) {
                request.setAttribute("ERROR", errorMsg);
            } else {
                HttpSession session = request.getSession();
                AccountDTO accountDTO = (AccountDTO) session.getAttribute("ACCOUNT");
                CommentDAO commentDAO = new CommentDAO();
                ArticleDTO selectedArticle = (ArticleDTO) session.getAttribute("SELECTEDARTICLE");
                if (accountDTO != null && selectedArticle != null) {
                    CommentDTO commentDTO = new CommentDTO(TextUtils.getUUID(), commentContent, selectedArticle.getArticleId(), 1, accountDTO.getEmail(), null);
                    boolean check = commentDAO.insertComment(commentDTO);
                    if (check == true) {
                        url = "GetArticleServlet?articleId=" + selectedArticle.getArticleId() + "&forwardTo=member&btAction=View+Article";
                    } else {
                        errorMsg = "Comment error! Try later";
                        request.setAttribute("ERROR", errorMsg);
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("SaveCommentServlet_Exception: " + e.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
