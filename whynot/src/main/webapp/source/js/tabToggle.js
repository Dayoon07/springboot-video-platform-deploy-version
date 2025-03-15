// 탭 클릭 시 콘텐츠 전환
const tabs = document.querySelectorAll('.tab-item');
const tabContents = document.querySelectorAll('.tab-content');

tabs.forEach(tab => {
    tab.addEventListener('click', () => {
        // 모든 탭과 콘텐츠 초기화
        tabs.forEach(t => t.classList.remove('text-blue-500', 'border-b-2', 'border-blue-500'));
        tabContents.forEach(content => content.classList.remove('active'));

        // 선택된 탭 활성화
        tab.classList.add('text-blue-500', 'border-b-2', 'border-blue-500');
        const contentId = tab.dataset.tab;
        document.getElementById(contentId).classList.add('active');
    });
});