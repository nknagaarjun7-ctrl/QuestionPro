package com.questionpro.controller;

import com.questionpro.dao.QuestionDAO;
import com.questionpro.dao.ResultDAO;
import com.questionpro.model.Question;
import com.questionpro.model.Student;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/exam")
public class ExamServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final QuestionDAO questionDAO = new QuestionDAO();
    private final ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student/studentLogin.jsp");
            return;
        }

        String category = request.getParameter("category");

        if (category == null || category.trim().isEmpty()) {
            category = "all";
        }

        List<Question> questions;

        if ("all".equalsIgnoreCase(category)) {
            questions = questionDAO.getAllQuestions();
        } else {
            questions = questionDAO.getQuestionsByCategory(category.trim());
        }

        if (questions == null || questions.isEmpty()) {
            response.sendRedirect(request.getContextPath()
                    + "/student/categorySelect.jsp?error=noquestions");
            return;
        }

        session.setAttribute("category", category);
        request.setAttribute("questions", questions);

        request.getRequestDispatcher("/student/exam.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student/studentLogin.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");

        String category = (String) session.getAttribute("category");

        if (category == null) {
            category = "all";
        }

        List<Question> questions;

        if ("all".equalsIgnoreCase(category)) {
            questions = questionDAO.getAllQuestions();
        } else {
            questions = questionDAO.getQuestionsByCategory(category);
        }

        int score = 0;

        for (Question question : questions) {

            String selectedAnswer = request.getParameter("q" + question.getId());

            if (selectedAnswer != null &&
                    selectedAnswer.equals(question.getCorrectAnswer())) {

                score++;
            }
        }

        // Save Result in Database
        resultDAO.saveResult(student.getId(), score, questions.size());

        // Store values in Session
        session.setAttribute("score", score);
        session.setAttribute("total", questions.size());

        response.sendRedirect(request.getContextPath() + "/student/result.jsp");
    }
}