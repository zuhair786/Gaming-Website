<%@ page import="java.sql.*" %>  

<%
String fullname="";
String carturl="http://localhost:9999/login-register-jsp/cart.jsp?id="+request.getParameter("id");
String userurl="http://localhost:9999/login-register-jsp/users.jsp?id="+request.getParameter("id");
int urlid=-1;
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
			urlid=Integer.parseInt(request.getParameter("id"));
			if(id!=urlid){
			  response.sendRedirect("http://localhost:9999/login-register-jsp/error.jsp");
			}
			else{
			//String recently_played,recently_download,fullname;
			pstmt=con.prepareStatement("SELECT * FROM users_data where id=?");
			pstmt.setInt(1,urlid);
			ResultSet rs1=pstmt.executeQuery(); 
			if(rs1.next()){
			   fullname=rs1.getString("firstname")+" "+rs1.getString("lastname");
		  }
		 }
		}
	   }
	   else{
		  response.sendRedirect("http://localhost:9999/login-register-jsp/index.jsp");
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
        <title>Contact</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/contact.css" rel="Stylesheet" type="text/css" />
    </head>
<body>
  <style>
  .comments-item h5 a b{
    color: #00FFFF;
	font-size:0.8em;
    margin-left:20%;
  }
  </style>
  <header>
    <div class="flex">
        <div class="logo">
            <a href="#"><img src="css/assets/Images/logo.png" alt="Game Warrior Logo" /></a>
        </div>
        <nav>
            <ul id="nav-menu-container">
                <li><a href=<%=userurl%>>Home</a></li>
                <li><a href="http://localhost/Blog/blog.html" target="_blank">Blog</a></li>
                <li><a href=<%=carturl%>>Shopping</a></li>
                <li><a href="#" style="color:yellow;">Contact</a></li>
            </ul>
        </nav>
		<a id="username" style="color:white;font-size:20px;margin-top:7px" value><%out.print(fullname);%></a>
    </div>
</header>
<main>
  <section id="cover_image">
    <div id="details">
      <h1>Game Warrier</h1>
      <p>published on February 2021</p>
      <p>by <b>Mohamed Zuhair K A</b></p>
      <p>of Computer Science And Engineering.</p>
      <p><b>Thiagarajar College of Engineering,Madurai.</b></p>
      <p><i>This website was created to deliver the latest news<br/>
        on games and upcoming games previews and reviews <br/>
        of recently release games are published by <u>us</u>.</i></p>
    </div>
	<div id="feedback">
	</div>
    <div id="posts-comments">
    <div class="posts-comments-box">
        <h3>Top Comments</h3>
        <div class="comments-item">
            <img src="https://onclickwebdesign.com/wp-content/uploads/person_2-350x350.jpg" />
            <div>
                <p><span class="author">James Smith</span> <span>on</span> This website was so informative.I like it.</p>
                <h5>February 28,2021</h5>
            </div>
        </div>

        <div class="comments-item">
            <img src="https://onclickwebdesign.com/wp-content/uploads/person_4-350x350.jpg" />
            <div>
                <p><span class="author">Albert Christian</span> <span>on</span> They are giving latest news about games.</p>
                <h5>March 12,2021</h5>
            </div>
        </div>

        <div class="comments-item">
            <img src="https://onclickwebdesign.com/wp-content/uploads/person_5-350x350.jpg" />
            <div>
                <p><span class="author">Lyon James</span> <span>on</span> Awesome information about games.This website is so early updating news.</p>
                <h5>March 11,2021</h5>
            </div>
        </div>

        <div class="comments-item">
            <img src="https://onclickwebdesign.com/wp-content/uploads/person_7-350x350.jpg" />
            <div>
                <p><span class="author">Richard</span> <span>on</span> Not bad. </p>
                <h5>March 10, 2021   <a href="http://localhost/comment/commentfiles/more.php"><b>More >>></b></a></h5>
            </div>
        </div>
    </div>
  </div>
  </section>
</main>
<footer>
    <div class="flex">
        <small>Copyright &copy; 2021 All rights reserved | This Website is made with <span class="footer-heart">&#9829;</span> by <a href="https://colorlib.com" target="_blank">by Mohamed Zuhair</a>.</small>
    </div>
</footer>
</body>
<script>
  function check(){
			      var txt;
                  if (confirm("Are you sure to exit?")) {
                     window.location.replace("http://localhost:9999/login-register-jsp/logout1.jsp");
                  }
            }
</script>
</html>
