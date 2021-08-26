<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) 
{
	response.sendRedirect("");
}
%>


<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); 
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/first_db","root",""); 
	
	if(request.getParameter("btn_register")!=null) //check register button click event not null
	{
		String firstname,lastname,email,password;
		int id;
		
		firstname=request.getParameter("txt_firstname"); //txt_firstname
		lastname=request.getParameter("txt_lastname"); //txt_lastname
		email=request.getParameter("txt_email"); //txt_email
		password=request.getParameter("txt_password");//txt_password
				
		PreparedStatement pstmt=null; 
		
		pstmt=con.prepareStatement("insert into login(firstname,lastname,email,password) values(?,?,?,?)"); 
		pstmt.setString(1,firstname);
		pstmt.setString(2,lastname);
		pstmt.setString(3,email);
		pstmt.setString(4,password);
		
		PreparedStatement pstmt1=null; 
		
		pstmt1=con.prepareStatement("insert into users_data(id,firstname,lastname,recently_played,recently_download) values(?,?,?,?,?)"); 
		pstmt1.setInt(1,0);
		pstmt1.setString(2,firstname);
		pstmt1.setString(3,lastname);
		pstmt1.setString(4,null);
		pstmt1.setString(5,null);
		
		pstmt.executeUpdate(); 
		pstmt1.executeUpdate();
		
		PreparedStatement pstmt2=null;
		
		pstmt2=con.prepareStatement("select * from login where email=? AND password=?");  
		pstmt2.setString(1,email);
		pstmt2.setString(2,password);
		
		PreparedStatement pstmt3=null;
		
		ResultSet rs=pstmt2.executeQuery(); 
		if(rs.next())
		{	
			id=rs.getInt("id");
			pstmt3=con.prepareStatement("UPDATE users_data SET id=? WHERE firstname=? AND lastname=?");  
		    pstmt3.setInt(1,id);
		    pstmt3.setString(2,firstname);
	        pstmt3.setString(3,lastname);
		}
		else
		{
			request.setAttribute("errorMsg","Unknown Error"); 
		}
		
	
		
		pstmt3.executeUpdate();
		
		request.setAttribute("successMsg","Register Successfully...! Please login"); 

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
		
	<title>Game Warrier Register</title>

	<link rel="stylesheet" href="css/basic.css">
	<link rel="stylesheet" href="css/register.css">
	<!-- javascript for registeration form validation-->
	<script>	
	
		function validate()
		{
			var first_name= /^[a-z A-Z]+$/; 
			var last_name= /^[a-z A-Z]+$/; 
			var email_valid= /^[\w\d\.]+\@[a-zA-Z\.]+\.[A-Za-z]{1,4}$/; 
			var password_valid=/^[A-Z a-z 0-9 !@#$%&*()<>]{6,12}$/; 
			
			var fname = document.getElementById("fname"); 
            var lname = document.getElementById("lname"); 
            var email = document.getElementById("email"); 
            var password = document.getElementById("password"); 
			
			if(!first_name.test(fname.value) || fname.value=='') 
            {
				alert("Enter Firstname Alphabet Only....!");
                fname.focus();
                fname.style.background = '#f08080';
                return false;                    
            }
			if(!last_name.test(lname.value) || lname.value=='') 
            {
				alert("Enter Lastname Alphabet Only....!");
                lname.focus();
                lname.style.background = '#f08080';
                return false;                    
            }
			if(!email_valid.test(email.value) || email.value=='') 
            {
				alert("Enter Valid Email....!");
                email.focus();
                email.style.background = '#f08080';
                return false;                    
            }
			if(!password_valid.test(password.value) || password.value=='') 
            {
				alert("Password Must Be 6 to 12 and allowed !@#$%&*()<> character");
                password.focus();
                password.style.background = '#f08080';
                return false;                    
            }
		}
		
	</script>	
	<style>
	
	
	</style>

</head>

<body style="background-image:url('css/assets/Images/registerwall1.jpg');background-size:cover;">
    <div class="registerdev">
        <form class="form-register" method="post" onsubmit="return validate();">
            <div class="form-register-with-email">
                <div class="form-white-background">
                    <div class="form-title-row">
                        <h1>Register</h1>
                    </div>				   
					<p style="color:green">				   		
					<%
					if(request.getAttribute("successMsg")!=null)
					{
						out.println(request.getAttribute("successMsg")); 
					}
					%>
					</p>
				   
				   </br>
				   
                    <div class="form-row">
                        <label>
                            <span>Firstname</span>
                            <input type="text" name="txt_firstname" id="fname" autofocus placeholder="Enter Firstname">
                        </label>
                    </div>
					<div class="form-row">
                        <label>
                            <span>Lastname</span>
                            <input type="text" name="txt_lastname" id="lname" required placeholder="Enter Lastname">
                        </label>
                    </div>

                    <div class="form-row">
                        <label>
                            <span>Email</span>
                            <input type="text" name="txt_email" id="email" required placeholder="Enter Email">
                        </label>
                    </div>

                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="password" required pattern="[0-9a-zA-Z_]{8,15}" placeholder="Enter Password">
                        </label>
                    </div>

					<input type="submit" name="btn_register" value="Register">
					
                </div>
				
                <a href="index.jsp" class="form-log-in-with-existing">Already have an account? <b> Login here </b></a>

            </div>

        </form>

    </div>

</body>

</html>
