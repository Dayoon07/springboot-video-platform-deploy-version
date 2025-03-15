<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />

	<%
	    // 현재 요청된 URL을 가져오기
	    String currentUrl = request.getRequestURL().toString();
	
	    // "http://localhost:9000/whynot" 형식으로 필요한 부분만 추출
	    String baseUrl = currentUrl.substring(0, currentUrl.indexOf("/", currentUrl.indexOf("://") + 3)) + "/whynot";
	    
	    request.setAttribute("fuck", baseUrl);
	%>

	<header class="text-black p-4">
	    <div class="flex items-center justify-between w-full mx-auto">
	        <div class="flex items-center">
	        	<button class="text-black text-3xl mr-5 cursor-pointer" onclick="openSide()">&#9776;</button>
	        	<a href="${ cl }/" class="text-2xl font-bold">
		            <span class="text-red-600">Why</span><span class="text-black">not</span>
		        </a>
	        </div>
	
			<form action="${ cl }/search" method="get" autocomplete="on" class="flex rounded-md border-black border-2 overflow-hidden w-96 mx-auto" id="mainFormId">
	        	<input type="text" placeholder="검색" name="t" class="w-full outline-none bg-white text-black text-md px-4 py-2" title="검색어를 입력하세요" required
	        		value="${ not empty searchWord ? searchWord : '' }">
		        <button type="submit" class="flex items-center justify-center bg-black px-5">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.904 192.904" width="20px" class="fill-white">
						<path d="m190.707 180.101-47.078-47.077c11.702-14.072 18.752-32.142 18.752-51.831C162.381 36.423 125.959 0 81.191 0 36.422 
							0 0 36.423 0 81.193c0 44.767 36.422 81.187 81.191 81.187 19.688 0 37.759-7.049 51.831-18.751l47.079 47.078a7.474 7.474 
							0 0 0 5.303 2.197 7.498 7.498 0 0 0 5.303-12.803zM15 81.193C15 44.694 44.693 15 81.191 15c36.497 0 66.189 29.694 66.189 
							66.193 0 36.496-29.692 66.187-66.189 66.187C44.693 147.38 15 117.689 15 81.193z">
						</path>
		          	</svg>
		        </button>
	        </form>
	        
	        <button type="button" class="flex items-center justify-center rounded-full p-2 hover:bg-gray-200" onclick="searchBtn()">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.904 192.904" width="20px" class="fill-black">
					<path d="m190.707 180.101-47.078-47.077c11.702-14.072 18.752-32.142 18.752-51.831C162.381 36.423 125.959 0 81.191 0 36.422 
						0 0 36.423 0 81.193c0 44.767 36.422 81.187 81.191 81.187 19.688 0 37.759-7.049 51.831-18.751l47.079 47.078a7.474 7.474 
						0 0 0 5.303 2.197 7.498 7.498 0 0 0 5.303-12.803zM15 81.193C15 44.694 44.693 15 81.191 15c36.497 0 66.189 29.694 66.189 
						66.193 0 36.496-29.692 66.187-66.189 66.187C44.693 147.38 15 117.689 15 81.193z">
					</path>
		        </svg>
			</button>
	
	        <div class="flex items-center space-x-4 font-semibold">
	            <c:if test="${ empty sessionScope.creatorSession }">
					<a href="${ cl }/login" class="loginBtn btn text-black hover:bg-black hover:text-white border-black border-2 rounded px-4 py-2 transition-all duration-300">로그인</a>
					<a href="${ cl }/signup" class="btn text-black hover:bg-black hover:text-white border-black border-2 rounded px-4 py-2 mx-2 transition-all duration-300">회원가입</a>
				</c:if>
				<c:if test="${ not empty sessionScope.creatorSession }">
				  	<a href="${ cl }/upload" class="hidden sm:block btn text-black hover:text-white hover:bg-black border-black border-2 border-gray rounded-lg px-4 py-2 
				  		transition-all duration-300">업로드</a>
			        <a href="${ cl }/you" class="text-black text-xl">
			        	${ sessionScope.creatorSession.creatorName.length() >= 5 ? sessionScope.creatorSession.creatorName.substring(0, 5) += '..' : sessionScope.creatorSession.creatorName }
			        </a>
				  	<img src="${ fuck += sessionScope.creatorSession.profileImgPath }" id="profile" class="w-10 h-10 border-white border-2 rounded-full cursor-pointer" loading="lazy">
				  	
				  	<div id="profileDropdownMenu" class="fixed top-0 right-0 w-full h-full z-10 hidden"></div>
				  	
				  	<div id="profileDropdown" class="fixed top-16 right-4 bg-white py-1 text-black w-72 border-2 z-20 rounded-lg font-normal shadow-xl hidden">
				  		<div class="flex px-4 pb-1">
				  			<img src="${ fuck += sessionScope.creatorSession.profileImgPath }" class="w-16 h-16 rounded-full" loading="lazy">
				  			<div class="ml-2">
				  				<p class="text-xl py-1 font-normal cursor-pointer">${ sessionScope.creatorSession.creatorName }</p>
				  				<a href="${ cl }/channel/${ sessionScope.creatorSession.creatorName }" class="text-blue-600 hover:underline">내 채널 보기</a>
				  			</div>
				  		</div><hr> 
				  		
				  		<div>
				  			<a href="${ cl }/you" class="block w-full text-lg py-2 px-4 hover:bg-gray-100">마이 페이지</a>
				  			<a href="${ cl }/upload" class="sm:hidden block block w-full text-lg py-2 px-4 hover:bg-gray-100">업로드</a>
				  			<a href="${ cl }/update" class="block w-full text-lg py-2 px-4 hover:bg-gray-100">정보 수정</a>
				  			<form action="${ cl }/logout" method="post" autocomplete="off">
						        <button type="submit" class="block text-left w-full text-lg py-2 px-4 hover:bg-gray-100">로그아웃</button>
							</form>
				  		</div>
				  	</div>
				</c:if>
	        </div>
	    </div>
	</header>
	
	<div class="fixed top-0 left-0 w-full h-full z-50 bg-black opacity-50 hidden" id="sidebar-drop" onclick="closeSide()"></div>
	
	<aside id="sidebar" class="hidden w-64 h-full fixed left-0 top-0 py-2 bg-white text-black z-50 transform transition-transform overflow-y-scroll">
	    <div class="w-full bg-white flex items-center p-4" style="height: 56px;">
	        <button class="text-black text-3xl mr-5 cursor-pointer" onclick="closeSide()">&#9776;</button>
	        <a href="/" class="text-2xl font-bold">
		    	<span class="text-red-600">Why</span><span class="text-black">not</span>
			</a>
		</div>
	    <ul class="space-y-2 pt-4 px-4">
	    	<c:if test="${ empty sessionScope.creatorSession }">
	    		<li><a href="${ cl }/login" class="block py-2 px-4 rounded-md hover:bg-gray-200">로그인</a></li>
	    	</c:if>
		    <li><a href="${ cl }/" class="block py-2 px-4 rounded-md hover:bg-gray-200">홈</a></li>
		    <li><a href="${ cl }/mySubscri" class="block py-2 px-4 rounded-md hover:bg-gray-200">구독</a></li>
		    <c:if test="${ not empty sessionScope.creatorSession }">
		        <li><a href="${ cl }/channel/${ sessionScope.creatorSession.creatorName }" class="block py-2 px-4 rounded-md hover:bg-gray-200">내 채널</a></li>
		    </c:if>
		    <li><a href="${ cl }/you/like" class="block py-2 px-4 rounded-md hover:bg-gray-200">좋아요를 누른 영상</a></li>
		    <li><a href="${ cl }/you/viewstory" class="block py-2 px-4 rounded-md hover:bg-gray-200">시청 기록</a></li>
		    <li><a href="${ cl }/you" class="block py-2 px-4 rounded-md hover:bg-gray-200">내 페이지</a></li>
		    <hr class="my-2 border-gray-300">
		    <li class="font-semibold text-gray-400 uppercase">탐색</li>
		    <li><a href="${ cl }/tag/music" class="block py-2 px-4 rounded-md hover:bg-gray-200">음악</a></li>
		    <li><a href="${ cl }/tag/movie" class="block py-2 px-4 rounded-md hover:bg-gray-200">영화</a></li>
		    <li><a href="${ cl }/tag/game" class="block py-2 px-4 rounded-md hover:bg-gray-200">게임</a></li>
		    <li><a href="${ cl }/tag/sports" class="block py-2 px-4 rounded-md hover:bg-gray-200">스포츠</a></li>
		    <li><a href="${ cl }/tag/edu" class="block py-2 px-4 rounded-md hover:bg-gray-200">교육</a></li>
		    <hr class="my-2 border-gray-300">
		    <li class="font-semibold text-gray-400 uppercase">내 콘텐츠</li>
		    <li><a href="${ cl }/myVideo" class="hidden md:block py-2 px-4 rounded-md hover:bg-gray-200">스튜디오</a></li>
		    <li><a href="${ cl }/myVideo" class="md:hidden block py-2 px-4 rounded-md hover:bg-gray-200">내 영상</a></li>
		    <li><a href="${ cl }/myVideo/dashboard" class="md:hidden block py-2 px-4 rounded-md hover:bg-gray-200">대시보드</a></li>
	        <li><a href="${ cl }/myVideo/comment" class="md:hidden block py-2 px-4 rounded-md hover:bg-gray-200">영상 피드백</a></li>
	        <li><a href="${ cl }/myVideo/myComment" class="md:hidden block py-2 px-4 rounded-md hover:bg-gray-200">나의 댓글</a></li>
	        <li><a href="${ cl }/myVideo/subscribe" class="md:hidden block py-2 px-4 rounded-md hover:bg-gray-200">구독자 조회</a></li>
		</ul><br>
		<div class="w-full border-gray-300 border-t">
	    	<p class="text-sm text-gray-500 mt-4 px-4">
	    		&copy; 2024 Whynot. <br> All rights reserved. <br>
	    		문의 : gangd0642@gmail.com
        		<!--
        			영상 제작자가 whynot에서 게시한 영상은 각 영상 제작자의 소유이며 저작권을 인정하며
        			whynot은 영상 제작자가 만든 영상에 관여하지 않으며, 그와 관련된 책임을 지지 않습니다.
        		-->
    		</p>
	    </div>
	</aside>
	
	<div id="loading" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%;
	     background: white; display: flex; justify-content: center; align-items: center; z-index: 9999;">
	</div>