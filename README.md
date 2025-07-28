# Music Concert Database System

## Overview

This project was developed during my MSc studies as part of a group coursework on practical database systems. It focuses on designing and implementing a normalized relational database for managing music concerts, artists, songs, fans, tickets, and performances. The system is built using MySQL and includes schema creation, data population, and advanced SQL features like views, triggers, functions, and stored procedures.

## Project Files

| File Name                | Description                                               |
|--------------------------|-----------------------------------------------------------|
| `1_concert_schema.ipynb` | Defines and creates all tables and constraints in MySQL   |
| `2_data_of_tables.ipynb` | Inserts data into all defined tables                      |
| `3_code.ipynb`           | Contains views, triggers, stored functions & procedures   |
| `ERD.pdf`                | Entity Relationship Diagram (visual schema structure)     |

## Technology Stack

- **XAMPP** – Local development and testing
- **Jupyter Notebook** – SQL scripts with markdown for explanation
- **Draw.io** – ERD creation (exported as PDF)

## Database Features

### 🎵 Core Entities

- **Artists** – ID, name, genre, debut year
- **Albums** – One-to-many relationship with artists
- **Songs** – Song title, length, release date, and solo/collab flag
- **Concerts** – Name, date, location
- **Fans** – Fan profiles including age and contact info
- **Tickets** – Purchases, seats, and shared ticket support
- **Seating** – Seat numbers and zones

### 🔗 Associative Tables

- `album_songs` – Songs included in each album  
- `song_artists` – Artists performing each song  
- `concert_artists` – Artists performing at concerts  
- `concert_songs` – Song performance order in concerts  
- `fan_favorites` – Fan’s favorite artists  
- `shared_tickets` – Support for shared tickets

## Views, Triggers & Procedures

### 👁️ View

- **Ticket Summary View**: Displays fan name(s), concert info, seat, ticket ID, price, and purchase date for quick reporting.

### 🧠 Triggers

- `prevent_duplicate_favorites`: Prevents inserting duplicate favorite artists for a fan  
- `log_new_album`: Logs new album insertions for audit purposes

### ⚙️ Stored Function

- `total_occupied_seats(concert_id)`: Calculates total seats filled for a concert, considering shared tickets

### ⚙️ Stored Procedure

- `add_song_to_album(song_id, album_id)`: Adds song to album only if not already present and updates release date if needed

## ERD Diagram

Refer to `ERD.pdf` to view the complete database structure and relationships between entities.

## How to Use

1. Set up MySQL (e.g., using XAMPP)
2. Run the notebooks in order:
   - `1_concert_schema.ipynb`
   - `2_data_of_tables.ipynb`
   - `3_code.ipynb`
3. Use any MySQL GUI or CLI to test and extend the system
4. Use `ERD.pdf` as a reference for database navigation

## Assumptions

- Songs can be collaborations between multiple artists
- Fans may share tickets
- A song can belong to multiple albums
- A concert includes multiple songs, performed in a defined order

## Notes

- Indexes are used to improve performance across joins and queries
- Schema is normalized to reduce redundancy and improve data integrity
- Designed with extensibility in mind (e.g., reviews, ratings, merchandise)

## Credits

This project was developed collaboratively as part of a group assignment during my **Master of Science (MSc)** program. It reflects applied knowledge of relational databases in a real-world scenario.
