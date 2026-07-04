package com.questionpro.controller;

import com.questionpro.dao.QuestionDAO;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteQuestion")
public class DeleteQuestionServlet extends HttpServlet {

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
            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?error=invalid");
            return;
        }

        try {

            int id = Integer.parseInt(idParam);

            boolean status = questionDAO.deleteQuestion(id);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/admin/viewQuestions.jsp?msg=deleted");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/admin/viewQuestions.jsp?error=failed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?error=invalid");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?error=server");
        }
    }
}