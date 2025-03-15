function showTab(tabId) {
	document.querySelectorAll('#commentSearch, #comments').forEach(tab => {
		tab.classList.add('hidden');
	});

    document.getElementById(tabId).classList.remove('hidden');

    document.querySelectorAll('#tabs button').forEach(button => {
    	button.classList.remove('text-blue-600', 'border-b-2', 'border-blue-600');
        button.classList.add('text-gray-600');
	});

	document.querySelector(`#tabs button[onclick="showTab('${tabId}')"]`).classList.add('text-blue-600', 'border-b-2', 'border-blue-600');
}