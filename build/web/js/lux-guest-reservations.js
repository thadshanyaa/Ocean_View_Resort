document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('bookingSearch');
    const tableRows = document.querySelectorAll('tbody tr');

    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            const term = e.target.value.toLowerCase();
            tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(term) ? '' : 'none';
            });
        });
    }

    console.log('Luxury Guest Reservations: Filters Ready');
});
