/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.servlets;

import anhnd.daos.ArticleDAO;
import anhnd.daos.CommentDAO;
import anhnd.dtos.ArticleDTO;
import anhnd.dtos.CommentDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class GetArticleServlet extends HttpServlet {

    private static final String GUEST_VIEW_ARTICLE = "guest_view_article.jsp";
    private static final String MEMBER_VIEW_ARTICLE = "member_view_article.jsp";
    private static final String ADMIN_VIEW_ARTICLE = "admin_view_article.jsp";
    private static final Logger LOG = Logger.getLogger(GetArticleServlet.class.getName());

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
        String url = GUEST_VIEW_ARTICLE;
        String articleId = request.getParameter("articleId");
        String forwardTo = request.getParameter("forwardTo");
        try {
            switch (forwardTo) {
                case "member":
                    url = MEMBER_VIEW_ARTICLE;
                    break;
                case "admin":
                    url = ADMIN_VIEW_ARTICLE;
                    break;
                default:
                    url = GUEST_VIEW_ARTICLE;
                    break;
            }
            HttpSession session = request.getSession();
            ArticleDAO articleDAO = new ArticleDAO();
            CommentDAO commentDAO = new CommentDAO();
            ArticleDTO articleDTO = articleDAO.getArticleById(articleId);
            if (articleDTO != null) {
                List<CommentDTO> comments = commentDAO.getCommentByArticleId(articleDTO.getArticleId());
                session.setAttribute("SELECTEDARTICLE", articleDTO);
                session.setAttribute("COMMENTS", comments);
            }
        } catch (Exception e) {
            LOG.error("GetArticleServlet_Exception: " + e.getMessage());
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
