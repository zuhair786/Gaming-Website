<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<link rel="stylesheet" href="css/styles.css">
<title>Forget Password</title>  
</head>   
<body style="background-image:url('css/assets/Images/valhalla.jpg');background-size:100% 150%;background-position:;background-repeat:no-repeat;">
     <div class="logindev">
        <form class="form-register" method="post" action="display1">
            <div class="form-register-with-email">
                <div class="form-white-background">
                    <div class="form-title-row">
                        <h1>Forget Password</h1>
                    </div>
					
					<p style="color:red">				   		
					    ${requestScope["error"]}
					</p>
				   
				   </br>
                    <div class="form-row">
                        <label>
                            <span>Email</span>
                            <input type="email" name="email" placeholder="Enter email">
                        </label>
                    </div>
					<input type="submit" name="btn_login" value="Submit"> 
					<p style="color:blue;top:50px;"><b>${requestScope["password"]}</b></p>
                </div>
				<a href="http://localhost:9999/login-register-jsp/index.jsp" class="form-log-in-with-existing"><b>Sign Up</b></a>
            </div>
        </form>
	</div>
</body>
</html>  