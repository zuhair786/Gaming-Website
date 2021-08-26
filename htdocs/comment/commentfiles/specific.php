<html>

<head>
<style>
body {
	font-family: Arial;
	background-image:url("../assets/images/commentbkg1.jpg");
	background-position: left;
    background-size: cover;
	background-repeat:repeat-y;
}

ul {
	list-style-type: none;
}

.comment-row {
	border-bottom: #ff0000 1px solid;
	margin-bottom: 15px;
	padding: 15px;
}

.outer-comment {
	padding: 20px;
	border: #dedddd 1px solid;
	width:550px;
	margin-left:30%;
	background-image:url("../assets/images/commentbkg2.jpg");
	background-position: left;
    background-size: cover;
}

span.commet-row-label {
	font-style: italic;
}

span.posted-by {
	color: #ff0000;
	font-size:2em;
}

.comment-info {
	font-size: 0.8em;
	color:aaffaa;
}
.comment-text {
    margin: 10px 0px;
	color:00eeee;
}
.btn-reply {
    font-size: 0.8em;
    text-decoration: underline;
    color: #dede00;
    cursor:pointer;
}
</style>
<title>Comments</title>
<script src="jquery-3.2.1.min.js"></script>


<body>
    <h1 style="text-align:center">Comments</h1>
	<div id="output"></div>
	
    <script>
            function getParameters() {
                 let urlString =window.location.href;
                 let paramString = urlString.split('?')[1];             
                 let queryString = new URLSearchParams(paramString);         
                 for (let pair of queryString.entries()) {
                      return pair[1];
                }
            }
			
	        function postReply(){
					window.location.href = "http://localhost:9999/login-register-jsp/index.jsp";
			}
			
            $(document).ready(function () {
				   let topic=getParameters();
				   listComment(topic);
            });

            function listComment(topic) {
				console.log(topic);
                $.post("comment-list1.php",{topic_game:topic},
                        function (data) {
                            var data = JSON.parse(data);
                            
                            var comments = "";
                            var replies = "";
                            var item = "";
                            var parent = -1;
                            var results = new Array();

                            var list = $("<ul class='outer-comment'>");
                            var item = $("<li>").html(comments);

                            for (var i = 0; (i < data.length); i++)
                            {
                                var commentId = data[i]['comment_id'];
                                parent = data[i]['parent_comment_id'];

                                if (parent == "0")
                                {
                                    comments = "<div class='comment-row'>"+
                                    "<div class='comment-info'><span class='commet-row-label'>from</span> <span class='posted-by'>" + data[i]['comment_sender_name'] + " </span> <span class='commet-row-label'>at</span> <span class='posted-at'>" + data[i]['date'] + "</span></div>" + 
                                    "<div class='comment-text'>" + data[i]['comment'] + "</div>"+
                                    "<div><a class='btn-reply' onClick='postReply()'>Reply</a></div>"+
                                    "</div>";

                                    var item = $("<li>").html(comments);
                                    list.append(item);
                                    var reply_list = $('<ul>');
                                    item.append(reply_list);
                                    listReplies(commentId, data, reply_list);
                                }
                            }
                            $("#output").html(list);
                        });
            }

            function listReplies(commentId, data, list) {
                for (var i = 0; (i < data.length); i++)
                {
                    if (commentId == data[i].parent_comment_id)
                    {
                        var comments = "<div class='comment-row'>"+
                        " <div class='comment-info'><span class='commet-row-label'>from</span> <span class='posted-by'>" + data[i]['comment_sender_name'] + " </span> <span class='commet-row-label'>at</span> <span class='posted-at'>" + data[i]['date'] + "</span></div>" + 
                        "<div class='comment-text'>" + data[i]['comment'] + "</div>"+
                        "<div><a class='btn-reply' onClick='postReply()'>Reply</a></div>"+
                        "</div>";
                        var item = $("<li>").html(comments);
                        var reply_list = $('<ul>');
                        list.append(item);
                        item.append(reply_list);
                        listReplies(data[i].comment_id, data, reply_list);
                    }
                }
            }
        </script>
</body>

</html>