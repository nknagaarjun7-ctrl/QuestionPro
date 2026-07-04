package com.questionpro.controller;

import com.questionpro.dao.QuestionDAO;
import com.questionpro.model.Question;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/searchQuestion")
public class SearchQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Admin Login Check
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/adminLogin.jsp");
            return;
        }

        String keyword = request.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }

        try {

            List<Question> questions;

            if (keyword.trim().isEmpty()) {
                questions = questionDAO.getAllQuestions();
            } else {
                questions = questionDAO.searchQuestions(keyword.trim());
            }

            request.setAttribute("questions", questions);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/admin/viewQuestions.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?error=server");
        }
    }
}