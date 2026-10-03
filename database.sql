CREATE TABLE IF NOT EXISTS mechanic_job_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate VARCHAR(10) NOT NULL,
    owner VARCHAR(50) NOT NULL,
    health INT NOT NULL
);

INSERT INTO mechanic_job_vehicles (plate, owner, health) VALUES ('ABC123', 'player1', 1000);