# Golf Data Management: Google Sheet Setup & Automation

This document explains how the project manages **golf player and rounds data** using a Google Sheet for manual entry, along with an automation script that pre-fills and updates data across different tabs. This is part of the workflow before importing data into PostgreSQL for analysis.

---

## 1. Google Sheet Structure

The Google Sheet is designed to capture raw golf data from users manually. The structure consists of **multiple tabs**:

### Tabs

1. **Manual Entry (Main Tab)**
   - Columns include:
     - `Player Name`
     - `Player Age`
     - `Player Gender`
     - `Fitted Clubs` (boolean)
     - `Age Started Golf`
     - `Practice Sessions/Week`
     - `Rounds Played/Year`
   - Users can manually input or update player information here.

2. **Rounds Data**
   - Columns include:
     - `Player Name`
     - `Course Name`
     - `Date Played`
     - `Score`
     - `Fairways Hit`
     - `GIR`
     - `Putts`
     - `Birdies`
     - `Pars`
     - `Tee Played`
     - `Max Carry Driver (m)`
   - Each row corresponds to a single round played by a player.

3. **Courses**
   - Columns include:
     - `Course Name`
     - `Difficulty Rating`
     - `Par Score`
     - `Black / White / Blue / Red Yardage`
     - `Course Record`
   - Data here serves as reference for rounds data and analytics.

---

## 2. Automation Script

To reduce manual effort and ensure consistency, an **automation script** pre-fills and updates data across the Google Sheet.

### Functionality

1. **Pre-fill Rows**
   - Automatically generates placeholder rows for new players or rounds.
   - Fills default values where appropriate (e.g., boolean flags, zero statistics).
   
2. **Data Synchronization**
   - Updates other tabs based on changes in the main manual entry tab.
   - For example:
     - If a new player is added in the main tab, a corresponding row is created in the rounds tab with default statistics.
     - If a course is added, the course tab is updated and rounds linked to that course are validated.

3. **Validation & Consistency**
   - Ensures required fields are filled.
   - Prevents duplicate player names or course names.
   - Optionally flags missing or invalid entries.

### Example Workflow

```
1. User adds a new player in "Manual Entry"
2. Automation script detects the new player
3. Script adds corresponding rows in "Rounds Data" with placeholders
4. Script ensures the "Courses" tab has any referenced courses
5. Sheet is ready for additional manual or automated data entry

[DataEntry](https://docs.google.com/spreadsheets/d/1pOPj5eOV4IccCI3LeQSSj_Otc2D4qUVxUhh73nUyY-s/edit?usp=sharing)