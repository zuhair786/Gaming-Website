<%@ page import="java.sql.*" %>  

<%
String recently_played="";
String recently_download="";
String fullname="";
String contacturl="http://localhost:9999/login-register-jsp/contact.jsp?id="+request.getParameter("id");
String listurl="http://localhost:9999/login-register-jsp/cart.jsp?id="+request.getParameter("id");
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
			   recently_played=rs1.getString("recently_played");
			   recently_download=rs1.getString("recently_download");
			   
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

<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, viewport-fit=cover">
	<title></title>
	<link href="css1/slides.min.css" rel="stylesheet" type="text/css">
	<link href="css1/styles.css" rel="stylesheet" type="text/css">
	<script src="jquery/jquery-3.2.1.min.js" type="text/javascript"></script>
	<script src="js/slides.min.js" type="text/javascript"></script>
	<link rel="stylesheet" as="font" href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,600,700|Material+Icons"/>
</head>
<body class="slides chain simplifiedMobile animated">
		
<!-- SVG Library -->
<svg xmlns="http://www.w3.org/2000/svg" style="display:none">
  
  
  <!-- social -->
  <symbol id="facebook" viewBox="0 0 24 24"><path d="M24 1.3v21.3c0 .7-.6 1.3-1.3 1.3h-6.1v-9.3h3.1l.5-3.6h-3.6v-2.2c0-1.1.3-1.8 1.8-1.8h1.9v-3.2c-.3 0-1.5-.1-2.8-.1-2.8 0-4.7 1.7-4.7 4.8v2.7h-3.1v3.6h3.1v9.2h-11.5c-.7 0-1.3-.6-1.3-1.3v-21.4c0-.7.6-1.3 1.3-1.3h21.3c.8 0 1.4.6 1.4 1.3z"/></symbol>  
  <symbol id="googlePlus" viewBox="0 1 24 24"><path d="M7.8 13.5h4.6c-.6 2-2.5 3.4-4.6 3.4-2.7 0-4.9-2.2-4.9-4.9s2.2-4.9 4.9-4.9c1.1 0 2.1.3 3 1l1.8-2.4c-1.4-1.1-3-1.6-4.8-1.6-4.3 0-7.9 3.5-7.9 7.9s3.5 7.9 7.9 7.9 7.9-3.5 7.9-7.9v-1.5h-7.9v3zM21.7 11v-2.2h-2v2.2h-2.2v2h2.2v2.2h2v-2.2h2.2v-2z"/></symbol> 
  <symbol id="instagram" viewBox="0 0 20 20"><circle cx="10" cy="10" r="3.3"/><path d="M13,0H7C2.2,0,0,2.2,0,7v6c0,4.8,2.1,7,7,7h6c4.8,0,7-2.2,7-7V7C20,2.2,17.9,0,13,0z M10,15.1c-2.8,0-5.1-2.3-5.1-5.1 S7.2,4.9,10,4.9s5.1,2.3,5.1,5.1S12.8,15.1,10,15.1z M15.3,5.9c-0.7,0-1.2-0.5-1.2-1.2c0-0.7,0.5-1.2,1.2-1.2s1.2,0.5,1.2,1.2 C16.5,5.3,16,5.9,15.3,5.9z"/></symbol>  
  <symbol id="twitter" viewBox="0 1 24 23"><path d="M21.5 7.6v.6c0 6.6-5 14.1-14 14.1-2.8 0-5.4-.8-7.6-2.2l1.2.1c2.3 0 4.4-.8 6.1-2.1-2.2 0-4-1.5-4.6-3.4.3.1.6.1.9.1.5 0 .9-.1 1.3-.2-2.1-.6-3.8-2.6-3.8-5 .7.4 1.4.6 2.2.6-1.3-.9-2.2-2.4-2.2-4.1 0-.9.2-1.8.7-2.5 2.4 3 6.1 5 10.2 5.2-.1-.4-.1-.7-.1-1.1 0-2.7 2.2-5 4.9-5 1.4 0 2.7.6 3.6 1.6 1-.3 2.1-.7 3-1.3-.4 1.2-1.1 2.1-2.2 2.7 1-.1 1.9-.4 2.8-.8-.6 1.1-1.4 2-2.4 2.7z"/></symbol>  
</svg>

<!-- Navigation -->
<nav class="side pole">
  <div class="navigation">
    <ul></ul>
  </div>
</nav>

<!-- Slide 1 (#10) -->
<section class="slide fade-6 kenBurns">
  <div class="content">
  <header>
  <div class="flex">
                <div class="logo">
                    <a href="#"><img src="assets/img/logo.png" alt="Game Warrior Logo" /></a>
                </div>
                <nav>
                    <button id="nav-toggle" class="hamburger-menu">
                        <span class="strip"></span>
                        <span class="strip"></span>
                        <span class="strip"></span>
                    </button>
                    <ul id="nav-menu-container">
                        <li><a href="http://localhost/Blog/blog.html" target="_blank">Blog</a></li>
                        <li><a href=<%=listurl%>>Shopping</a></li>
						<li><a href=<%=contacturl%>>Contact</a></li>
                    </ul>
                </nav>
				
				<a id="username" style="color:white;font-size:20px;margin-top:7px" value><%out.print(fullname);%></a>
				<a onclick="logout()" id="login-register-button">Logout</a>
            </div>
	</header>
	
	<div class="container">
    <div class="wrap">
    <div class="fix-10-12 toCenter">
          <h1 class="ae-1" id="slidetwoh">Recently Downloaded/Recently Checked</h1>
          <p class="ae-2"><span class="opacity-8" id="slidetwop"></span></p>
        </div>
        <div class="fix-12-12 margin-top-3">
          <ul class="flex fixedSpaces later left">
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <div class="button rounded empty margin-bottom-2 ae-3"><img class="wide" src="assets/img/godfall.jpg" alt=""/></div>
              <h3 class="ae-4" id="slidetwogone">GodFall</h3>
              <div class="ae-5"><p class="tiny opacity-6" id="slidetwodeone">You play as Orin, the last of the Valorien Knights and a fallen king, 
                 Betrayed by his brother Macros, Orin has to marshal his strength and 
				 find a lot of loot to defeat his brother and his generals.</p></div>
            </li>
	</div>
	</div>
	</div>
  </div>
  <div class="background" style="background-image:url(assets/img/background/back1.jpg)"></div>
</section>

<!-- Slide 2 (#75) -->
<section class="slide fade-6 kenBurns">
  <div class="content">
    <div class="container">
      <div class="wrap">

        <div class="fix-10-12 toCenter">
          <h1 class="ae-1" id="slidetwoh">Games for you(Available)</h1>
          <p class="ae-2"><span class="opacity-8" id="slidetwop"></span></p>
        </div>
        <div class="fix-12-12 margin-top-3">
          <ul class="flex fixedSpaces later left">
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <div class="button rounded empty margin-bottom-2 ae-3" data-popup-id="90-2"><img class="wide" src="assets/img/godfall.jpg" alt="Image Thumbnail"/></div>
              <h3 class="ae-4" id="slidetwogone">GodFall</h3>
              <div class="ae-5"><p class="tiny opacity-6" id="slidetwodeone">You play as Orin, the last of the Valorien Knights and a fallen king, 
                 Betrayed by his brother Macros, Orin has to marshal his strength and 
				 find a lot of loot to defeat his brother and his generals.</p></div>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-4"><img class="wide" src="assets/img/horizon4.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-5" id="slidetwogtwo">Forza Horizon 4</h3>
              <div class="ae-6"><p class="tiny opacity-6">The plot of Horizon 4 goes like this: You're some race driver who does quite well in a couple of races, apparently competing against a group of elderly people driving vehicles that explode if they go over 25mph.</p></div>
            </li>
			<li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-4"><img class="wide" src="assets/img/tombraider.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-5" id="slidetwogtwo">Tomb Raider</h3>
              <div class="ae-6"><p class="tiny opacity-6">The plot of Horizon 4 goes like this: You're some race driver who does quite well in a couple of races, apparently competing against a group of elderly people driving vehicles that explode if they go over 25mph.</p></div>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-5"><img class="wide" src="assets/img/aoe.jpeg" alt="Image Thumbnail"/></a>
              <h3 class="ae-6" id="slidetwogthree">Age of Empire III</h3>
              <div class="ae-7"><p class="tiny opacity-6">The game portrays the European colonization of the Americas, between approximately 1492 and 1876 AD. There are fourteen civilizations to play within the game.</p></div>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/ai-war.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-7" id="slidetwogfour">AI War</h3>
              <div class="ae-8"><p class="tiny opacity-6">Up to eight players battle a pair of rampant artificial intelligences once used by warring human superpowers, in the aftermath of the AI's near complete victory over humanity.</p></div>
            </li>
			<li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/commandos-2.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-7" id="slidetwogfour">Commandos 2</h3>
              <div class="ae-8"><p class="tiny opacity-6">Men of Courage is a tactical action/strategy game set against the backdrop of World War II. Take control of an elite group of commandos who must venture deep into enemy territory and utilize their combined expertise to complete a series of mission-based objectives.</p></div>
            </li>
			<li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/HitchHiker.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-7" id="slidetwogfour">Hitch Hiker</h3>
              <div class="ae-8"><p class="tiny opacity-6">Hitchhiker is a mystery game set along lost highways, where your goal is to solve the puzzle of your own backstory. As a hitchhiker with no memory or destination, you catch a series of rides across a strange and beautiful landscape.</p></div>
            </li>
			<li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/stellaris-nemesis.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-7" id="slidetwogfour">Stellaris Nemesis</h3>
              <div class="ae-8"><p class="tiny opacity-6">Nemesis is an expansion to Stellaris in which you will be able to determine the fate of a destabilizing galaxy. Adding espionage tools, a path to power as the Galactic Custodian - or the Menace option to become the crisis - Nemesis gives you the most powerful tools ever available in Stellaris.</p></div>
            </li>
			<li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/Gearsofwar.jpg" alt="Image Thumbnail"/></a>
              <h3 class="ae-7" id="slidetwogfour">Gears Of War</h3>
              <div class="ae-8"><p class="tiny opacity-6">Gears of War is a third-person shooter video game created by Epic Games. Gears of War was ported to PC as one of the many 'Games for Windows'. </p></div>
            </li>
          </ul>
        </div>

      </div>
    </div>
  </div>
  <div class="background" style="background-image:url(assets/img/background/back2.jpg)"></div>
</section>

<!-- Slide 3 (#90) -->
<section class="slide fade-6 kenBurns">
  <div class="content">
    <div class="container">
      <div class="wrap">

        <div class="fix-10-12 toCenter">
          <h1 class="ae-1">Top Games</h1>
          <p class="ae-2"><span class="opacity-8">High Computational Games.Requires minimum 8Gb RAM and 50GB ROM.</span></p>
        </div>
        <div class="fix-12-12 margin-top-3">
          <ul class="flex fixedSpaces later left">
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/reddead2(1).jpg" alt="Red Dead Redemption II"/></a>
              <h3 class="ae-7">Red Dead Redemption II</h3>
              <div class="ae-8"><p class="tiny opacity-6">CPU: Intel Core i5-2500K / AMD FX-6300.<br>RAM: 8GB.<br>Vedio Card: Nvidia GeForce GTX 770 2GB / AMD Radeon R9 280 3GB.</p></div>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty  margin-bottom-2 ae-6"><img class="wide" src="assets/img/legion.jpg" alt="Watch Dogs Legion"/></a>
              <h3 class="ae-7">Watch Dogs: Legion</h3>
              <div class="ae-8"><p class="tiny opacity-6">CPU: Intel Core i5-4460 or AMD Ryzen 5 1400 290X.<br>RAM: 8GB (Dual-channel setup).<br>Video card:4GB, NVIDIA GeForce GTX 970, NVIDIA GeForce GTX 1650, or AMD Radeon R9 290X.</p></div>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-5"><img class="wide" src="assets/img/horizonforbidden.jpg" alt="Horizon Forbidden West"/></a>
              <h3 class="ae-7">Horizon Forbidden West</h3>
              <div class="ae-8"><p class="tiny opacity-6">CPU: Intel Core i5-2500K 3.3GHz / AMD FX-8320.<br>RAM: 8 GB.<br>Vedio Card: 4GB, AMD Radeon RX 570 4GB or NVIDIA GeForce GTX 970.</p></div>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phone-1-1">
              <a href="#" class="button rounded empty margin-bottom-2 ae-6"><img class="wide" src="assets/img/dyinglight2.jpg" alt="Dying Light 2"/></a>
              <h3 class="ae-7">Dying Light 2</h3>
              <div class="ae-8"><p class="tiny opacity-6">CPU: Intel Core i5-2500K or AMD FX-6350 or better.<br>RAM: 8 GB.<br>VIDEO CARD: 2GB, NVIDIA GeForce GTX 770 or AMD Radeon R9 280 or better.</p></div>
            </li>
          </ul>
        </div>

      </div>
    </div>
  </div>
  <div class="background" style="background-image:url(assets/img/background/back3.jpg)"></div>
</section>

<!-- Slide 4 (#74) -->
<section class="slide fade-6 kenBurns">
  <div class="content">
    <div class="container">
      <div class="wrap">
      
        <div class="fix-10-12 toCenter">
          <h1 class="ae-1">Trending Games</h1>
          <p class="ae-2"><span class="opacity-8">Among multiple games present,this four is top trending games in my opinion</span></p>
        </div>
        <div class="fix-12-12">  
          <ul class="grid grid-74 later equal margin-top-5">
            <li class="col-3-12 col-tablet-1-2 col-phablet-1-1 ae-3 fromCenter">
              <a href="#" class="box-74">
                <div class="thumbnail-74">
                  <img src="assets/img/ratchetandclank.jpg" class="wide" alt="Thumbnail"/>
                </div>
                <div class="name-74 equalElement table wide">
                  <div class="cell left top">
                    <h3 class="">Ratchet And Clank</h3>
                    <p class="tiny opacity-6 cropBottom">Ratchet & Clank: Rift Apart is a 2021 third-person shooter platform game developed by Insomniac Games and published by Sony Interactive Entertainment for the PlayStation 5.</p>
                  </div>
                </div>
              </a>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phablet-1-1 ae-4 fromCenter">
              <a href="#" class="box-74">
                <div class="thumbnail-74">
                  <img src="assets/img/residentevilvillage.jpg" class="wide" alt="Thumbnail"/>
                </div>
                <div class="name-74 equalElement table wide">
                  <div class="cell left top">
                    <h3 class="">Resident Evil : Village</h3>
                    <p class="tiny opacity-6 cropBottom">Resident Evil Village is a first-person survival horror game developed and published by Capcom. ... The game was announced at the PlayStation 5 reveal event in June 2020 and was released on May 7, 2021.</p>
                  </div>
                </div>
              </a>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phablet-1-1 ae-5 fromCenter">
              <a href="#" class="box-74">
                <div class="thumbnail-74">
                  <img src="assets/img/fornite.jpg" class="wide" alt="Thumbnail"/>
                </div>
                <div class="name-74 equalElement table wide">
                  <div class="cell left top">
                    <h3 class="">Fornite</h3>
                    <p class="tiny opacity-6 cropBottom">Fortnite is an online video game developed by Epic Games and released in 2017. It is available in three distinct game mode versions.</p>
                  </div>
                </div>
              </a>
            </li>
            <li class="col-3-12 col-tablet-1-2 col-phablet-1-1 ae-5 fromCenter">
              <a href="#" class="box-74">
                <div class="thumbnail-74">
                  <img src="assets/img/cyberpunk.jpg" class="wide" alt="Thumbnail"/>
                </div>
                <div class="name-74 equalElement table wide">
                  <div class="cell left top">
                    <h3 class="">Cyberpunk 2077</h3>
                    <p class="tiny opacity-6 cropBottom">Cyberpunk 2077 is an open-world, action-adventure story set in Night City, a megalopolis obsessed with power, glamour and body modification.</p>
                  </div>
                </div>
              </a>
            </li>
          </ul>
        </div>
                
      </div>
    </div>
  </div>
  <div class="background" style="background-image:url(assets/img/background/back4.jpg)"></div>
</section>

<!-- Slide 5  -->
<section class="slide fade-6 kenBurns">
  <div class="content">
    <div class="container">
      <div class="wrap">
      
        <div class="fix-10-12">
          <h1 class="fix-9-12 huge ae-1">Giving ontime updates on all games and gaming streams.</h1>

          <ul class="grid equal fixedSpaces margin-top-3">
            <li class="col-4-12 ae-3">
              <div class="fix-3-12 equalElement">
                <h6 class="uppercase opacity-4 margin-top-3 margin-bottom-2">Mohamed Zuhair</h6>
                <p class="tiny"><a class="opacity-8" href="#">Thiagarajar College of Engineering,Madurai.</a></p>
              </div>
              <div class="fix-3-12 equalElement">
                <h6 class="uppercase opacity-4 margin-top-3 margin-bottom-2">Owner Info</h6>
                <p class="tiny"><a class="opacity-8" href="#">Thiagarajar College of Engineering,Madurai.</a></p>
              </div>
            </li>
            <li class="col-4-12 ae-4">
              <div class="fix-3-12 equalElement">
                <h6 class="uppercase opacity-4 margin-top-3 margin-bottom-2">Generatal Engquires</h6>
                <p class="tiny"><a class="opacity-8" href="mailto:#"></a>mohamedzuhairka@gmail.com</p>
              </div>
              <div class="fix-3-12 equalElement">
                <h6 class="uppercase opacity-4 margin-top-3 margin-bottom-2">Questions</h6>
                <p class="tiny"><a class="opacity-8" href="mailto:#">mohamedzuhairka@gmail.com</a></p>
              </div>
            </li>
            <li class="col-4-12 ae-5">
              <div class="fix-3-12 equalElement">
                <h6 class="uppercase opacity-4 margin-top-3 margin-bottom-2">Our blog</h6>
                <p class="tiny"><a class="opacity-8" href="#">Game Warriors:How to use</a></p>
              </div>
              <div class="fix-3-12 equalElement">
                <h6 class="uppercase opacity-4 margin-top-3 margin-bottom-2">Stay in touch</h6>
                <ul class="social-circles">
                  <li><a class="social-googlePlus" href="#"><svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#googlePlus"></use></svg></a></li>
                  <li><a class="social-instagram" href="#"><svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#instagram"></use></svg></a></li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
        
      </div>
    </div>
  </div>
  <div class="background" style="background-image:url(assets/img/background/back5.jpg)"></div>
</section>

<!-- Panel Bottom #13 -->
<nav class="panel bottom lastSlideOnly">
  <div class="sections">
    <div class="center">
      <ul class="menu crop">
        <li><a href="http://facebook.com/designmodo" target="_blank"><svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#facebook"></use></svg></a></li>
        <li><a href="http://twitter.com/designmodo" target="_blank"><svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#twitter"></use></svg></a></li>
        <li><a href="http://instagram.com/designmodo" target="_blank"><svg><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#instagram"></use></svg></a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="progress-bar blue"></div>
		
</body>
<script>    
			function logout(){
				     window.location.replace("http://localhost:9999/login-register-jsp/logout.jsp");
			}		
        </script>
</html>
