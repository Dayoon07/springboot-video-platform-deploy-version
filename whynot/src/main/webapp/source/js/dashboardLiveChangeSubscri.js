document.addEventListener("DOMContentLoaded", function() {
    const subscribeElement = document.getElementById("subscribeCount");

    async function fetchSubscribeCount() {
        try {
            const response = await fetch(`${location.origin}/whynot/subscribeCount`);
            if (!response.ok) throw new Error("서버 응답 오류");

            const count = await response.json();
            // 숫자 포맷
            const formattedCount = count.toLocaleString();
            subscribeElement.textContent = formattedCount;
            console.log(count);
        } catch (error) {
            console.error("구독자 수 갱신 실패:", error);
        }
    }

    setInterval(fetchSubscribeCount, 5000);

    fetchSubscribeCount();
});
