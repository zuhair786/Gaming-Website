import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  
import java.sql.*;  
    
public class display extends HttpServlet 
{    
     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException   
      {  
        doGet(request, response);  
      }
	  
     protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException 
      {   
		PrintWriter out=res.getWriter();
         try 
         {  
             Class.forName("com.mysql.jdbc.Driver"); 
			 Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/first_db","root","");	
			 PreparedStatement pstmt=null; 
             pstmt=con.prepareStatement("select password from login where email=?");  
		     pstmt.setString(1,req.getParameter("email"));
	
		     ResultSet rs=pstmt.executeQuery(); 
		     if(rs.next())
		     {
                 String pass = rs.getString("password");
				 req.setAttribute("password","Password is:"+pass);              
                 RequestDispatcher view = req.getRequestDispatcher("ForgetPassword.jsp");      
                 view.forward(req, res);
				 con.close();
				 return;
             } 
			 req.setAttribute("error", "Invalid Email");              
             RequestDispatcher view = req.getRequestDispatcher("ForgetPassword.jsp");      
             view.forward(req, res);	 
             con.close();  
            }  
             catch (Exception e) 
            {  
             out.println("Unable to fetch data");  
         }  
     }  
 }  