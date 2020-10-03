<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tweet Fetch Application</title>
</head>
<body>
    <h3 style="color: red;">Get Tweets</h3>
    <div id="home">
        <form:form action="localhost:8090/twitter/fetchTweets"
            method="post" modelAttribute="emp">
            <p>
                <label>Enter Criteria</label>
                 <input type="text" name="searchTag" value="" placeholder = "Search" /> 
                 <input type="SUBMIT" value="" style="width:20%"  placeholder = "Search"/>
                 </p>
        </form:form>
    </div>
</body>
</html>