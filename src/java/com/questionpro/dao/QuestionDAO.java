package com.questionpro.dao;

import com.questionpro.model.Question;
import com.questionpro.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {

    // Add Question
    public boolean addQuestion(Question q) {

        if (q == null || q.getQuestionText() == null || q.getQuestionText().trim().isEmpty()) {
            return false;
        }

        String sql = "INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, category) VALUES (?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, q.getQuestionText());
            ps.setString(2, q.getOptionA());
            ps.setString(3, q.getOptionB());
            ps.setString(4, q.getOptionC());
            ps.setString(5, q.getOptionD());
            ps.setString(6, q.getCorrectAnswer());
            ps.setString(7, q.getCategory());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get All Questions
    public List<Question> getAllQuestions() {

        List<Question> list = new ArrayList<>();

        String sql = "SELECT id, question_text, option_a, option_b, option_c, option_d, correct_answer, category FROM questions ORDER BY id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapQuestion(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Questions By Category
    public List<Question> getQuestionsByCategory(String category) {

        List<Question> list = new ArrayList<>();

        String sql = "SELECT id, question_text, option_a, option_b, option_c, option_d, correct_answer, category FROM questions WHERE LOWER(category)=LOWER(?) ORDER BY id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category.trim());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapQuestion(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Search Questions
    public List<Question> searchQuestions(String keyword) {

        List<Question> list = new ArrayList<>();

        if (keyword == null) {
            keyword = "";
        }

        String search = "%" + keyword.trim() + "%";

        String sql = "SELECT id, question_text, option_a, option_b, option_c, option_d, correct_answer, category FROM questions WHERE question_text LIKE ? OR category LIKE ? ORDER BY id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, search);
            ps.setString(2, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapQuestion(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Delete Question
    public boolean deleteQuestion(int id) {

        String sql = "DELETE FROM questions WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get Question By ID
    public Question getQuestionById(int id) {

        String sql = "SELECT id, question_text, option_a, option_b, option_c, option_d, correct_answer, category FROM questions WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapQuestion(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Update Question
    public boolean updateQuestion(Question q) {

        if (q == null) {
            return false;
        }

        String sql = "UPDATE questions SET question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_answer=?, category=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, q.getQuestionText());
            ps.setString(2, q.getOptionA());
            ps.setString(3, q.getOptionB());
            ps.setString(4, q.getOptionC());
            ps.setString(5, q.getOptionD());
            ps.setString(6, q.getCorrectAnswer());
            ps.setString(7, q.getCategory());
            ps.setInt(8, q.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get Question Count
    public int getQuestionCount() {

        String sql = "SELECT COUNT(*) FROM questions";

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

    // Get Student Count
    public int getStudentCount() {

        String sql = "SELECT COUNT(*) FROM students";

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

    // Get Result Count
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

    // Map ResultSet to Question Object
    private Question mapQuestion(ResultSet rs) throws SQLException {

        Question q = new Question();

        q.setId(rs.getInt("id"));
        q.setQuestionText(rs.getString("question_text"));
        q.setOptionA(rs.getString("option_a"));
        q.setOptionB(rs.getString("option_b"));
        q.setOptionC(rs.getString("option_c"));
        q.setOptionD(rs.getString("option_d"));
        q.setCorrectAnswer(rs.getString("correct_answer"));
        q.setCategory(rs.getString("category"));

        return q;
    }
}