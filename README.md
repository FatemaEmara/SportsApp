# 🏆 Sports App — iOS Project

A native iOS application that lets users browse sports, explore leagues, view league details, and save favorite leagues — built with UIKit, CoreData, and the TheSportsDB API.

---

## 👥 Team Members & Responsibilities

| Name | Tasks |
|------|-------|
| Eyad Waleed | League Details Screen, Teams Details, Splash Screen, Unit Test |
| Fatema Emara | Sports Tab, Favorites Tab, Leagues Screen, On Boarding Screens |

---

## 📱 App Structure

### 1. Main Screen — Tab Bar Controller

**Tab 1: Sports**
- Displays all sports
- `CollectionView` layout with exactly 2 items per row, evenly spaced
- Each cell shows the sport's thumbnail image and name
- Tab title: Sports
- Tapping a sport navigates to the Leagues ViewController

**Tab 2: Favorites**
- Displays leagues saved by the user
- Backed by CoreData for offline persistence
- UI mirrors the Leagues ViewController
- Tapping a row:
  - Online → navigates to LeagueDetails ViewController
  - Offline → shows an alert: `"No Internet Connection"`

---

### 2. Leagues ViewController

- Implemented as a `UITableViewController`
- Title: Leagues
- Custom table view cells containing:
  - League badge (`strBadge`) — displayed as a circular image
  - League name (`strLeague`)
- Tapping a row navigates to the League Details ViewController

---

### 3. League Details ViewController

A favourite button (☆ / ★) in the top-right navigation bar toggles the league in/out of CoreData favorites.

The screen is divided into three sections:

**Section 1 — Upcoming Events**
- Horizontal `CollectionView`
- Each cell displays:
  - Event name (`strEvent`)
  - Event date & time
  - Home & away team images

**Section 2 — Latest Events**
- Vertical `CollectionView`
- Each cell displays:
  - Home team vs Away team names
  - Score (`intHomeScore` vs `intAwayScore`)
  - Date & Time
  - Home & away team images

**Section 3 — Teams**
- Horizontal `CollectionView`
- Each cell shows a circular team logo
- Tapping a team image navigates to the Team Details ViewController

---

### 4. Team Details ViewController

- Shows a curated set of team details (name, badge, country, description, etc.)
- Custom, elegant UI design — layout chosen by the developer

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Swift |
| UI Framework | UIKit |
| Persistence | CoreData |
| Networking | Alamofire |
| Image Loading | SDWebImage |
| Architecture | MVP |
| API | TheSportsDB |

---

## 🔌 API Reference

**Base URL:** `https://www.thesportsdb.com/api/v1/json/3/`

| Endpoint | Description |
|----------|-------------|
| `lookupteam.php?id={teamId}` | Team details |
| `search_all_leagues.php?s={sport}` | Leagues by sport |
| `eventsnextleague.php?id={leagueId}` | Upcoming events |
| `eventspastleague.php?id={leagueId}` | Past/latest events |
| `lookup_all_teams.php?id={leagueId}` | Teams in a league |

---

## 🚀 Getting Started

1. Clone the repository
2. Open `SportsApp.xcodeproj` in Xcode
3. Run on a simulator or physical device (iOS 11+)
4. No API key required for the free tier of TheSportsDB

---

## 📋 Notes

- Internet connectivity is checked before navigating from the Favorites tab using `NWPathMonitor` or `Reachability`
- CoreData model includes a `FavoriteLeague` entity storing league id, name, and badge URL
- Circular images are achieved via `layer.cornerRadius = imageView.frame.width / 2` with `clipsToBounds = true`
