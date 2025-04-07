# [Changelog](https://keepachangelog.com/en/1.1.0/)

All significant changes (incl. versioning) are documented here.

## [Unreleased](https://git.nedeco.de/solingen/smartcityapp/modules/oscaenvironmentui-ios/-/releases)

## [1.5.10](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.10)

### Fixed
- Replaced EmptyView with ProgressView due to EmptyView not triggering onAppear

## [1.5.9](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.9)

### Changed
- Updated readme

## [1.5.8](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.8)

### Changed
- Leaving the standalone event module will now dismiss the district module instead of navigating to the district dashboard

## [1.5.7](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.7)

### Changed
- Updated readme

## [1.5.6](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.6)

### Changed
- Filter major events by event status

## [1.5.5](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.5)

### Added
- Event status info

### Changed
- Event request filtering by event status

## [1.5.4](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.4)

### Changed
- Politics api url

## [1.5.3](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.3)

### Added
- Mobility module which is deactivated for now

## [1.5.2](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.2)

### Added
- Meeting result and resolution text

## [1.5.1](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.1)

### Added
- Function to get district name in widget

## [1.5.0](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.5.0)

### Added
- Matomo navigation tracking

## [1.4.0](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.4.0)

### Added
- District diashow screen

## [1.3.0](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.3.0)

### Added
- New event widget

### Changed
- Old event module with new module

## [1.2.2](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.2.2)

### Added
- Favorite location repository

## [1.2.1](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.2.1)

### Changed
- Event filter apply filters button to cancel all filters button

## [1.2.0](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.2.0)

### Added

- Event Map and Event Detail Map views
- EventBoothDetailSheet
- Event and EventBooth Sponsors

## [1.1.1](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.1.1)

### Fixed
- Meetings not being filtered correctly

## [1.1.0](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.1.0)

### Added
- Event Map and Event Detail Map views
- EventItemDetailSheet
- Missing features from main event module

## [1.0.5](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.0.5)

### Added
- Nearby filter

### Changed
- Politics view
- District widget appearance

## [1.0.4](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.0.4)

### Changed

- Pagination and loading system

## [1.0.3](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.0.3)

### Fixed
- Watched count zero when enter first

## [1.0.2](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.0.2)

### Added
- ProjectStatus and PartnerCategory abstraction

## [1.0.1](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.0.1)

### Changed
- Adjusted design variables

## [1.0.0](https://git-dev.solingen.de/smartcityapp/modules/oscadistrict-ios/-/tags/1.0.0)

### Added

- Thermostat icon to weather Temperture Header
- Calander Search Filter for Events
- Calander Filter Option for Project Status
- Calander Search Filter for Project
- Calander Filter Option for Events
- Oparl/Politic Information Views
    - Member List
    - Member Detail
    - Meeting List
    - Meeting Detail
- Project List
- Project Detail Page
    - With Contacts
    - With Partner
- Map Pois
- Map Pois Detail Popup on Marker Click
- news count to Dashboard for events and press releases
- Event List
    - With Tabs/Filter Today, Tomorrow, In 2 Days
    - With Filtering for selected District
- Event Detail Page
- Press Releases List
    - With Title Searchbar
    - With Filtering for selected District
- Press Release Detail Page
- Pager
- Temporary Routing
- Navigation Bar style
- Dashboard:
    - Widgets
    - Tiles
- Changelog and Readme
- Design struct with constants and implement throughout project

### Changed

- Updated icons
- Updated dependencies
- Refactored Caching
- Setup v3.0.13 with District module
- Refactored project according to changes made in android
- Refactored Events Code Structure according to Android
- Refactored PressRelease according to changed made in Android
- Removed hardcoded api credentials by passing it through the core app
- Updated district module
- Login to parse server with session token if available
- Adjust design args

### Fixed

- Press Release slider jumping in Navigation
- Weather Image sizing
- widget count not counting new data properly

### Removed
