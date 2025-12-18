document.addEventListener('DOMContentLoaded', () => {
    const players = document.querySelectorAll('.bluesky-video-facade');
    players.forEach(facade => {
        facade.addEventListener('click', () => {
            const video = document.createElement('video');
            video.controls = true; video.autoplay = true; video.style.width = "100%";
            const source = document.createElement('source');
            source.src = facade.dataset.playlist;
            source.type = "application/x-mpegURL"; // HLS
            video.appendChild(source);
            facade.innerHTML = ''; facade.appendChild(video);
        });
    });
});
