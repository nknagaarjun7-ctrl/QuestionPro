package com.questionpro.controller;

import com.questionpro.dao.ResultDAO;
import com.questionpro.model.Student;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/saveResult")
public class ResultServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student/studentLogin.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        Integer score = (Integer) session.getAttribute("score");
        Integer total = (Integer) session.getAttribute("total");

        if (student == null || score == null || total == null) {
            response.sendRedirect(request.getContextPath() + "/student/studentLogin.jsp");
            return;
        }

        try {

            boolean status = resultDAO.saveResult(
                    student.getId(),
                    score,
                    total
            );

            if (status) {

                // Prevent duplicate result save
                session.removeAttribute("score");
                session.removeAttribute("total");
                session.removeAttribute("questions");
                session.removeAttribute("category");

                response.sendRedirect(request.getContextPath()
                        + "/student/result.jsp?saved=1");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/student/result.jsp?error=save");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/student/result.jsp?error=server");
        }
    }
}