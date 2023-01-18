INSERT INTO roles (role_name, inserted_at, updated_at, "isAuthoriseAdmin", "isAuthoriseManager")
VALUES ('User', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false, false);
INSERT INTO roles (role_name, inserted_at, updated_at, "isAuthoriseAdmin", "isAuthoriseManager")
VALUES ('Manager', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false, true);
INSERT INTO roles (role_name, inserted_at, updated_at, "isAuthoriseAdmin", "isAuthoriseManager")
VALUES ('Admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, true, true);
INSERT INTO users (email, username, password, role_id, inserted_at, updated_at) VALUES ('superadmin@dev.org', 'superadmin', '$pbkdf2-sha512$160000$joAod3mfRwa9p0rcQihMNQ$IyR5lpOCm2qZIo.Yo1eKDbGBg0yRJzvEFW7YYVEWlTbR2hFyNLjUJOq9UVKX6yCu7RjG0jVHLYHmoeQrLMLSLA', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO clocks (time, status, "user", inserted_at, updated_at) VALUES ('2021-01-01T13:51:01.000Z', false, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
