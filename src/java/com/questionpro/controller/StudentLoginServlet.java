package com.questionpro.controller;

import com.questionpro.dao.StudentDAO;
import com.questionpro.model.Student;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/studentLogin")
public class StudentLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()){

            response.sendRedirect(request.getContextPath()
                    + "/student/studentLogin.jsp?error=empty");
            return;
        }

        try{

            Student student = studentDAO.validateStudent(
                    email.trim(),
                    password.trim());

            if(student != null){

                HttpSession oldSession = request.getSession(false);

                if(oldSession != null){
                    oldSession.invalidate();
                }

                HttpSession session = request.getSession(true);

                session.setAttribute("student", student);

                session.setMaxInactiveInterval(30*60);

                response.sendRedirect(request.getContextPath()
                        + "/student/categorySelect.jsp");

            }else{

                response.sendRedirect(request.getContextPath()
                        + "/student/studentLogin.jsp?error=invalid");

            }

        }catch(Exception e){

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/student/studentLogin.jsp?error=server");

        }

    }

}