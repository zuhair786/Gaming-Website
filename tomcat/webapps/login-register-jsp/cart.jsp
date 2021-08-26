<%@ page import="java.sql.*" %> 
<%@page import="bean.GameList"%> 
<%@page import="java.util.*"%> 


<%
String fullname="";
ArrayList<GameList> arr=new ArrayList<GameList>();
ArrayList<GameList> arr1=new ArrayList<GameList>();
String contacturl="http://localhost:9999/login-register-jsp/contact.jsp?id="+request.getParameter("id");
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
		Statement stm1=con.createStatement();
	    ResultSet rs2=stm1.executeQuery("select * from lists where category='Hot Sale';");
	    while(rs2.next()){
			String name=rs2.getString(2);
			String img=rs2.getString(3);
			String price=rs2.getString(4);
			String dis=rs2.getString(5);
			String desc=rs2.getString(6);
			GameList g=new GameList(name,img,price,dis,desc,"Hot Sale");
			arr.add(g);
	    }
	    ResultSet rs3=stm1.executeQuery("select * from lists where category!='Hot Sale';");
		while(rs3.next()){
			GameList g=new GameList(rs3.getString(2),rs3.getString(3),rs3.getString(4),rs3.getString(5),rs3.getString(6),rs3.getString(7));
			arr1.add(g);
	    }
	   }
	   else{
		  response.sendRedirect("http://localhost:9999/login-register-jsp/index.jsp");
	   }
	   con.close();
}
catch(Exception e)
{
	out.println(e);
}
%> 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>InfoGame:Shop Item </title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">		
		<link href="css1/styles.css" rel="stylesheet" />
	    <script src="jquery/jquery-3.2.1.min.js" type="text/javascript"></script>
    </head>
    <body>
      <header>
				<div class="flex">
        <div class="logo">
            <a href="#"><img src="css/assets/Images/logo.png" alt="Game Warrior Logo" /></a>
        </div>
        <nav>
            <ul id="nav-menu-container">
                <li><a href=<%=userurl%>>Home</a></li>
                <li><a href="http://localhost/Blog/blog.html" target="_blank">Blog</a></li>
                <li><a href="#" style="color:yellow;">Shopping</a></li>
                <li><a href=<%=contacturl%>>Contact</a></li>
            </ul>
        </nav>
		<a id="username" style="color:white;font-size:20px;margin-top:7px" value><%out.print(fullname);%></a>
    </div>
	</header>
        <% for(GameList g1:arr){ %>
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src=<%=g1.getImgsrc()%> alt="..." /></div>
                    <div class="col-md-6">
                        <div class="badge bg-dark text-white position-absolute"><%=g1.getCategory()%></div>
                        <h1 class="display-5 fw-bolder"><%out.print(g1.getName());%></h1>
                        <div class="fs-5 mb-5">
                            <h2 style="text-decoration:line-through;">Rs.<%=g1.getPrice()%></h2>
                            <h2>Rs.<%=g1.getDisc()%></h2>
                        </div>
                        <p class="lead"><%=g1.getDescription()%></p>
                        <div class="d-flex">
                            <input class="form-control text-center me-3" id="inputQuantity" type="num" value="1" style="max-width: 3rem" />
                            <button class="btn btn-outline-dark flex-shrink-0" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                Add to cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
		<% } %>
		
        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Related Posts</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                 <% for(GameList g1:arr1){ %>
				   <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
							<div class="badge bg-dark text-white position-absolute"><%=g1.getCategory()%></div>
                            <img class="card-img-top mb-5 mb-md-0" src=<%=g1.getImgsrc()%> alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder"><%=g1.getName()%></h5>
                                    <!-- Product price-->
									<div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    
                                    <h2 style="text-decoration:line-through;">Rs.<%=g1.getPrice()%></h2>
									<h2>Rs.<%=g1.getDisc()%></h2>

                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View</a></div>
                            </div>
                        </div>
						</div>
					 <%}%>
                </div>
			</div>
        </section>
        <!-- Footer-->
        <footer>
        <div class="flex">
        <small>Copyright &copy; 2021 All rights reserved | This Website is made with <span class="footer-heart">&#9829;</span> by <a href="https://colorlib.com" target="_blank">by Mohamed Zuhair</a>.</small>
        </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
