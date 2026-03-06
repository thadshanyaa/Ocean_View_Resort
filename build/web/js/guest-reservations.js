document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('resSearch');
    const rows = document.querySelectorAll('tbody tr');

    searchInput.addEventListener('keyup', () => {
        const query = searchInput.value.toLowerCase();
        rows.forEach(row => {
            const text = row.innerText.toLowerCase();
            row.style.display = text.includes(query) ? '' : 'none';
        });
    });

    console.log('Guest Reservations Interaction Ready');
});
