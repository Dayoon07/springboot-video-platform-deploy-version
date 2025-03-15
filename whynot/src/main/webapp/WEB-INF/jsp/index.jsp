<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
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
	    <div id="videoContainer" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
	        <c:forEach var="video" items="${ allVideo }" varStatus="vs">
	        	<c:if test="${ vs.index < 100 }">
		            <div class="video-item flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
		                <div class="relative">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ video.videoUrl }">
		                            <img src="${ fuck += video.imgPath }" class="w-full h-full object-cover" loading="lazy">
		                        </a>
		                    </div>
		                    <span class="absolute bottom-2 right-2 bg-black text-white text-xs px-2 py-1 rounded">${ video.videoLen }</span>
		                </div>
		                <div class="flex gap-2">
		                    <a href="${ cl }/channel/${ video.creator }">
		                        <img src="${ fuck += video.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
		                    </a>
		                    <div class="flex-1 min-w-0">
		                        <a href="${ cl }/watch?v=${ video.videoUrl }" class="font-medium text-sm line-clamp-2 hover:underline">
		                            ${ video.title }
		                        </a>
		                        <a href="${ cl }/channel/${ video.creator }" class="text-sm text-gray-600 hover:underline">
		                            ${ video.creator }
		                        </a>
		                        <div class="text-sm text-gray-600">
		                            <c:choose>
									    <c:when test="${ video.views == 0 }">
									        조회수 없음
									    </c:when>
									    <c:when test="${ video.views >= 10000 }">
									        조회수 <fmt:formatNumber value="${ video.views / 10000 }" pattern="#"/>만회
									    </c:when>
									    <c:otherwise>
									        조회수 <fmt:formatNumber value="${ video.views }" type="number" />회
									    </c:otherwise>
									</c:choose> • 
		                            ${ video.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                            ? video.createAt.substring(6, 13) : video.createAt.substring(0, 13) }
		                        </div>
		                    </div>
		                </div>
		            </div>
	            </c:if>
	        </c:forEach>
	    </div>
	
	</div>
	
    <%@ include file="/common/footer.jsp" %>
    
</body>
</html>