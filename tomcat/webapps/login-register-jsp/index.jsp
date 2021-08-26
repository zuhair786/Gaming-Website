<%@ page import="java.sql.*" %>  

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); 
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/first_db","root","");	
	
	 if(session.getAttribute("login")!=null) 
       {
		String dbemail=session.getAttribute("login").toString();
		int id;
		PreparedStatement pstmt=null; 
        pstmt=con.prepareStatement("select * from login where email=?");  
		pstmt.setString(1,dbemail);
	
		ResultSet rs=pstmt.executeQuery(); 
		if(rs.next())
		{
			id=rs.getInt("id");
			response.sendRedirect("http://localhost:9999/login-register-jsp/users.jsp?id="+id); 
		}
	   }
	
	if(request.getParameter("btn_login")!=null) 
	{
		String dbemail,dbpassword;
		
		String email,password;
		int id;
		
		email=request.getParameter("txt_email"); 
		password=request.getParameter("txt_password");
		
		PreparedStatement pstmt=null; 
		
		pstmt=con.prepareStatement("select * from login where email=? AND password=?");  
		pstmt.setString(1,email);
		pstmt.setString(2,password);
		
		
		ResultSet rs=pstmt.executeQuery(); 
		if(rs.next())
		{
			dbemail=rs.getString("email");
			dbpassword=rs.getString("password");
			id=rs.getInt("id");
			if(email.equals(dbemail) && password.equals(dbpassword))
			{				
				session.setAttribute("login",dbemail); 
				response.sendRedirect("http://localhost:9999/login-register-jsp/users.jsp?id="+id); 
			}
		}
		else
		{
			request.setAttribute("errorMsg","invalid email or password"); 
		}
		
		con.close(); 
	}
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Game Warrier Login</title>

	<link rel="stylesheet" href="css/basic.css">
	<link rel="stylesheet" href="css/register.css">
	
	<script>
		
		function validate()
		{
			var email = document.myform.txt_email;
			var password = document.myform.txt_password;
				
			if (email.value == null || email.value == "") 
				window.alert("please enter email ?"); 
				email.style.background = '#f08080';
				email.focus();
				return false;
			}
			if (password.value == null || password.value == "") 
			{
				window.alert("please enter password ?"); 
				password.style.background = '#f08080'; 
				password.focus();
				return false;
			}
		}
			
	</script>
	
</head>
<body style="background-image:url('css/assets/Images/loginwall1.jpg');background-size:cover;background-position:;">
     <div class="logindev">
        <form class="form-register" method="post" name="myform" onsubmit="return validate();">
            <div class="form-register-with-email">
                <div class="form-white-background">
				    <div class="form-title-home">
					   <h3>To home page</h3>
					</div>
                    <div class="form-title-row">
                        <h1>Login</h1>
                    </div>
					
					<p style="color:red">				   		
					<%
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); 
					}
					%>
					</p>
				   
				   </br>
                    <div class="form-row">
                        <label>
                            <span>Email</span>
                            <input type="text" name="txt_email" id="email" required autofocus placeholder="Enter email">
                        </label>
                    </div>

                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="password" required placeholder="Enter password">
                        </label>
                    </div>
					<input type="submit" name="btn_login" value="Login">                   
                </div>
				<a href="register.jsp" class="form-log-in-with-existing">You Don't have an account? <b> Register here </b></a>
            </div>
        </form>
	</div>
</body>
</html>
