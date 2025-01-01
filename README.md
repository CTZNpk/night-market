# Night Market App

## Overview
The Night Market app is a simple Flutter application that uses an unofficial Valorant API to retrieve and display user-specific Night Market and Store data. The app allows users to manage multiple accounts, automatically check the Night Market for all added accounts, and search for specific items across all accounts.

**Note:** The Valorant API has undergone changes, and as a result, this project is no longer functional with the current API.

---

## Features
- **Retrieve Night Market Data**: Fetch and display Night Market details for Valorant accounts using the unofficial API.
- **Multiple Account Support**: Add and manage multiple Valorant accounts.
- **Automatic Market Check**: Automatically fetch and update Night Market and Store data for all linked accounts.
- **Item Search**: Search across all accounts to check if a specific item is available in any Night Market or Store.

---

## Prerequisites
- **Flutter SDK**: Ensure Flutter is installed on your system. You can download it from [flutter.dev](https://flutter.dev/docs/get-started/install).
- **API Access**: Obtain access to the unofficial Valorant API.
- **IDE**: Recommended IDEs are Visual Studio Code or Android Studio.

---

## Installation

### Steps
1. Clone the repository:
    ```bash
    git clone https://github.com/CTZNpk/night-market.git
    cd night-market
    ```

2. Get the dependencies:
    ```bash
    flutter pub get
    ```

3. Add API keys:
    - Open `lib/shared/constants.dart` (or a similar configuration file) and add your API credentials for the unofficial Valorant API.

4. Run the application:
    ```bash
    flutter run
    ```

---


## How It Works
- **API Integration**:
  - Connects to the unofficial Valorant API to fetch Night Market and Store data.
  - Retrieves item information, prices, and availability.
- **Account Management**:
  - Users can add and manage multiple accounts.
  - Each account’s data is fetched and stored locally for easy access.
- **Market Automation**:
  - Automatically checks and updates Night Market and Store data at regular intervals.
- **Item Search**:
  - Allows users to search for specific items across all linked accounts to see if they are available in any Night Market or Store.

---

