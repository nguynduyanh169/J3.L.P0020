/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.servlets;

import anhnd.daos.ArticleDAO;
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
public class UpdateArticleStatusServlet extends HttpServlet {
    
    private static final String POST_ARTICLE_PAGE = "admin_view_article.jsp";
    private static final Logger LOG = Logger.getLogger(UpdateArticleStatusServlet.class.getName());

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
        String url = POST_ARTICLE_PAGE;
        String status = request.getParameter("rbStatus");
        String articleId = request.getParameter("articleId");
        try {
            HttpSession session = request.getSession();
            String selectedStatus = (String) session.getAttribute("SELECTEDSTATUS");
            if (status == null) {
                url = "SearchArticleServlet?txtSearch=&txtSearchTitle=&articleStatus=" + selectedStatus + "&page=1&forwardTo=admin&btAction=Search";
            } else {
                ArticleDAO articleDAO = new ArticleDAO();
                boolean check = articleDAO.changeArticleStatus(status.equals("approve") ? 1 : -1, articleId);
                if (check) {
                    url = "SearchArticleServlet?txtSearch=&txtSearchTitle=&articleStatus=" + selectedStatus + "&page=1&forwardTo=admin&btAction=Search";
                }
            }
            
        } catch (Exception e) {
            LOG.error("UpdateArticleStatusServlet_Exception: " + e.getMessage());
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
