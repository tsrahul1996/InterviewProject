<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page session="false"%>
<html>
<head>
<title>Tweets</title>
</head>
<body>

	<h3 style="color: red;">Show all Tweets</h3>
	<ul>
		<c:forEach var="listValue" items="${tweets}">
			<li>${listValue.id}<span>${listValue.text}</span></li>
		</c:forEach>
	</ul>
</body>
</html>