package com.questionpro.controller;

import com.questionpro.dao.QuestionDAO;
import com.questionpro.model.Question;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/uploadCSV")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class CSVUploadServlet extends HttpServlet {

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

        Part filePart = request.getPart("csvFile");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/uploadCSV.jsp?error=nofile");
            return;
        }

        int successCount = 0;

        try (InputStream inputStream = filePart.getInputStream();
             BufferedReader reader = new BufferedReader(
                     new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {

            String line;

            // Skip Header
            reader.readLine();

            while ((line = reader.readLine()) != null) {

                if (line.trim().isEmpty()) {
                    continue;
                }

                String[] data = line.split(",");

                if (data.length != 7) {
                    continue;
                }

                Question question = new Question();

                question.setQuestionText(data[0].trim());
                question.setOptionA(data[1].trim());
                question.setOptionB(data[2].trim());
                question.setOptionC(data[3].trim());
                question.setOptionD(data[4].trim());
                question.setCorrectAnswer(data[5].trim());
                question.setCategory(data[6].trim());

                if (questionDAO.addQuestion(question)) {
                    successCount++;
                }
            }

            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?uploaded=" + successCount);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/admin/viewQuestions.jsp?error=upload");
        }
    }
}