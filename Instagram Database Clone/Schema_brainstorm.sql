# Components: Users, photos, comments, likes, hashtags, followers/followees.

# USERS

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    username VARCHAR(20)
);

# PHOTOS

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    photo_url VARCHAR(2083),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

# COMMENTS

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(140),
    user_id INT,
    photo_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE
);

# LIKES

CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    photo_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE,
    CONSTRAINT UNIQUE(user_id, photo_id)
);

# HASHTAGS

CREATE TABLE hashtags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(15)
);

## Linking Hashtags and Photos

CREATE TABLE hashtags_photos_link (
    hashtag_id INT,
    photo_id INT,
    FOREIGN KEY (hashtag_id) REFERENCES hashtags(id) ON DELETE CASCADE,
    FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE
);

# FOLLOWERS/FOLLOWEES aka User linking table

CREATE TABLE followers(
    user_id INT,
    follower_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE
);