document.addEventListener('DOMContentLoaded', () => {
    const dialog = document.getElementById('fedi-share-dialog');
    const fediBtns = document.querySelectorAll('.fediverse-btn');
    const goBtn = document.getElementById('fedi-go-btn');
    const input = document.getElementById('fedi-domain');
    const networkLabel = document.getElementById('network-name');
    const dialogTitle = document.getElementById('dialog-title');
    
    let activeHandle = '';
    let activeNetwork = '';

    if (!dialog) return;

    let currentTitle = document.title;
    let currentUrl = window.location.href;

    fediBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            activeHandle = btn.dataset.handle || '';
            activeNetwork = btn.dataset.network;
            
            // UI Updates for consistency
            dialogTitle.textContent = `Share to ${activeNetwork}`;
            networkLabel.textContent = activeNetwork;
            input.placeholder = btn.dataset.placeholder || 'your-instance.com';
            
            dialog.showModal();
            input.focus();
        });
    });

    goBtn.addEventListener('click', () => {
        const domain = input.value.trim().replace(/^https?:\/\//, '');
        if (!domain) return;

        let shareUrl = '';
        const encodedText = encodeURIComponent(`${currentTitle} ${currentUrl}${activeHandle ? ' via ' + activeHandle : ''}`);

        if (activeNetwork === 'Lemmy') {
            // Lemmy uses a 'create_post' path rather than a generic 'share' path
            shareUrl = `https://${domain}/create_post?url=${encodeURIComponent(currentUrl)}&title=${encodeURIComponent(currentTitle)}`;
        } else {
            // Mastodon and Friendica generally support the /share?text= pattern
            shareUrl = `https://${domain}/share?text=${encodedText}`;
        }
        
        window.open(shareUrl, '_blank', 'noopener,noreferrer');
        dialog.close();
    });
});
