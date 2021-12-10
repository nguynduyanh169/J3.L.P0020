/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anhnd.servlets;

import anhnd.beans.SendEmailObj;
import anhnd.daos.AccountDAO;
import anhnd.dtos.AccountDTO;
import anhnd.dtos.AccountError;
import anhnd.utils.EmailUtils;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author anhnd
 */
public class RegisterServlet extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String REGISTER_PAGE = "register.jsp";
    private static final String CONFIRM_CODE_PAGE = "confirm_email.jsp";
    private static final Pattern VALID_EMAIL_ADDRESS_REGEX
            = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);

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
        String action = request.getParameter("btAction");
        String url = REGISTER_PAGE;

        try {
            if (action.equals("Register")) {
                String email = request.getParameter("txtEmail");
                String password = request.getParameter("txtPassword");
                String fullName = request.getParameter("txtFullname");
                AccountError error = new AccountError();
                boolean validated = true;
                if (VALID_EMAIL_ADDRESS_REGEX.matcher(email).find() == false) {
                    validated = false;
                    error.setEmailError("Email must be valid");
                }
                if (password.length() < 7 || password.length() > 20) {
                    validated = false;
                    error.setPasswordError("Password in range 7-20");
                }
                if (fullName.isEmpty()) {
                    validated = false;
                    error.setFullNameError("Fullname cannot be blank");
                }
                if (validated == false) {
                    request.setAttribute("VALIDATE", error);
                } else {
                    AccountDAO accountDAO = new AccountDAO();
                    AccountDTO accountDTO = new AccountDTO(email, fullName, 1, 0);
                    accountDTO.setPassword(password);
                    boolean check = accountDAO.insertAccount(accountDTO);
                    if (check == true) {
                        String randomCode = EmailUtils.getRandom();
                        SendEmailObj sendEmailObj = new SendEmailObj(fullName, email, randomCode);
                        boolean isSentEmail = EmailUtils.sendVerifyEmail(sendEmailObj);
                        if (isSentEmail) {
                            request.setAttribute("CODE", sendEmailObj.getCode());
                            request.setAttribute("CONFIRMEMAIL", email);
                            url = CONFIRM_CODE_PAGE;
                        } else {
                            request.setAttribute("ERROR", "Send confirm code to this account failed. Try again!");
                            url = REGISTER_PAGE;
                        }

                    } else {
                        request.setAttribute("ERROR", "Cannot register!");
                        url = REGISTER_PAGE;
                    }
                }
            } else if (action.equals("Confirm")) {
                String confirmCode = request.getParameter("txtConfirmCode");
                String code = request.getParameter("code");
                String sentEmail = request.getParameter("email");
                String errorMsg = "";
                boolean isError = false;
                if (confirmCode.equals(code) == false) {
                    errorMsg = "This code is invalid";
                    isError = true;
                }
                if (isError) {
                    request.setAttribute("ERROR", errorMsg);
                    request.setAttribute("CODE", code);
                    request.setAttribute("CONFIRMEMAIL", sentEmail);
                    url = CONFIRM_CODE_PAGE;
                } else {
                    AccountDAO accountDAO = new AccountDAO();
                    boolean check = accountDAO.activeAccount(sentEmail);
                    if (check) {
                        url = LOGIN_PAGE;
                    }
                }
            }
        } catch (Exception e) {
            if (e.getMessage().contains("duplicate")) {
                request.setAttribute("ERROR", "This account is existed!");
                url = REGISTER_PAGE;
            }
            e.printStackTrace();
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
