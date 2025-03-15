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
	<title>${ searchWord } - whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="max-w-7xl mx-auto p-4">
		<c:forEach var="searchVideos" items="${ searchList }">
			<div class="hidden md:flex justify-start my-3">
				<div class="pr-2">
					<a href="${ cl }/watch?v=${ searchVideos.videoUrl }">
						<img src="${ fuck += searchVideos.imgPath }" class="w-96 rounded-md object-cover">
					</a>
				</div>
				<div class="pl-2 py-2">
					<h1 class="text-2xl"><a href="${ cl }/watch?v=${ searchVideos.videoUrl }">${ searchVideos.title }</a></h1>
					<p class="text-gray-500">
						<span>조회수 ${ searchVideos.views == 0 ? "없음" : searchVideos.views += "회" } | </span>
						<span>${ searchVideos.createAt }</span>
					</p>
					<a href="${ cl }/channel/${ searchVideos.creator }" class="flex items-center my-2">
						<img src="${ fuck += searchVideos.frontProfileImg }" class="w-8 h-8 rounded-full object-cover">
						<p class="text-gray-500 ml-3">${ searchVideos.creator }</p>
					</a>
					<div class="text-gray-500">
						${ searchVideos.more.length() >= 50 ? searchVideos.more.substring(0, 50) : searchVideos.more }
					</div>
				</div>
			</div>
			<div class="md:hidden flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
			    <div class="relative">
			        <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
			            <a href="${ cl }/watch?v=${ searchVideos.videoUrl }">
			                <img src="${ fuck += searchVideos.imgPath }" class="w-full h-full object-cover" loading="lazy">
			            </a>
			        </div>
			        <span class="absolute bottom-2 right-2 bg-black text-white text-xs px-2 py-1 rounded">${ searchVideos.videoLen }</span>
			    </div>
			    <div class="flex gap-2">
			        <a href="${ cl }/channel/${ searchVideos.creator }">
			            <img src="${ fuck += searchVideos.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
			        </a>
			        <div class="flex-1 min-w-0">
			            <a href="${ cl }/watch?v=${ searchVideos.videoUrl }" class="font-medium text-sm line-clamp-2 hover:underline">
			                ${ searchVideos.title }
			            </a>
			            <a href="${ cl }/channel/${ searchVideos.creator }" class="text-sm text-gray-600 hover:underline">
			                ${ searchVideos.creator }
			            </a>
			            <div class="text-sm text-gray-600">
			                <c:choose>
			                    <c:when test="${ searchVideos.views == 0 }">
			                        조회수 없음
			                    </c:when>
			                    <c:when test="${ searchVideos.views >= 10000 }">
			                        조회수 <fmt:formatNumber value="${ searchVideos.views / 10000 }" pattern="#"/>만회
			                    </c:when>
			                    <c:otherwise>
			                        조회수 <fmt:formatNumber value="${ searchVideos.views }" type="number" />회
			                    </c:otherwise>
			                </c:choose> • 
			                ${ searchVideos.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
			                ? searchVideos.createAt.substring(6, 13) : searchVideos.createAt.substring(0, 13) }
			            </div>
			        </div>
			    </div>
			</div>
		</c:forEach>
    </div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>