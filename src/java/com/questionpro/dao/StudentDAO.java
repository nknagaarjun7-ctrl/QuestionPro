package com.questionpro.dao;

import com.questionpro.model.Student;
import com.questionpro.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class StudentDAO {

    // Register Student
    public boolean registerStudent(Student s) {

        if (s == null
                || s.getName() == null || s.getName().trim().isEmpty()
                || s.getEmail() == null || s.getEmail().trim().isEmpty()
                || s.getPassword() == null || s.getPassword().trim().isEmpty()) {
            return false;
        }

        if (emailExists(s.getEmail().trim())) {
            return false;
        }

        String sql = "INSERT INTO students(name,email,password,phone) VALUES(?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String hash = BCrypt.hashpw(s.getPassword().trim(), BCrypt.gensalt());

            ps.setString(1, s.getName().trim());
            ps.setString(2, s.getEmail().trim());
            ps.setString(3, hash);
            ps.setString(4, s.getPhone());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Login
    public Student validateStudent(String email, String password) {

        String sql = "SELECT * FROM students WHERE email=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String dbPassword = rs.getString("password");

                    if (BCrypt.checkpw(password, dbPassword)) {

                        Student s = new Student();

                        s.setId(rs.getInt("id"));
                        s.setName(rs.getString("name"));
                        s.setEmail(rs.getString("email"));
                        s.setPhone(rs.getString("phone"));
                        s.setPassword(dbPassword);

                        return s;
                    }
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Email Exists
    public boolean emailExists(String email) {

        String sql = "SELECT id FROM students WHERE email=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                return rs.next();

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Student Count
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

    // Get All Students
    public List<Student> getAllStudents() {

        List<Student> list = new ArrayList<>();

        String sql = "SELECT id,name,email,phone FROM students ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Student s = new Student();

                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));

                list.add(s);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}