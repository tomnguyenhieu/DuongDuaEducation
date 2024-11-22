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
public class Accounts {
    private Connection connect;
    
    public Accounts(){
        this.connect = Connector.getConnection();
    }
    
    public ResultSet login(String email, String password) {
        String sql = "SELECT * FROM accounts WHERE email = '"+email+"' AND password = '"+password+"'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
    
}
