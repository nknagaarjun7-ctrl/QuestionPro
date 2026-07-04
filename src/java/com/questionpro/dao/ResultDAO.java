package com.questionpro.dao;

import com.questionpro.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultDAO {

    // Save Result
    public boolean saveResult(int studentId, int score, int total) {

        String sql = "INSERT INTO results (student_id, score, total, exam_date) VALUES (?, ?, ?, NOW())";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, score);
            ps.setInt(3, total);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Leaderboard
    public List<Map<String, Object>> getLeaderboard() {

        List<Map<String, Object>> leaderboard = new ArrayList<>();

        String sql =
                "SELECT s.name, r.score, r.total, r.exam_date " +
                "FROM results r " +
                "INNER JOIN students s ON r.student_id = s.id " +
                "ORDER BY r.score DESC, r.exam_date ASC " +
                "LIMIT 10";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                row.put("name", rs.getString("name"));
                row.put("score", rs.getInt("score"));
                row.put("total", rs.getInt("total"));
                row.put("examDate", rs.getTimestamp("exam_date"));

                leaderboard.add(row);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return leaderboard;
    }

    // Total Results Count
    public int getResultCount() {

        String sql = "SELECT COUNT(*) FROM results";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}