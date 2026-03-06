document.addEventListener('DOMContentLoaded', () => {
    const profileForm = document.getElementById('profileForm');
    const statusMessage = document.getElementById('statusMessage');

    profileForm.addEventListener('submit', (e) => {
        e.preventDefault();

        // Show loading state if needed
        const submitBtn = profileForm.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerText;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Saving...';
        submitBtn.disabled = true;

        // Simulate API call
        setTimeout(() => {
            submitBtn.innerText = originalText;
            submitBtn.disabled = false;

            statusMessage.classList.remove('d-none');
            statusMessage.classList.add('animate-fade');

            setTimeout(() => {
                statusMessage.classList.add('d-none');
            }, 5000);
        }, 1500);
    });

    console.log('Guest Profile Controller Initialized');
});
