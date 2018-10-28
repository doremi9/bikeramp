# BIKERAMP

## About

### Description

It helps you track your rides during delivery of packages: how many kilometers you rode on each day and how much customer paid for delivery. The app will help you to control your work.

### Technology stack

| Technology   | Version |
| :----------- | :-----: |
| Ruby         |  2.5.1  |
| Rails        |  5.2.1  |
| PostgreSQL   |   10.5  |
| Grape        |  1.1.0  |

---

## Project Setup

### 1. Install dependencies

```bash
bundle install
```

### 2. Setup the database
Create the database and populate it with with sample records
```bash
rails db:setup
```

## API

```bash

POST /api/trips
GET /api/trips
PATCH /api/trips/:id
DELETE /api/trips/:id

POST /api/users
POST /api/users/login

GET /api/stats/current_week
GET /api/stats/current_month
GET /api/stats/weekly
GET /api/stats/monthly
```
