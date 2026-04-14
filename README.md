# COVID-19 Tracker Dashboard

A Flutter application that fetches real-time global COVID-19 statistics from the [disease.sh](https://disease.sh) public API and presents them through interactive charts and summary cards.

Built as a technical assessment for the **Mobile App Developer** position at **eHealth4everyone**.

---

## Dashboard Preview

<p align="center">
  <img src="screenshots/dashboard.png" alt="COVID-19 Tracker Dashboard" width="320" />
</p>

---

## Features

- **Global Statistics** -- Displays total cases, active cases, recovered, and deaths as colour-coded summary cards with compact number formatting.
- **Donut Chart** -- Visualises the distribution of active, recovered, and death cases as a proportional ring chart with percentage labels.
- **Line Chart** -- Plots daily new cases over the last 7 days, computed by differencing cumulative totals from the API.
- **Pull-to-Refresh** -- Swipe down anywhere on the dashboard to reload data.
- **Refresh Button** -- Tap the refresh icon in the app bar for a quick reload.
- **Loading State** -- Displays a centered spinner with a status message while data is being fetched.
- **Error Handling** -- A sealed exception hierarchy maps every failure (no network, timeout, DNS, server error, bad JSON) to a clean, user-friendly message. No raw stack traces ever reach the UI.

---

## Architecture

The project follows **Clean Architecture** principles with clear separation of concerns across three layers:

```
lib/
  main.dart                          -- App entry point & GetMaterialApp setup
  app/
    bindings/
      covid_binding.dart             -- GetX dependency injection (Repository -> UseCase -> Controller)

    core/
      error/
        error_handler.dart           -- Maps CovidException subtypes to user-friendly messages
      exceptions/
        covid_exception.dart         -- Sealed exception hierarchy (8 typed subtypes)
      theme/
        app_theme.dart               -- Material 3 theme configuration (colours, typography, cards)
      utils/
        date_formatter.dart          -- Date string helpers for chart labels and timestamps

    data/
      repositories/
        covid_repository.dart        -- HTTP client for disease.sh API with typed error mapping

    domain/
      covid_use_case.dart            -- Business logic layer between controller and repository

    features/
      covid_dashboard/
        controllers/
          covid_controller.dart      -- GetX reactive controller (state, observables, fetchData)
        models/
          global_stats_model.dart    -- Model for worldwide totals (cases, active, recovered, deaths)
          historical_model.dart      -- Model for 7-day historical daily new cases
        presentation/
          views/
            dashboard_view.dart      -- Main dashboard screen (loading, error, success states)
          widgets/
            stats_card.dart          -- Compact stat card with icon and formatted number
            donut_chart_widget.dart  -- Donut/pie chart for case distribution
            line_chart_widget.dart   -- Line chart for daily new cases trend
```

### Layer Responsibilities

| Layer | Role | Files |
|---|---|---|
| **Data** | Handles raw HTTP requests, JSON parsing, and throws typed exceptions at the boundary | `covid_repository.dart`, model files |
| **Domain** | Business logic that orchestrates data retrieval; provides a seam for future caching or offline support | `covid_use_case.dart` |
| **Presentation** | Reactive UI driven by GetX observables; zero business logic in widgets | Controller, views, and widget files |
| **Core** | Cross-cutting concerns: theme, error handling, date formatting, exception types | All files under `core/` |

---

## Error Handling System

A **sealed exception hierarchy** ensures every failure mode is typed and handled exhaustively:

| Exception | Trigger | User Message |
|---|---|---|
| `NetworkUnavailableException` | No internet connection | "No internet connection. Please check your network settings and try again." |
| `NetworkTimeoutException` | Request exceeds 15s timeout | "The request is taking too long. Please check your connection and try again." |
| `ServerException` | HTTP 4xx/5xx response | "The server returned an error. Please try again later." |
| `ServiceUnavailableException` | HTTP 503 | "Our data provider is temporarily unavailable. Please try again later." |
| `ParseException` | Malformed or empty JSON | "Received unexpected data from the server. Please try again." |
| `DnsException` | DNS resolution failure | "Unable to reach the server. Please check your connection or try again later." |
| `ConnectionException` | Connection refused/reset/TLS error | "The connection was interrupted. Please try again." |
| `UnknownException` | Any unmatched error | "Something went wrong. Please try again." |

**Flow:** Repository throws typed exception -> Controller catches it -> `ErrorHandler.toUserMessage()` returns a clean string -> UI displays it.

---

## API Integration

| Endpoint | Purpose |
|---|---|
| `GET /v3/covid-19/all` | Fetches latest global totals (cases, active, recovered, deaths, timestamp) |
| `GET /v3/covid-19/historical/all?lastdays=8` | Fetches 8 days of cumulative data to compute 7 daily deltas |

- **Connectivity pre-check** -- Before each API call, a DNS lookup on `disease.sh` fails fast when the device is offline.
- **Parallel fetching** -- Both endpoints are called simultaneously via `Future.wait`, so the user waits for the slower request, not the sum of both.
- **15-second timeout** -- Applied to every HTTP call to prevent indefinite hangs.

---

## Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter 3.x (Dart 3.2+) |
| State Management | GetX (`get: ^4.6.6`) |
| HTTP Client | `http: ^1.1.0` |
| Charts | fl_chart (`fl_chart: ^0.63.0`) |
| Date Formatting | `intl: ^0.18.1` |
| Architecture | Clean Architecture with MVVM presentation layer |

---

## Getting Started

### Prerequisites

- Flutter SDK 3.2 or higher
- Android SDK 34 or higher (for Android builds)
- A physical device or emulator with internet access

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/covid_tracker.git
cd covid_tracker

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build Release APK

```bash
flutter build apk --release
```

The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

---

## Data Transformation

The disease.sh historical endpoint returns **cumulative** case totals keyed by date (`"4/13/26": 704891023`). The app transforms this into daily new cases:

```
Day 1 cumulative: 704,650,000
Day 2 cumulative: 704,891,023
                   -----------
Daily new cases:       241,023
```

This differencing is performed in `HistoricalModel.fromJson()` across 8 consecutive days to produce 7 daily delta values for the line chart.

---

## Author

**Ishola Olubunmi**

Built with Flutter for the eHealth4everyone Mobile App Developer assessment.
