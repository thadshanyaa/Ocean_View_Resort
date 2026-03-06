document.addEventListener('DOMContentLoaded', () => {
    console.log('Ocean View Billing Portal Ready');

    const payButtons = document.querySelectorAll('.btn-outline-gold');
    payButtons.forEach(btn => {
        if (btn.innerText === 'Pay') {
            btn.addEventListener('click', () => {
                alert('Redirecting to secure payment gateway...');
            });
        }
    });
});
