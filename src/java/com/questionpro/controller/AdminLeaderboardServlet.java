package com.questionpro.controller;

import com.questionpro.dao.ResultDAO;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLeaderboard")
public class AdminLeaderboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ResultDAO resultDAO = new ResultDAO();

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

        List<Map<String,Object>> leaderboard =
                resultDAO.getLeaderboard();

        request.setAttribute("leaderboard", leaderboard);

        request.getRequestDispatcher("/admin/leaderboard.jsp")
                .forward(request,response);

    }

}