/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.servlets;

import anhnd.daos.ArticleDAO;
import anhnd.dtos.ArticleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
public class SearchArticleServlet extends HttpServlet {

    private static final String GUEST_HOME_PAGE = "guest_home.jsp";
    private static final String MEMBER_HOME_PAGE = "member_home.jsp";
    private static final String ADMIN_HOME_PAGE = "admin_home.jsp";
    private static final Logger LOG = Logger.getLogger(SearchArticleServlet.class.getName());

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
        String url;
        String searchContent = request.getParameter("txtSearch");
        String forwardTo = request.getParameter("forwardTo");
        int pageIndex = Integer.parseInt(request.getParameter("page"));
        int pageSize = 5;
        int endPage = 0;
        int totalArticle = 0;
        switch (forwardTo) {
            case "member":
                url = MEMBER_HOME_PAGE;
                break;
            case "admin":
                url = ADMIN_HOME_PAGE;
                break;
            default:
                url = GUEST_HOME_PAGE;
                break;
        }
        try {
            ArticleDAO articleDAO = new ArticleDAO();
            List<ArticleDTO> articles = new ArrayList<>();
            if (forwardTo.equals("admin")) {
                String articleStatus = request.getParameter("articleStatus");
                String searchTitle = request.getParameter("txtSearchTitle");
                totalArticle = articleDAO.countArticleForAdmin(searchContent, Integer.parseInt(articleStatus), searchTitle);
            } else {
                totalArticle = articleDAO.countArticleForUser(searchContent);
            }
            endPage = totalArticle / pageSize;
            if (totalArticle % pageSize != 0) {
                endPage++;
            }
            if (forwardTo.equals("admin")) {
                String articleStatus = request.getParameter("articleStatus");
                String searchTitle = request.getParameter("txtSearchTitle");
                articles = articleDAO.getArticleForAdmin(searchTitle, pageIndex, pageSize, Integer.parseInt(articleStatus), searchContent);
            } else {
                articles = articleDAO.getArticleForUser(searchContent, pageIndex, pageSize);
            }
            HttpSession session = request.getSession();
            if (request.getParameter("articleStatus") != null) {
                if (!request.getParameter("articleStatus").isEmpty()) {
                    session.setAttribute("SELECTEDSTATUS", request.getParameter("articleStatus"));
                }

            }
            session.setAttribute("ARTICLES", articles);
            session.setAttribute("TOTALPAGE", endPage);
        } catch (Exception e) {
            LOG.error("SearchArticleServlet_Exception: " + e.getMessage());
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
