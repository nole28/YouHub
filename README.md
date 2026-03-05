# YouHub 📱

## What is this?

I built YouHub to learn SwiftUI properly. It started as a YouTube clone but I'm planning to grow it into something bigger — video, shorts, messaging, and a social feed all in one app. Think YouTube meets Twitter with DMs.

Still in active development but the core is working and solid.

## What it does right now

-  **Home Feed** — Browse videos with live search that filters by title or channel name
-  **Video Playback** — Tap any video and it plays using AVKit
-  **Shorts** — Vertical swipeable feed like YouTube Shorts, auto plays and pauses
-  **Upload** — Add videos with title, description and privacy settings
-  **Subscriptions** — Subscribe to channels and see only their videos
-  **Profile** — See your info and videos you've uploaded
-  **Search** — Debounced live search using Combine

## Tech I used

- SwiftUI
- AVKit for video playback
- Combine for reactive search
- MVVM architecture
- EnvironmentObject and StateObject for state management

## How the app is structured

- `VideoStore` — holds all video and channel data, single source of truth
- `UserSession` — manages the logged in user and their subscriptions
- `SearchViewModel` — reactive search using Combine, listens to VideoStore for updates
- Reusable components like `VideoThumbnail`, `SearchBar`, `VideoPlayerView`

## What's coming next

- [ ] Firebase — real login and cloud data
- [ ] Direct messaging
- [ ] Twitter style social feed
- [ ] Comments and likes
- [ ] Real video uploads to cloud storage
- [ ] Notifications

## About me

Self-taught iOS developer, started from scratch, building real projects to get my first job in iOS development.

GitHub: [nole28](https://github.com/nole28)

---


