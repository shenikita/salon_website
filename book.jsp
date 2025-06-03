<%@ page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String pnumber = request.getParameter("pnumber");
String date = request.getParameter("date");
String time = request.getParameter("time");
String gender = request.getParameter("gender");
String email = request.getParameter("email");
String services = request.getParameter("services");

Connection conn = null;
PreparedStatement pstmt = null;

try {
    String url = "jdbc:mysql://localhost:3306/salon"; // Updated database name
    String dbUser = "root";
    String dbPassword = "root";

    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
    conn = DriverManager.getConnection(url, dbUser, dbPassword);

    String sql = "INSERT INTO appointment (name, pnumber, date, time, gender, email, services) VALUES (?, ?, ?, ?, ?, ?, ?)"; // Updated table name
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, pnumber);
    pstmt.setString(3, date);
    pstmt.setString(4, time);
    pstmt.setString(5, gender);
    pstmt.setString(6, email);
    pstmt.setString(7, services);

    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
    	response.sendRedirect("book.html");
    	
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