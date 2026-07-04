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

@WebServlet("/editQuestion")
public class EditQuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check Admin Login
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/adminLogin.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/viewQuestions.jsp?error=invalid");
            return;
        }

        try {

            int id = Integer.parseInt(idParam);

            Question question = questionDAO.getQuestionById(id);

            if (question == null) {
                response.sendRedirect(request.getContextPath() + "/admin/viewQuestions.jsp?error=notfound");
                return;
            }

            request.setAttribute("question", question);
            request.getRequestDispatcher("/admin/editQuestion.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(request.getContextPath() + "/admin/viewQuestions.jsp?error=invalid");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath() + "/admin/viewQuestions.jsp?error=server");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check Admin Login
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/adminLogin.jsp");
            return;
        }

        try {

            Question question = new Question();

            question.setId(Integer.parseInt(request.getParameter("id")));
            question.setQuestionText(request.getParameter("questionText").trim());
            question.setOptionA(request.getParameter("optionA").trim());
            question.setOptionB(request.getParameter("optionB").trim());
            question.setOptionC(request.getParameter("optionC").trim());
            question.setOptionD(request.getParameter("optionD").trim());
            question.setCorrectAnswer(request.getParameter("correctAnswer").trim());
            question.setCategory(request.getParameter("category").trim());

            boolean status = questionDAO.updateQuestion(question);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/admin/viewQuestions.jsp?msg=updated");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/admin/editQuestion.jsp?error=failed");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?error=server");
        }
    }
}