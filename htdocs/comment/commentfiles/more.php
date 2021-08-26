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

.comment-form-container {
	width:550px;
	padding: 20px;
	border-radius: 10px;
	margin-left:30%;
	background-image:url("../assets/images/commentbkg.png");
	background-position: left;
    background-size: cover;
}

.input-row {
	margin-bottom: 20px;
}

.input-field {
	width: 100%;
	border-radius: 20px;
	padding: 10px;
	border: #e0dfdf 1px solid;
}

input[type=button],input[type=reset]{
	padding: 10px 20px;
	background: #aaaaff;
	border: #1d1d1d 1px solid;
	color: #f0f0f0;
	font-size: 1em;
	width: 100px;
	border-radius: 15px;
    cursor:pointer;
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
	font-size:18px;
}

span.posted-by {
	color: #ff0000;
	font-size:2em;
	font-family:serif;
}

span.posted-at {
	color: #dddd00;
	font-size:1.8em;
	font-family:serif;
}

.comment-info {
	font-size: 0.8em;
	color:aaffaa;
}
.comment-text {
    margin: 10px 0px;
	color:00eeee;
}

.topicgame{
	color:red;
	font-size:18px;
	font-family:fantasy;
	text-transform:uppercase;
}

.btn-reply {
    font-size: 0.8em;
    text-decoration: underline;
    color: #dede00;
    cursor:pointer;
}
#comment-message {
    margin-left: 100px;
    color: #189a18;
    display: none;
}
</style>
<title>Comments</title>
<script src="jquery-3.2.1.min.js"></script>
</head>


<body>
    <h1 style="text-align:center">Comments</h1>
    <div class="comment-form-container">
        <form id="frm-comment">
            <div class="input-row">
                <input type="hidden" name="comment_id" id="commentId"
                    placeholder="Name" /> <input class="input-field"
                    type="text" name="name" id="name" placeholder="Name" />
            </div>
			<div class="input-row">
				<select name="topic" id="topic" class="input-field">
				  <option value="ageofempire">Age of Empire III</option>
				  <option value="witcher3">The Witcher 3: Wild Hunt</option>
				  <option value="forzahorizon4">Forza Horizon 4</option>
				  <option value="werewolf">Werewolf: The Apocalypse – Earthblood</option>
				</select>
            </div>
            <div class="input-row">
                <textarea class="input-field" type="text" rows=4 name="comment"
                    id="comment" placeholder="Add a Comment">  </textarea>
            </div>
            <div>
                <input type="button" class="btn-submit" id="submitButton"
                    value="Publish" />
				<input type="reset" name="Clear" value="Clear" class="btn-reset"/>
					
				<div id="comment-message">Comments Added Successfully!</div>
            </div>

        </form>
    </div>
    <div id="output"></div>
	
    <script>
            function postReply(commentId) {
                $('#commentId').val(commentId);
                $("#name").focus();
            }

            $("#submitButton").click(function () {
            	   $("#comment-message").css('display', 'none');
                var str = $("#frm-comment").serialize();

                $.ajax({
                    url: "comment-add.php",
                    data: str,
                    type: 'post',
                    success: function (response)
                    {
                        var result = eval('(' + response + ')');
                        if (response)
                        {
                        	$("#comment-message").css('display', 'inline-block');
                            $("#name").val("");
                            $("#comment").val("");
							$("#topic").val("");
                            $("#commentId").val("");
                     	   listComment();
                        } else
                        {
                            alert("Failed to add comments !");
                            return false;
                        }
                    }
                });
            });
            
            $(document).ready(function () {
            	   listComment();
            });

            function listComment() {
                $.post("comment-list.php",
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
                                    "<span class='commet-row-label'>for Game</span>  <span class='topicgame'>"+data[i]['Topic_game']+"</span> "+
									"<div class='comment-text'>" + data[i]['comment'] + "</div>"+
                                    "<div><a class='btn-reply' onClick='postReply(" + commentId + ")'>Reply</a></div>"+
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
                        " <div class='comment-info'><span class='commet-row-label'>from</span> <span class='posted-by'>" + data[i]['comment_sender_name'] + " </span> <span class='commet-row-label'>at</span>  <span class='posted-at'>" + data[i]['date'] + "</span></div>" + 
                        " <span class='commet-row-label'>for Game</span>  <span class='topicgame'>"+data[i]['Topic_game']+"</span> "+
						"<div class='comment-text'>" + data[i]['comment'] + "</div>"+
                        "<div><a class='btn-reply' onClick='postReply(" + data[i]['comment_id'] + ")'>Reply</a></div>"+
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