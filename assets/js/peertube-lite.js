document.addEventListener('DOMContentLoaded', () => {
    const players = document.querySelectorAll('.peertube-lite');

    players.forEach(player => {
        const loadVideo = () => {
            if (player.dataset.loaded) return;
            const id = player.dataset.id;
            const instance = player.dataset.instance;
            const title = player.getAttribute('aria-label');
            
            const iframe = document.createElement('iframe');
            iframe.setAttribute('src', `https://${instance}/videos/embed/${id}?autoplay=1&title=0&warningTitle=0`);
            iframe.setAttribute('title', title);
            iframe.setAttribute('allow', 'autoplay; encrypted-media; picture-in-picture');
            iframe.setAttribute('allowfullscreen', '');
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            
            player.innerHTML = '';
            player.appendChild(iframe);
            player.dataset.loaded = 'true';
        };

        player.addEventListener('click', loadVideo);
        player.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                loadVideo();
            }
        });
    });
});
