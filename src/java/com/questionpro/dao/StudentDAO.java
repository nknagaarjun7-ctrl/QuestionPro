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

    // ================= REGISTER =================
    public boolean registerStudent(Student s) {

        System.out.println("===== registerStudent() START =====");

        if (s == null) {
            System.out.println("Student object is NULL");
            return false;
        }

        System.out.println("Name : " + s.getName());
        System.out.println("Email: " + s.getEmail());
        System.out.println("Phone: " + s.getPhone());

        if (emailExists(s.getEmail())) {
            System.out.println("Email already exists");
            return false;
        }

        String sql =
                "INSERT INTO students(name,email,password,phone) VALUES(?,?,?,?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            String hash = BCrypt.hashpw(s.getPassword(), BCrypt.gensalt());

            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, hash);
            ps.setString(4, s.getPhone());

            int rows = ps.executeUpdate();

            System.out.println("Rows Inserted = " + rows);

            return rows > 0;

        } catch (SQLException e) {

            System.out.println("===== SQL ERROR =====");
            e.printStackTrace();

        } catch (Exception e) {

            System.out.println("===== UNKNOWN ERROR =====");
            e.printStackTrace();

        }

        return false;
    }

    // ================= LOGIN =================
    public Student validateStudent(String email, String password) {

        String sql = "SELECT * FROM students WHERE email=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

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

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= EMAIL EXISTS =================
    public boolean emailExists(String email) {

        String sql = "SELECT id FROM students WHERE email=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            boolean exists = rs.next();

            System.out.println("Email Exists = " + exists);

            return exists;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

    // ================= COUNT =================
    public int getStudentCount() {

        String sql = "SELECT COUNT(*) FROM students";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return 0;
    }

    // ================= ALL STUDENTS =================
    public List<Student> getAllStudents() {

        List<Student> list = new ArrayList<>();

        String sql =
                "SELECT id,name,email,phone FROM students ORDER BY id DESC";

        try (
                Connection con = DBConnection.getConnection();
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

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

}