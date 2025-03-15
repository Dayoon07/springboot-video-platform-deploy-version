<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${ cl }/source/img/videoPlayer-icon.png" type="image/x-icon">
	<title>whynot</title>
</head>
<body>
	
	<h1 style="text-align: center; margin-top: 30px;">${ success } <br>3초 후 메인 페이지로 돌아갑니다</h1>
	
	<script>
		setTimeout(() => {
			location.href = "${ cl }/";
		}, 3000);
	</script>	
	
</body>
</html>