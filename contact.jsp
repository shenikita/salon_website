<%@ page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String pnumber = request.getParameter("pnumber");
String address = request.getParameter("address");
String subject = request.getParameter("subject");
String message = request.getParameter("message");

Connection conn = null;
PreparedStatement pstmt = null;

try {
    String url = "jdbc:mysql://localhost:3306/salon"; // Updated database name
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    String sql = "INSERT INTO contact (name, email, pnumber, address, subject, message) VALUES (?, ?, ?, ?, ?, ?)"; // Updated table name
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, email);
    pstmt.setString(3, pnumber);
    pstmt.setString(4, address);
    pstmt.setString(5, subject);
    pstmt.setString(6, message);

    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
    	response.sendRedirect("contact.html");
        
    } else {
        out.println("Data insertion failed.");
    }

} catch (ClassNotFoundException e) {
    out.println("MySQL JDBC driver not found.");
    e.printStackTrace();
} catch (SQLException e) {
    out.println("Database error: " + e.getMessage());
    e.printStackTrace();
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>