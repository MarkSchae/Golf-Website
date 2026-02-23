# Project FastAPI Template

### A FastAPI starter template with:

- FastAPI

- SQLAlchemy

- Alembic migrations

- Environment configuration

- Project structure for scalable APIs

- Setup script for fast bootstrapping

This repository is intended to be used as a base template for new FastAPI projects.

### Features

- Structured app/ layout

- Database models with SQLAlchemy

- Alembic migrations pre-configured

- requirements.txt dependency management

- Setup script for quick environment initialization

### Installation
#### Option 1 — Using Setup Script (Recommended)
chmod +x setup.sh
./setup.sh

##### This will:

- Create virtual environment

- Install dependencies from requirements.txt

- Run database migrations

#### Option 2 — Manual Setup

- python -m venv .venv
- source .venv/bin/activate  Linux/Mac
- .venv\Scripts\activate   Windows
- pip install -r requirements.txt
alembic upgrade head

### Running the Server
uvicorn app.main:app --reload


App will be available at:

http://127.0.0.1:8000


Swagger docs:

http://127.0.0.1:8000/docs

### Running Migrations

Create a migration:

alembic revision --autogenerate -m "your message"


Apply migrations:

alembic upgrade head

### Project Structure
app/
  main.py
  models.py
  schemas.py
  routes/

alembic/
alembic.ini
requirements.txt
setup.sh

### Intended Use

This repository serves as a clean starting point for:

REST APIs

Real-time systems (to be extended)

Production-ready FastAPI backends

Backend services integrated with other systems (e.g., Rust microservices)

# Golf Pro Fitting Web App — Project Setup Documentation

## 1. Project Overview

This project aims to build a data-driven golf performance and fitting application using:

* **Backend:** FastAPI (Python)
* **Database:** PostgreSQL
* **Database Management:** DBeaver and SQL script analysis querries
* **Development Environment:** WSL (Ubuntu) + Windows
* **Data Source:** Google Sheets mock dataset

The goal of this phase was to design and validate the **data pipeline and backend foundation** before implementing application features.

---

## 2. Data Design Phase (Google Sheets)

### Objective

Create a structured dataset representing golf performance data before building the database schema.

### Process

1. Designed mock datasets in Google Sheets.
2. Modeled relationships between entities:

   * Players
   * Courses
   * Rounds
   * Staging statistics
3. Used spreadsheets to:

   * Validate column structure
   * Test normalization ideas
   * Simulate real-world input data
   * Identify required relationships early

### Outcome

A validated logical data model ready to migrate into PostgreSQL.

---

## 3. Database Setup (PostgreSQL + DBeaver)

### Environment Reality (Key Learning)

Two PostgreSQL environments existed:

* Windows PostgreSQL
* WSL PostgreSQL

Initial connections pointed to the **Windows instance**, creating connectivity issues with the FastAPI backend running inside WSL.

### Resolution

Configured connections to explicitly target the WSL PostgreSQL server.

---

### Database Creation

Using DBeaver:

1. Created PostgreSQL connection.
2. Connected to the running PostgreSQL server.
3. Created schema:

```sql
CREATE SCHEMA golf;
```

4. Created tables:

* `golf.players`
* `golf.courses`
* `golf.rounds`
* `golf.stagingstats`

### Verification

```sql
\dt golf.*
```

Result:

```
courses
players
rounds
stagingstats
```

---

## 4. Mock Data Import

Data from Google Sheets was imported into PostgreSQL.

Purpose:

* Validate schema design
* Enable backend testing
* Simulate production data early

Key advantage:

> Backend development could begin without waiting for real data sources.

---

## 5. FastAPI Backend Template Setup

### Goal

Create a reusable backend template for future projects.

### Stack

* FastAPI
* Python virtual environment
* PostgreSQL driver
* Modular project structure

### Achievements

* Backend project initialized
* Environment isolated via `.venv`
* Database connection configured
* Template prepared for GitHub reuse

This template now serves as a starting point for future database-driven APIs.

---

## 6. WSL ↔ PostgreSQL Connectivity Testing

### Problem Encountered

FastAPI (running in WSL) could not connect to PostgreSQL created via DBeaver.

Symptoms:

* Hanging connections
* Authentication errors
* `pg_hba.conf` access issues
* IP routing confusion

Example error:

```
no pg_hba.conf entry for host ..., no encryption
```

### Root Cause

WSL and Windows operate as **separate network environments**.

`localhost` inside WSL ≠ `localhost` in Windows.

---

### Solution

Connected using the Windows host gateway IP:

```bash
ip route | grep default
```

Then:

```bash
psql -h <gateway-ip> -U postgres -d postgres
```

Updated PostgreSQL access rules to allow WSL connections.

---

### Verification

Successfully accessed schema:

```sql
\dt golf.*
```

Queried data:

```sql
SELECT * FROM golf.rounds;
```

---

## 7. SQL Query Testing

Queries were validated directly in `psql`.

Examples:

```sql
SELECT * FROM golf.rounds;
```

Performance testing:

```sql
EXPLAIN ANALYZE
SELECT * FROM golf.rounds WHERE score < 70;
```

Output confirmed:

* Table scans working
* Filters applied correctly
* Database responding as expected

---

## 8. Key Technical Lessons Learned

### 1. Environment Separation Matters

WSL and Windows behave like separate machines.

Always confirm:

* Where PostgreSQL is running
* Where the backend runs

---

### 2. GUI Tools Do Not Own Databases

DBeaver only connects to servers — it does not create them.

The server location determines accessibility.

---

### 3. Validate Data Before Coding APIs

Designing datasets first reduced backend rework.

---

### 4. Test Database Access Early

Testing with `psql` saved significant debugging time later.

---

## 9. Current Project State

✅ Data model designed
✅ Mock data created
✅ PostgreSQL schema operational
✅ FastAPI template initialized
✅ Backend ↔ database connectivity verified
✅ SQL queries tested and analyzed

---

## 10. Next Steps

* Implement FastAPI database models
* Create API endpoints
* Add query layer (CRUD operations)
* Integrate frontend consumers
* Introduce analytics/statistics logic

---

## (Optional) Portfolio Summary Version

If needed for CV/portfolio:

> Designed and implemented a PostgreSQL-backed FastAPI project from data modeling through backend connectivity. Created mock datasets, normalized relational schema, configured cross-environment database access between WSL and Windows, and validated SQL performance using execution plans.

---

If you want, next I can help you turn this into one of these (very useful career-wise):

1. **Developer Journal version** (shows thinking process — very impressive to recruiters)
2. **GitHub README optimized for hiring managers**
3. **Architecture diagram** showing Sheets → DB → FastAPI → Client
4. **“Lessons learned” engineering blog post** (this one is secretly powerful)

Which direction do you want to go?

