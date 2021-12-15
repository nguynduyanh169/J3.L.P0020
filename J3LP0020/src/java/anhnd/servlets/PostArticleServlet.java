/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.servlets;

import anhnd.daos.ArticleDAO;
import anhnd.dtos.AccountDTO;
import anhnd.dtos.ArticleDTO;
import anhnd.dtos.ArticleError;
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
public class PostArticleServlet extends HttpServlet {

    private static final String POST_ARTICLE_PAGE = "member_post_article.jsp";
    private static final Logger LOG = Logger.getLogger(PostArticleServlet.class.getName());

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
        String title = request.getParameter("txtTitle");
        String shortDesc = request.getParameter("txtShortDesc");
        String content = request.getParameter("txtContent");
        ArticleError error = new ArticleError();
        boolean isError = false;
        try {
            if (title.isEmpty() || title.length() > 100) {
                error.setTitle("Title lenght is 1 - 100 characters.");
                isError = true;
            }
            if (shortDesc.isEmpty() || shortDesc.length() > 100) {
                error.setShortDesc("Short description lenght is 1 - 100 characters.");
                isError = true;
            }
            if (content.isEmpty() || content.length() > 500) {
                error.setContent("Content lenght is 1 - 500 characters.");
                isError = true;
            }
            if (isError) {
                request.setAttribute("ERROR", error);
            } else {
                HttpSession session = request.getSession();
                AccountDTO accountDTO = (AccountDTO) session.getAttribute("ACCOUNT");
                ArticleDAO articleDAO = new ArticleDAO();
                ArticleDTO articleDTO = new ArticleDTO(TextUtils.getUUID(), title, shortDesc, content, accountDTO.getEmail(), null, 0, accountDTO.getFullName());
                boolean check = articleDAO.insertArticle(articleDTO);
                if (check) {
                    url = "SearchArticleServlet?txtSearch=&page=1&forwardTo=member&btAction=Search";
                }
            }

        } catch (Exception e) {
            LOG.error("PostArticleServlet_Exception: " + e.getMessage());
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
