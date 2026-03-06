document.addEventListener('DOMContentLoaded', () => {
    // Luxury Clock
    const updateClock = () => {
        const now = new Date();
        const clockEl = document.getElementById('lux-clock');
        if (clockEl) {
            clockEl.textContent = now.toLocaleTimeString('en-US', {
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            });
        }
    };

    updateClock();
    setInterval(updateClock, 10000);

    // Staggered Animations for cards
    const animElements = document.querySelectorAll('.lux-animate');
    animElements.forEach((el, index) => {
        if (!el.style.animationDelay) {
            el.style.animationDelay = `${index * 0.1}s`;
        }
    });

    console.log('Luxury Guest Dashboard: Initialized');
});
