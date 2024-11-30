/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Files;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.FileUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Duyy
 */
@MultipartConfig
@WebServlet(name = "UploadController", urlPatterns = {"/UploadController"})
public class UploadController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + "uploads";
        System.out.println("uploadFilePath: " + uploadFilePath);
        File uploadDir = new File(uploadFilePath);
        System.out.println("uploadDir: " + uploadDir);
            
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        try{
            Part part = request.getPart("file");
            String excelFilePath = uploadDir+"/"+getFileName(part);
            part.write(excelFilePath);
            storeExcelData(excelFilePath);
            
            File[] allFiles = uploadDir.listFiles();
            System.out.println(allFiles);
            if (allFiles != null) {
                for (File file : allFiles) {
                    System.out.println(file);
                    if(file.delete()){
                        System.out.println("Delete file!!!!!!!!!");
                    }else{
                        System.out.println("Delete Error!!!!!!");
                    }
                }
            }
            response.sendRedirect("AdminPage.jsp");
            
        } catch(Exception e){
            response.sendRedirect("DiaryPage.jsp");
            return;
        }    
    }
    
    private void storeExcelData(String excelFilePath) throws FileNotFoundException, IOException{
        Files file = new Files();
        FileInputStream inputStream = new FileInputStream(excelFilePath);
        XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
        XSSFSheet sheet = workbook.getSheetAt(0);
        
        XSSFRow class_row = sheet.getRow(2);
        XSSFRow title_row = sheet.getRow(0);
        XSSFRow content_row = sheet.getRow(1);

        XSSFCell class_cell = class_row.getCell(1);
        XSSFCell title_cell = title_row.getCell(1);
        XSSFCell content_cell = content_row.getCell(1);

        String class_data = class_cell.getStringCellValue();
        String title_data = title_cell.getStringCellValue();
        String content_data = content_cell.getStringCellValue();
        
        file.storeLesson(class_data, title_data, content_data);
        
        int rows = sheet.getLastRowNum();
        for(int r = 4; r <= rows;r++){
            XSSFRow row = sheet.getRow(r);
            XSSFCell id_cell = row.getCell(0);
            XSSFCell comment_cell = row.getCell(2);
            
            int id_data = (int) id_cell.getNumericCellValue();
            String comment_data = comment_cell.getStringCellValue();
            file.storeComment(id_data, title_data, comment_data);
        }
        inputStream.close();
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        
        if(!contentDisposition.contains("filename=")){
            return null;
        }
        int beginIndex = contentDisposition.indexOf("filename=") + 10;
        int endIndex = contentDisposition.length() - 1;
        
        return contentDisposition.substring(beginIndex,endIndex);
    }
    

    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
