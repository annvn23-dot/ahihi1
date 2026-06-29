/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.managerpark.dao;

import java.sql.Connection;


public class TestDB {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            System.out.println("KẾT NỐI THÀNH CÔNG!");
            con.close();
        } catch (Exception e) {
            System.out.println("KẾT NỐI THẤT BẠI!");
            e.printStackTrace();
        }
    }
}