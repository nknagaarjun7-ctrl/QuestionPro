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

        System.out.println("========================================");
        System.out.println("StudentRegistrationServlet doPost() START");
        System.out.println("========================================");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        System.out.println("Name     : " + name);
        System.out.println("Email    : " + email);
        System.out.println("Phone    : " + phone);
        System.out.println("Password : " + password);

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            System.out.println("Validation Failed");

            response.sendRedirect(request.getContextPath()
                    + "/student/studentRegister.jsp?error=empty");
            return;
        }

        System.out.println("Validation Passed");

        if (studentDAO.emailExists(email.trim())) {

            System.out.println("Email Already Exists");

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

            System.out.println("Calling registerStudent()...");

            boolean success = studentDAO.registerStudent(student);

            System.out.println("registerStudent() Returned = " + success);

            if (success) {

                System.out.println("Registration SUCCESS");

                response.sendRedirect(request.getContextPath()
                        + "/student/studentLogin.jsp?msg=registered");

            } else {

                System.out.println("Registration FAILED");

                response.sendRedirect(request.getContextPath()
                        + "/student/studentRegister.jsp?error=failed");
            }

        } catch (Exception e) {

            System.out.println("EXCEPTION OCCURRED");

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/student/studentRegister.jsp?error=server");
        }

        System.out.println("========================================");
        System.out.println("StudentRegistrationServlet doPost() END");
        System.out.println("========================================");
    }
}