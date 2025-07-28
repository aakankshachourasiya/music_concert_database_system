/* TASK : A view for the modified schema. The view use a join and both GROUP BY and
HAVING clauses. */
CREATE OR REPLACE VIEW ticket_display as 
SELECT t.ticket_id AS 'Ticket Number', 
c.name AS 'Concert',
GROUP_CONCAT(f.fan_name ORDER BY t.fan_id SEPARATOR ', ') AS 'Fan Name',
GROUP_CONCAT(t.seat_number ORDER BY t.fan_id SEPARATOR ', ') AS 'Seat Numbers',
count(t.seat_number) AS 'Number of Seats',
s.seat_zone AS 'Zone',
sum(s.price) AS 'Ticket Price',
c.location 'Location',
t.purchase_date AS 'Purchase Date'
FROM tickets t
JOIN concerts c on t.concert_id=c.concert_id
JOIN seating s on t.seat_number= s.seat_number
JOIN fans f on t.fan_id=f.fan_id
GROUP BY t.ticket_id
ORDER BY t.ticket_id;


/* TASK : One BEFORE and one AFTER trigger for the modified schema */
DELIMITER //

CREATE OR REPLACE TRIGGER log_new_album
AFTER INSERT ON albums
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action, details)
    VALUES (
        'New Album Added',
        CONCAT('Album ID: ', NEW.album_id, ', Title: ', NEW.album_title, ', Release Date: ', NEW.release_date)
    );
END;//


DELIMITER //

CREATE OR REPLACE TRIGGER prevent_duplicate_favorites
BEFORE INSERT ON fan_favorites
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM fan_favorites
        WHERE fan_id = NEW.fan_id
          AND artist_id = NEW.artist_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fan has already favorited this artist.';
    END IF;
END;//

/* TASK : A stored function that returns the total number of occupied seats for a given concert_id */
DELIMITER //

CREATE OR REPLACE FUNCTION TotalOccupiedSeats(concert_id_input INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_seats INT;

    -- Calculate the total number of occupied seats
    SELECT SUM(
        CASE 
            WHEN Shared_Ticket_flag = 'N' THEN 1  -- Non-shared ticket = 1 seat
            WHEN Shared_Ticket_flag = 'Y' THEN 2  -- Shared ticket = 2 seats
            ELSE 0  -- Any other value = 0 seats
        END
    )
    INTO total_seats
    FROM tickets
    WHERE concert_id = concert_id_input;

    -- Return the result, default to 0 if no tickets are found
    RETURN COALESCE(total_seats, 0);
END//

DELIMITER ;

/* TASK A stored procedure that checks whether a given song_id is associated with a given
album_id. */
DELIMITER //

CREATE OR REPLACE PROCEDURE CheckAndInsertSongAlbum(
    IN input_song_id INT,
    IN input_album_id INT
)
BEGIN
    DECLARE song_release_date DATE;
    DECLARE album_release_date DATE;

    -- Check if the song_id is already associated with the album_id
    IF NOT EXISTS (
        SELECT 1
        FROM album_songs
        WHERE song_id = input_song_id AND album_id = input_album_id
    ) THEN
        -- Get the release dates of the song and the album
        SELECT release_date INTO song_release_date
        FROM songs
        WHERE song_id = input_song_id;

        SELECT release_date INTO album_release_date
        FROM albums
        WHERE album_id = input_album_id;

        -- Insert the association into the song_album table
        INSERT INTO album_songs (song_id, album_id)
        VALUES (input_song_id, input_album_id);

        -- Adjust the song's release date if it is later than the album's release date
        IF song_release_date > album_release_date THEN
            UPDATE songs
            SET release_date = album_release_date
            WHERE song_id = input_song_id;
        END IF;
    END IF;
END //

DELIMITER ;
