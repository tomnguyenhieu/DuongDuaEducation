/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author tomng
 */
public class Connector {
    public static Connection getConnection() {
        Connection connect = null;

        try {
          // Class.forName("com.mysql.jdbc.Driver");
          Class.forName("com.mysql.cj.jdbc.Driver");
          connect = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/duongduaeducation",
              "root",
              "");

          System.out.println("Database connected.");
          return connect;

        } catch (Exception e) {
          // e.printStackTrace();
          return connect;
        }
    }
}
