async function moreBtn(event, id) {
	try {
		const res = await fetch(`${location.origin}/whynot/api/findFullComment`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ commentId: id })
		});

		const data = await res.text();
		console.log(data);
		event.target.textContent = data;

	} catch (error) {
		console.log(error);
	}
}
