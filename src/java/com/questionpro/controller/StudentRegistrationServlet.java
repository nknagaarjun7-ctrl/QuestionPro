package com.questionpro.controller;

import com.questionpro.dao.StudentDAO;
import com.questionpro.model.Student;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/studentRegister")
public class StudentRegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        // Validation
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath()
                    + "/student/studentRegister.jsp?error=empty");
            return;
        }

        // Duplicate Email Check
        if (studentDAO.emailExists(email.trim())) {

            response.sendRedirect(request.getContextPath()
                    + "/student/studentRegister.jsp?error=email");
            return;
        }

        Student student = new Student();
        student.setName(name.trim());
        student.setEmail(email.trim());
        student.setPassword(password.trim());
        student.setPhone(phone == null ? "" : phone.trim());

        try {

            boolean success = studentDAO.registerStudent(student);

            if (success) {

                response.sendRedirect(request.getContextPath()
                        + "/student/studentLogin.jsp?msg=registered");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/student/studentRegister.jsp?error=failed");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/student/studentRegister.jsp?error=server");
        }
    }
}