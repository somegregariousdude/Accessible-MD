+++
title = "Test Video Embeds"
date = 2025-12-18T12:00:00-08:00
type = "articles"
tags = ["Test", "Video"]
+++

This entry provides a side-by-side comparison of the **YouTube** and **PeerTube** lite-facades. 

## YouTube
{{< youtube "0RKpf3rK57I" "Established YouTube Embed" >}}

---

## PeerTube
{{< peertube instance="tilvids.com" id="a947493a-3286-455c-a524-78326e5e80a0" title="New PeerTube Embed" >}}

### Verification Notes:
* Confirm both cards maintain the **Outlined Card** high-contrast borders.
* Verify the PeerTube play button uses the primary theme color on hover, matching the logic in `_peertube.scss`.
* Check that both are correctly identified as `u-video` for IndieWeb parsing.
