package com.questionpro.controller;

import com.questionpro.dao.AdminDAO;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
   protected void doPost(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if(username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()){

            response.sendRedirect(request.getContextPath()
                    + "/admin/adminLogin.jsp?error=empty");
            return;

        }

        try{

            boolean valid = adminDAO.validateAdmin(
                    username.trim(),
                    password.trim());

            if(valid){

                HttpSession oldSession = request.getSession(false);

                if(oldSession != null){
                    oldSession.invalidate();
                }

                HttpSession session = request.getSession(true);

                session.setAttribute("admin", username.trim());

                session.setMaxInactiveInterval(30*60);

                response.sendRedirect(request.getContextPath()
                        + "/admin/dashboard.jsp");

            }else{

                response.sendRedirect(request.getContextPath()
                        + "/admin/adminLogin.jsp?error=invalid");

            }

        }catch(Exception e){

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/admin/adminLogin.jsp?error=server");

        }

    }

}