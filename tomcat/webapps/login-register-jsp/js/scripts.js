function check(){
            if (confirm("Are you sure to exit?")) 
			{
					 window.location.replace("http://localhost:9999/login-register-jsp/logout1.jsp");
            }
}
function logout()
{
	window.location.replace("http://localhost:9999/login-register-jsp/logout.jsp");
}