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
    <link rel="stylesheet" href="${ cl }/source/css/custom.css">
	<title>whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="max-w-7xl mx-auto p-4">
	    <h1 class="text-2xl font-bold mb-6">구독한 채널</h1>
	    <c:if test="${ empty mySubscribers }"><h2 class="text-lg text-gray-500">구독한 채널이 없습니다.</h2></c:if>
	    
	    <c:if test="${ not empty mySubscribers }">
	        <c:forEach var="msl" items="${ mySubscribers }">
	            <div class="w-full p-4 flex items-center gap-6 bg-white rounded-lg relative">
				    <div class="shrink-0">
				        <c:if test="${ not empty msl.profileImgPath }">
				        	<a href="${ cl }/channel/${ msl.creatorName }">
					            <img src="${ fuck += msl.profileImgPath }" 
					                 alt="${ msl.creatorName }'s profile" 
					                 class="w-20 h-20 rounded-full object-cover border-2 border-gray-200"
					                 onerror="this.src='default-profile.jpg'"/>
							</a>
				        </c:if>
				    </div>
				    <div class="flex flex-col gap-2">
				        <h1 class="text-2xl font-bold text-gray-800"><a href="${ cl }/channel/${ msl.creatorName }">${ msl.creatorName }</a></h1>
				        <p class="text-gray-600">구독자 ${ msl.subscribe }명</p>
				        <p class="text-sm text-gray-500">${ msl.bio }</p>
				    </div>
				    <div class="absolute top-4 right-4">
				    	<form action="${ cl }/deleteSubscri" method="post" autocomplete="off">
				    		<input type="hidden" name="subscriberId" id="subscriberId" value="${ msl.creatorId }" readonly readonly>
				    		<button type="submit" class="btn px-4 py-2 bg-red-500 hover:bg-red-300 rounded-lg text-white">구독 취소</button>
				    	</form>
				    </div>
				</div>
	        </c:forEach>
	    </c:if>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>