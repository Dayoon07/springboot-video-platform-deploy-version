window.addEventListener("load", () => {
	document.getElementById("loading").style.display = "none";
});

const sidebar = document.getElementById("sidebar");
const sidebarDrop = document.getElementById("sidebar-drop");

document.addEventListener("DOMContentLoaded", () => {
	"use strict";
	sidebarControl();
});

function sidebarControl() {
	setTimeout(() => {
		sidebar.classList.add("-translate-x-full");
	}, 10);
	setTimeout(() => {
		sidebar.classList.remove("hidden");
	}, 20);
}
function openSide() {
    sidebar.classList.remove("-translate-x-full");
    sidebar.classList.add("translate-x-0");
	sidebarDrop.classList.remove("hidden");
}
function closeSide() {
    sidebar.classList.remove("translate-x-0");
    sidebar.classList.add("-translate-x-full");
	sidebarDrop.classList.add("hidden");
}

const profile = document.getElementById("profile");
const profileDropdown = document.getElementById("profileDropdown");
const profileDropdownMenu = document.getElementById("profileDropdownMenu");
profile.addEventListener("click", () => {
	profileDropdownMenu.classList.remove("hidden");
	profileDropdown.classList.remove("hidden");
});
profileDropdownMenu.addEventListener("click", () => {
	profileDropdownMenu.classList.add("hidden");
	profileDropdown.classList.add("hidden");
});

// 계정 삭제 모달 열기
function openDeleteAccountModal() {
    document.getElementById("deleteMyAccount").classList.remove("hidden");
	document.getElementById("deleteMyAccountBg").classList.remove("hidden");
}

// 계정 삭제 모달 닫기
function closeDeleteAccountModal() {
	document.getElementById("deleteMyAccountBg").classList.add("hidden");
    document.getElementById("deleteMyAccount").classList.add("hidden");
}

function searchBtn() {
	const $div = document.createElement("div");
	$div.id = "mobileSearchBar";
	const str = `<form action="${location.origin}/whynot/search" method="get" autocomplete="on" class="flex items-center bg-white border-gray-300 border-b overflow-hidden w-full"><div class="text-2xl w-12 h-12 flex justify-center items-center bg-gray-200 hover:bg-gray-300"><img src="${location.origin}/whynot/source/img/arrow-icon.png" class="p-3 cursor-pointer" onclick="closeSearchBtn()"></div><input type="text" placeholder="검색" name="t" class="w-full px-4 py-2 text-gray-900 text-md outline-none bg-transparent" title="검색어를 입력하세요" required><button type="submit" class="bg-gray-200 hover:bg-gray-300"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.904 192.904" class="w-12 h-12 fill-gray-600 p-3"><path d="m190.707 180.101-47.078-47.077c11.702-14.072 18.752-32.142 18.752-51.831C162.381 36.423 125.959 0 81.191 0 36.422 0 0 36.423 0 81.193c0 44.767 36.422 81.187 81.191 81.187 19.688 0 37.759-7.049 51.831-18.751l47.079 47.078a7.474 7.474 0 0 0 5.303 2.197 7.498 7.498 0 0 0 5.303-12.803zM15 81.193C15 44.694 44.693 15 81.191 15c36.497 0 66.189 29.694 66.189 66.193 0 36.496-29.692 66.187-66.189 66.187C44.693 147.38 15 117.689 15 81.193z"></path></svg></button></form>`;
	$div.innerHTML = `${str}`;
	document.querySelector("body").append($div);
}
function closeSearchBtn() {
	document.getElementById("mobileSearchBar").style.display = "none";
	document.getElementById("mobileSearchBar").id = "notMobileSearchBar";
}



