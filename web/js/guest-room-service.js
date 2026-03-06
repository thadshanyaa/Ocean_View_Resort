function openOrderModal(name, price) {
    document.getElementById('selectedItem').value = name;
    document.getElementById('itemPrice').innerText = 'LKR ' + price.toLocaleString();
    const modal = new bootstrap.Modal(document.getElementById('orderModal'));
    modal.show();
}

document.addEventListener('DOMContentLoaded', () => {
    // Category Filtering
    const tabs = document.querySelectorAll('#serviceTabs button');
    const items = document.querySelectorAll('.service-item');

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            // UI Update
            tabs.forEach(t => {
                t.classList.remove('active', 'bg-gold', 'bg-opacity-10', 'text-gold');
                t.classList.add('text-muted');
            });
            tab.classList.add('active', 'bg-gold', 'bg-opacity-10', 'text-gold');
            tab.classList.remove('text-muted');

            // Filtering
            const filter = tab.getAttribute('data-filter');
            items.forEach(item => {
                if (filter === 'all' || item.getAttribute('data-category') === filter) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });

    // Form Submission
    document.getElementById('serviceForm').addEventListener('submit', (e) => {
        e.preventDefault();
        alert('Thank you! Your service request has been received and is being processed.');
        bootstrap.Modal.getInstance(document.getElementById('orderModal')).hide();
    });
});
