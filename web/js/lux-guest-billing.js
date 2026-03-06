document.addEventListener('DOMContentLoaded', () => {
    // Payment settlement simulation
    const payBtn = document.querySelector('.btn-lux-primary');
    if (payBtn && payBtn.textContent.includes('Settle')) {
        payBtn.addEventListener('click', () => {
            const confirmed = confirm('Confirm secure payment of LKR 12,500.00 using your primary Visa Card ending in •••• 8842?');
            if (confirmed) {
                alert('Secure payment processed successfully. Thank you for choosing Ocean View Resort.');
            }
        });
    }

    console.log('Luxury Guest Billing: Secure Console Initialized');
});
