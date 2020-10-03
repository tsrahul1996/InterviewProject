<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page import="java.io.*" %> 
<%@page import="java.util.*" %> 
<html>
	<head>
		<title>Twitter Fetch App</title>
		<link rel="stylesheet" href="bootstrap.min.css">
	</head>	
	<body>      
		<form method="post"  enctype="multipart/form-data" name="form" id="form"> 
		<div class="wrapper">
				<header class="main-head" >
				<div  align="center">
				</div>	
				<div class="heading" style="margin-top:.01em;margin-left: 29%;">Home</div>
				<div style="margin-top:.5em;" align="center">
				</div>	
				<div style="margin-top:.5em;" align="center">
				</div>
				</header>
				<article class="content">
					<div style= "margin:0 auto;margin-top: 3.5em;">
						
					<div class="grid-search-box rounded border uk-margin uk-card uk-card-hover" >
					<div class="div-header"><div class = "div-header-style my_rounded_corners" >Search Tweets</div></div>
						<div class="div-1" style="text-align:right;">
								<p>Search By : </p>
						</div>
						<div class="div-2">
							<select id= "criteria" class= "select-css" style= "margin: auto;" >

								<option value="NA" disabled="disabled" >Select search criteria</option>
								<option class="select-option" value="F">Followers</option>
								<option class="select-option" value="H" selected="selected">Hash Tag</option>
								<option class="select-option" value="N">Followers and Hash Tag</option>

							</select>
						</div>
						<div class="div-3">
							<input id= "criteria-value" type="text" placeholder="Search criteria">
						</div>
						<div class="div-4">
							  <a href="#" class="button"  onclick="javascript: retrieveSearchDetails();">Search</a>
						</div>						
					</div>
	 
					<div id="retrieve">
					</div>
					</div>
					<div class="footer"></div>	
				</article> 	
		</div>				
		</form>
	</body>
	<script>
	function retrieveSearchDetails()
	{
	var criteria = $("#criteria").val();
	var criteriaValue = $("#criteria-value").val();
	
	var screenName	= criteriaValue;
	var hashtag		= criteriaValue;
	if(criteria =="NA")
	{
		alert("Please select a criteria");
		$("#criteria").focus();
		return ;
	}

	$('#loading').css("display","block");
	$.ajaxSetup({ cache:false });
	var params	={
					'fetchType'		:criteria,
					'screenName'		:screenName,
					'hashtag'		:hashtag

				};	
	$.ajax({
			type	: "POST",
			url		: "twitter/home",
			data	: params,
			success:	function(show){
			var response = $.trim(show);
			$('#loading').css("display","none");
			$('#retrieve').css("display","block");
			$("#retrieve").html(response);
			},
			error: function(xhr,status,errorThrown){
			alert("No Search Details found !");
			} 
	});	
	
}

	</script>
	<style>
	
	
/* class applies to select element itself, not a wrapper element */
.select-css {
    font-size: 11px;
	font-family: 'Open Sans', sans-serif;
    font-weight: 600;
    color: #444;
    line-height: 1;
    padding: .6em 1.4em .5em .8em;
    width: 100%;
    max-width: 100%; /* useful when width is set to anything other than 100% */
    box-sizing: border-box;
    margin: 0;
    border: 1px solid #aaa;
    box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
    border-radius: .5em;
    -moz-appearance: none;
    -webkit-appearance: none;
    appearance: none;
    background-color: #fff;
    /* note: bg image below uses 2 urls. The first is an svg data uri for the arrow icon, and the second is the gradient. 
        for the icon, if you want to change the color, be sure to use `%23` instead of `#`, since it's a url. You can also swap in a different svg icon or an external image reference
        
    */
    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
      linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
    background-repeat: no-repeat, repeat;
    /* arrow icon position (1em from the right, 50% vertical) , then gradient position*/
    background-position: right .7em top 50%, 0 0;
    /* icon size, then gradient */
    background-size: .65em auto, 100%;
}
/* Hide arrow icon in IE browsers */
.select-css::-ms-expand {
    display: none;
}
/* Hover style */
.select-css:hover {
    border-color: #888;
}
/* Focus style */
.select-css:focus {
    border-color: #aaa;
    /* It'd be nice to use -webkit-focus-ring-color here but it doesn't work on box-shadow */
    box-shadow: 0 0 1px 3px rgba(182, 217, 253, .7);
    box-shadow: 0 0 0 3px -moz-mac-focusring;
    color: #222; 
    outline: none;
}
			
/* Set options to normal weight */
.select-css option {
    font-weight:normal;
}

/* Support for rtl text, explicit support for Arabic and Hebrew */
*[dir="rtl"] .select-css, :root:lang(ar) .select-css, :root:lang(iw) .select-css {
    background-position: left .7em top 50%, 0 0;
    padding: .6em .8em .5em 1.4em;
}

/* Disabled styles */
.select-css:disabled, .select-css[aria-disabled=true] {
    color: graytext;
    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22graytext%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
      linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
}

.select-css:disabled:hover, .select-css[aria-disabled=true] {
    border-color: #aaa;
}


body {
  margin: 2rem;
}
select:active, select:hover {
  outline: none
}

/* make it red instead (with with same width and style) */
select:active, select:hover {
  outline-color: red
}
.button {
    text-decoration: none !important;
}
/***************Button ***********************/
.button {
	 display: inline-block;
	 padding: 0.5rem 1.25rem;
	 border-radius: 10rem;
	 color: #fff;
	 text-transform: uppercase;
	 font-size: 1rem;
	 letter-spacing: 0.15rem;
	 transition: all 0.3s;
	 position: relative;
	 overflow: hidden;
	 z-index: 1;
}
 .button:after {
	 content: '';
	 position: absolute;
	 bottom: 0;
	 left: 0;
	 width: 100%;
	 height: 100%;
	 background-color: #0cf;
	 border-radius: 10rem;
	 z-index: -2;
}
 .button:before {
	 content: '';
	 position: absolute;
	 bottom: 0;
	 left: 0;
	 width: 0%;
	 height: 100%;
	 background-color: #008fb3;
	 transition: all 0.3s;
	 border-radius: 10rem;
	 z-index: -1;
}
 .button:hover {
	 color: #fff;
}
 .button:hover:before {
	 width: 100%;
}


 span {
	 display: block;
	 margin-top: 2rem;
	 font-size: 0.7rem;
	 color: #777;
}
 span a {
	 font-size: 0.7rem;
	 color: #999;
	 text-decoration: underline;
}

body{

background: linear-gradient(to bottom,  #feffff 0%,#edf7fc 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */

}


* {
  box-sizing: border-box;
}

.previewDivHeadingStyle{
margin: 0 auto;
    display: table;

}

.row{
	margin: 0 auto;
    display: table;
	margin-bottom:30px;
	margin-left:7px;

}

.row > .column {
  padding: 0 8px;

}

.row:after {
  content: "";
  display: table;
  clear: both;
  margin: 0 auto;
    display: table;
  
}

/* Create four equal columns that floats next to eachother */
.column {
  float: left;
  width: 50%;
}

/* The Modal (background) */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  padding-top: 100px;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: black;
}

/* Modal Content */
.modal-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 0;
  width: 90%;
  max-width: 1200px;
}

/* The Close Button */
.close {
  color: white;
  position: absolute;
  top: 10px;
  right: 25px;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #999;
  text-decoration: none;
  cursor: pointer;
}

/* Hide the slides by default */
.mySlides {
  display: none;
}

/* Next & previous buttons */
.prev,
.next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -50px;
  color: white;
  font-weight: bold;
  font-size: 20px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
  -webkit-user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover,
.next:hover {
  background-color: rgba(0, 0, 0, 0.8);
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* Caption text */
.caption-container {
  text-align: center;
  background-color: black;
  padding: 2px 16px;
  color: white;
}

img.demo {
  opacity: 0.6;
}

.active,
.demo:hover {
  opacity: 1;
}

img.hover-shadow {
  transition: 0.3s;
}

.hover-shadow:hover {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}


.scrollbar {
	padding:0px 0px 0px 0px;	
    background-color: #ffffff;   
}
.scrollbar :hover {
overflow-y: scroll;
}




.scrollbar::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
  border-radius: 5px;
  background-color: #F5F5F5;
}

.scrollbar::-webkit-scrollbar {
  width: 6px;
  background-color: #F5F5F5;
}

.scrollbar::-webkit-scrollbar-thumb {
  border-radius: 6px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
  background-color: #555;
}
	
.card {
  font-family: 'Open Sans', sans-serif;
  border-radius: 2px;
}
.card-1 {
  background-color:#ffffff
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
}
.card-2 {
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
}
.card-1:hover {
	
  box-shadow: 0 1px 3px rgba(0,0,0,0.25), 0 1px 1px rgba(0,0,0,0.22);
}
.card-2:hover {
  box-shadow: 0 2px 5px rgba(0,0,0,0.25), 0 5px 5px rgba(0,0,0,0.22);
  background: #F8F8F8;
}

.preview-btns{
  min-width: 50px;
  background-color:#1E90FF;
  color: #ffffff;
  text-align: center;
  font-size: 12px;
  cursor: pointer;
  font-family: 'Open Sans', sans-serif;
  padding:4px 4px 4px 4px ;
  margin: 0px auto;
  margin-right : 10%;
  text-decoration: none;
}

.upload-side{
  min-width: 50px;
  background-color: #5bb75b;
  color: #ffffff;
  text-align: center;
  font-size: 12px;
  cursor: pointer;
  font-family: 'Open Sans', sans-serif;
  padding:4px 4px 4px 4px ;
  margin: 0px auto;
  text-decoration: none;
}

.upload-btns{
  min-width: 50px;
  background-color: #5bb75b;
  color: #ffffff;
  text-align: center;
  font-size: 12px;
  cursor: pointer;
  font-family: 'Open Sans', sans-serif;
  padding:4px 4px 4px 4px ;
  margin-left:10%;
  text-decoration: none;
}

.registerNoticeTable caption{
	 font-family: 'Open Sans', sans-serif;
	 font-size:14px;
	 color:#FDFEFE;
	 background-color: #1B4F72;
}	
.registerNoticeTable{
	margin: 20px auto;
}
    #master td,
    #master th{
  
      padding: 2px 5px;
    }
.dragAndDrop{
		width:77em;
}
#dragandrophandler
{
	border:2px dotted #0B85A1;
	width:70%;
	height:8em;
	color:#92AAB0;
	text-align:center;
	vertical-align:middle;
	padding: 30px 0;
	
	margin:2% auto;
	
	font-size:200%;
}
.progressBar {
    width: 200px;
    height: 22px;
    border: 1px solid #ddd;
    border-radius: 5px; 
    overflow: hidden;
    display:inline-block;
    margin:0px 10px 5px 5px;
    vertical-align:top;
}
 
.progressBar div {
    height: 100%;
    color: #fff;
    text-align: center;
	float:left;
    line-height: 22px;	/* same as #progressBar height if we want text middle aligned */
    width: 0;
    background-color: #0ba1b5; border-radius: 3px; 
}
.statusbar
{
    border-top:1px solid #A9CCD1;
    min-height:25px;
   
    padding:10px 10px 0px 10px;
    vertical-align:top;
}
.statusbar:nth-child(odd)
{
	background:#EBEFF0;
}
.filename
{
	display:inline-block;
	vertical-align:top;
	width:200px;
	text-align: left;
}
.filesize
{
	display:inline-block;
	vertical-align:top;
	color:#30693D;
	width:200px;
	margin-left:10px;
	margin-right:5px;
}
.abort
{
	background-color:#A8352F;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;display:inline-block;
	color:#fff;
	font-family:arial;font-size:13px;font-weight:normal;
	padding:4px 15px;
	cursor:pointer;
	vertical-align:top
}
.fromDate,.toDate{
	font-family: 'Open Sans', sans-serif;
	margin-top:3em;
	margin-left:2.3em;
	height:.1em;
	width:18em;	
	margin: 20px auto;
}
.formTextStyle{
	height: 34px;
	width: 100%;
	text-align:left;
	padding:3px 13px 3px 6px;
	font-size:12px;
	font-family: 'Open Sans', sans-serif;
	background-color:#fff; 

	border-color:rgb(211,211,211);
}
.heading{
	margin-top:.2em;
	font-family: 'Open Sans', sans-serif;
	color:white;
	font-size:1.5em;
	font-size :2.5em;
}
.main-head {
	height:3.5em;
	grid-area: header;
	display: grid;
	background:  #3A68AB;
	grid-template-columns: 1fr 15fr .7fr .7fr;
	   
	-webkit-box-shadow: 0px 8px 11px -8px rgba(58,104,171,1);
	-moz-box-shadow: 0px 8px 11px -8px rgba(58,104,171,1);
	box-shadow: 0px 8px 11px -8px rgba(58,104,171,1);
  
}

.item1 { grid-area: previewDiv; }
.item2 { grid-area: uploadDiv; }
.innerDiv{
	display: grid;
	grid-template-columns: 1fr 1fr;
	    grid-template-areas: 
    "previewDiv uploadDiv"
}



.content{
  display: grid;
  grid-template-rows: 1fr 0.1fr;
  grid-template-areas: "dragandrophandler" "footer" ;
}
.footer { 
  color: black;
  grid-area: footer; 
}
.dragandrophandler { grid-area: dragandrophandler; }

.retrieve {
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 1fr;
  grid-template-areas: ".";
  grid-area: retrieve;
}


@media all and (-ms-high-contrast:none) {
  .content{
    display: -ms-grid;
    -ms-grid-columns: 1fr;
    -ms-grid-rows: 1fr 0.1fr;
  }

  .dragandrophandler {
    -ms-grid-row: 1;
    -ms-grid-row-span: 1;
    -ms-grid-column: 1;
    -ms-grid-column-span: 1;
  }


}

.preview { 
color:blue;
padding:10px;
border-top:thin solid;
border-color:rgb(211,211,211);
grid-area: preview; 
}

.directory { grid-area: directory; }



.wrapper {
  font-family: 'Open Sans', sans-serif;
  display: grid;
  grid-template-areas: 
    "header"
    "content";
}

@media (min-width: 500px) {
  .wrapper {

    grid-template-areas: 
    "header"
    "content";
 }
}

@media (min-width: 1000px) {
  .wrapper {
    grid-template-areas: 
      "header"
      "content"
   }
}


}


	
.my_rounded_corners{
    border: 1px solid #ccc;

    /* each value for each corner clockwise starting from top left */
    -webkit-border-radius: 0 0 20px 0;
            border-radius: 0 0 20px 0;
			
			
}


	.rounded {
  border-radius: 4px;
}

.border {
  box-shadow: rgba(9, 30, 66, 0.31) 0px 0px 1px 0px, rgba(9, 30, 66, 0.25) 0px 1px 1px 0px;
}
	
input[type="text"] {
  width: 100%;
  border: 2px solid #aaa;
  border-radius: 4px;
  outline: none;
  box-sizing: border-box;
  transition: 0.3s;
}

input[type="text"]:focus {
  border-color: dodgerBlue;
  box-shadow: 0 0 8px 0 dodgerBlue;
}

.inputWithIcon input[type="text"] {
  padding-left: 40px;
}

.inputWithIcon {
  position: relative;
}

.inputWithIcon i {
  position: absolute;
  left: 0;
  top: 8px;
  padding: 9px 8px;
  color: #aaa;
  transition: 0.3s;
}

.inputWithIcon input[type="text"]:focus + i {
  color: dodgerBlue;
}

.inputWithIcon.inputIconBg i {
  background-color: #aaa;
  color: #fff;
  padding: 9px 4px;
  border-radius: 4px 0 0 4px;
}

.inputWithIcon.inputIconBg input[type="text"]:focus + i {
  color: #fff;
  background-color: dodgerBlue;
}



	
.grid-search-box {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-rows: 1fr 1fr ;  
  gap: 0em 1em;
  padding: 0em 0em 3em 0em ;	

  grid-template-areas:
  "div-header	div-header	div-header	div-header"
  "div-1	div-2	div-3	div-4";

}
.div-header-style{
  text-align: center;
  background: #101357;
  color: white;
  font-size: 20px;	
  padding: 0em 1em 0em 1em ;	
}

.div-header {
	
  padding: 0em 0em 2em 0em ;	


}

.div-1 { grid-area: div-1; }

.div-2 { grid-area: div-2; }

.div-3 { grid-area: div-3; }

.div-4 { grid-area: div-4; }
	
	.select-css {
    font-size: 11px;
	font-family: 'Open Sans', sans-serif;
    font-weight: 600;
    color: #444;
    line-height: 1;
    padding: .6em 1.4em .5em .8em;
    width: 100%;
    max-width: 100%; /* useful when width is set to anything other than 100% */
    box-sizing: border-box;
    margin: 0;
    border: 1px solid #aaa;
    box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
    border-radius: .5em;
    -moz-appearance: none;
    -webkit-appearance: none;
    appearance: none;
    background-color: #fff;
    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
      linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
    background-repeat: no-repeat, repeat;
    background-position: right .7em top 50%, 0 0;
    background-size: .65em auto, 100%;
}

	#LoadDivMain {
   width: 100%;
   height: 100%;
   top: 0;
   left: 0;
   position: fixed;
   display: block;
   opacity: 0.7;
   background-color: #fff;
   z-index: 99;
   text-align: center;
}

#LoadDivMain-image {
  position: absolute;
  top: 100px;
  left: 45%;
  z-index: 100;
}



.loader,
.loader:after {
  display:none;
  border-radius:50%;
  width: 7em;
  height: 7em;
}
.loader {
  margin: 0px auto;
  font-size: 10px;
  position: relative;
  text-indent: -9999em;
  border-top: .5em solid rgba(23,0,236, 0.2);
  border-right: .5em solid rgba(23,0,236, 0.2);
  border-bottom: .5em solid rgba(23,0,236, 0.2);
  border-left: .5em solid #1700ec;
  -webkit-transform: translateZ(0);
  -ms-transform: translateZ(0);
  transform: translateZ(0);
  -webkit-animation: load8 1.1s infinite linear;
  animation: load8 1.1s infinite linear;
}
@-webkit-keyframes load8 {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes load8 {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}


	</style>
</html>
