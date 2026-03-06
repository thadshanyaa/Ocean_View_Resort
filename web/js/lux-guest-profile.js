document.addEventListener('DOMContentLoaded', () => {
    const profileForm = document.getElementById('luxProfileForm');

    if (profileForm) {
        profileForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const btn = e.target.querySelector('button[type="submit"]');
            const originalText = btn.innerText;

            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Securing Updates...';
            btn.disabled = true;

            setTimeout(() => {
                btn.innerText = originalText;
                btn.disabled = false;
                alert('Your elite profile has been successfully updated across all resort systems.');
            }, 1500);
        });
    }

    console.log('Luxury Guest Profile: Controller Ready');
});
