package com.questionpro.controller;

import com.questionpro.dao.StudentDAO;
import com.questionpro.model.Student;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/viewStudents")
public class StudentListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("admin")==null){

            response.sendRedirect(
                    request.getContextPath()+"/admin/adminLogin.jsp");

            return;
        }

        List<Student> students = studentDAO.getAllStudents();

        request.setAttribute("students", students);

        request.getRequestDispatcher("/admin/viewStudents.jsp")
                .forward(request,response);

    }

}