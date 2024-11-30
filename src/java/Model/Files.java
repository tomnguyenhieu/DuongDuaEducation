/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import com.mysql.cj.protocol.Resultset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Duyy
 */
public class Files {
    private Connection connect;
    public Files(){
        this.connect = Connector.getConnection();
    }
    
    
    
    public boolean storeComment(int student_id, String title, String comment) {
        String sql = "INSERT INTO comments("
            + "student_id, lesson_id, comment)"
            + " VALUES(?,?,?)";
        PreparedStatement ps;
        try {
            ps = connect.prepareStatement(sql);
            ps.setInt(1, student_id);
            ps.setInt(2, findLessonByTitle(title));
            ps.setString(3, comment);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("storeComment error!");
            return false;
        }
    }
    
    public boolean storeLesson(String className, String title, String content){
        String sql = "INSERT INTO lessons("
            + "class_id, title, content)"
            + " VALUES(?,?,?)";
        PreparedStatement ps;
        try {
            ps = connect.prepareStatement(sql);
            ps.setInt(1, findClassByName(className));
            ps.setString(2, title);
            ps.setString(3, content);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("storeLesson error!");
            return false;
        }
    }
    
    public int findLessonByTitle(String title){
        String sql = "SELECT * FROM lessons WHERE title = '"+title+"'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int idLesson = 0;
            while(rs.next()){
                idLesson = rs.getInt("id");
            } 
            return idLesson;
        } catch (Exception e) {
            System.out.println(e);
            return 0;
        }
    }
    
    public int findClassByName(String className){
        String sql = "SELECT * FROM classes WHERE name = '" + className + "'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int idClass = 0;
            while(rs.next()){
                idClass = rs.getInt("id");
            }
            return idClass;
        } catch (Exception e) {
            System.out.println(e);
            return 0;
        }
    }
}
