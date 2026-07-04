package com.questionpro.controller;

import com.questionpro.dao.QuestionDAO;
import com.questionpro.model.Question;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addQuestion")
public class AddQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check Admin Login
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/adminLogin.jsp");
            return;
        }

        String questionText = request.getParameter("questionText");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");
        String category = request.getParameter("category");

        // Input Validation
        if (questionText == null || questionText.trim().isEmpty()
                || optionA == null || optionA.trim().isEmpty()
                || optionB == null || optionB.trim().isEmpty()
                || optionC == null || optionC.trim().isEmpty()
                || optionD == null || optionD.trim().isEmpty()
                || correctAnswer == null || correctAnswer.trim().isEmpty()
                || category == null || category.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath()
                    + "/admin/addQuestion.jsp?error=empty");
            return;
        }

        Question question = new Question();

        question.setQuestionText(questionText.trim());
        question.setOptionA(optionA.trim());
        question.setOptionB(optionB.trim());
        question.setOptionC(optionC.trim());
        question.setOptionD(optionD.trim());
        question.setCorrectAnswer(correctAnswer.trim());
        question.setCategory(category.trim());

        try {

            boolean status = questionDAO.addQuestion(question);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/admin/addQuestion.jsp?success=1");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/admin/addQuestion.jsp?error=failed");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/admin/addQuestion.jsp?error=server");
        }
    }
}