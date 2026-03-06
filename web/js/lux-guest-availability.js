document.addEventListener('DOMContentLoaded', () => {
    const availForm = document.getElementById('luxAvailForm');

    if (availForm) {
        availForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const btn = e.target.querySelector('button');
            const originalText = btn.innerText;

            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Checking Luxury Suites...';
            btn.disabled = true;

            setTimeout(() => {
                btn.innerText = originalText;
                btn.disabled = false;
                alert('Refined search completed. Explore your available options below.');
            }, 1000);
        });
    }

    console.log('Luxury Guest Availability: Search Module Ready');
});
