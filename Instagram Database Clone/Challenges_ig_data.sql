## CHALLENGE 1: We want to reward 5 users that have been with us the longest. 

SELECT 
    username, 
    created_at 
FROM users
ORDER BY created_at
LIMIT 5;

# +------------------+---------------------+
# | username         | created_at          |
# +------------------+---------------------+
# | Darby_Herzog     | 2016-05-06 00:14:21 |
# | Emilio_Bernier52 | 2016-05-06 13:04:30 |
# | Elenor88         | 2016-05-08 01:30:41 |
# | Nicole71         | 2016-05-09 17:30:22 |
# | Jordyn.Jacobson2 | 2016-05-14 07:56:26 |
# +------------------+---------------------+

## CHALLENGE 2: We need to figure out when to schedule an email ad campaign. We need to know which day we should run it on. 

SELECT
    DAYNAME(created_at) AS day_name,
    COUNT(created_at) AS 'count'
FROM users
GROUP BY day_name
ORDER BY COUNT(created_at) DESC;

# +-----------+-------+
# | day_name  | count |
# +-----------+-------+
# | Thursday  |    16 |
# | Sunday    |    16 |
# | Friday    |    15 |
# | Tuesday   |    14 |
# | Monday    |    14 |
# | Wednesday |    13 |
# | Saturday  |    12 |
# +-----------+-------+

## CHALLENGE 3: We want to run an email campaign targeting our inactive users. 

SELECT
    username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

# +---------------------+
# | username            |
# +---------------------+
# | Aniya_Hackett       |
# | Bartholome.Bernhard |
# | Bethany20           |
# | Darby_Herzog        |
# | David.Osinski47     |
# | Duane60             |
# | Esmeralda.Mraz57    |
# | Esther.Zulauf61     |
# | Franco_Keebler64    |
# | Hulda.Macejkovic    |
# | Jaclyn81            |
# | Janelle.Nikolaus81  |
# | Jessyca_West        |
# | Julien_Schmidt      |
# | Kasandra_Homenick   |
# | Leslie67            |
# | Linnea59            |
# | Maxwell.Halvorson   |
# | Mckenna17           |
# | Mike.Auer39         |
# | Morgan.Kassulke     |
# | Nia_Haag            |
# | Ollie_Ledner37      |
# | Pearl7              |
# | Rocio33             |
# | Tierra.Trantow      |
# +---------------------+

## CHALLENGE 4: We are running a contest based on who has the most liked photo. Who is the winner?

SELECT
    users.username,
    likes.photo_id,
    COUNT(DISTINCT likes.user_id) AS total_likes
FROM photos
JOIN likes
    ON photos.id = likes.photo_id
JOIN users
    ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

# +---------------+----------+-------------+
# | username      | photo_id | total_likes |
# +---------------+----------+-------------+
# | Zack_Kemmer93 |      145 |          48 |
# +---------------+----------+-------------+

## CHALLENGE 5: Our investors want to know how many times does the average user post? 

SELECT
    users.id,
    COUNT(photos.id) AS total_posts
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id;

SELECT 
    AVG(t1.total_posts) AS avg_posts 
FROM 
(SELECT
    users.id,
    COUNT(photos.id) AS total_posts
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id) AS t1;

# OR

SELECT
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg_posts;
    
# +-----------+
# | avg_posts |
# +-----------+
# |    2.5700 |
# +-----------+

## CHALLENGE 6: A brand wants to know which (5) hashtags to use in a post to make it relevant. 

SELECT 
    tag_id,
    tag_name,
    COUNT(photo_id) AS total_tags
FROM photo_tags
JOIN tags 
    ON photo_tags.tag_id = tags.id 
GROUP BY tag_id
ORDER BY total_tags DESC
LIMIT 5;

# +--------+----------+------------+
# | tag_id | tag_name | total_tags |
# +--------+----------+------------+
# |     21 | smile    |         59 |
# |     20 | beach    |         42 |
# |     17 | party    |         39 |
# |     13 | fun      |         38 |
# |     18 | concert  |         24 |
# +--------+----------+------------+

## CHALLENGE 7: Identify possible "bots" on our website (people who have liked every single photo, but haven't posted anything themselves) 

SELECT
    t1.user_id,
    t1.username
FROM
    (SELECT
         likes.user_id,
         users.username,
         COUNT(likes.photo_id) AS total_liked
     FROM likes
     JOIN users
         ON users.id = likes.user_id
     JOIN photos
         ON photos.id = likes.photo_id
     GROUP BY user_id
    ) AS t1
WHERE t1.total_liked = (SELECT COUNT(photos.id) FROM photos)
ORDER BY t1.user_id;

#OR 

SELECT 
    users.id,
    username,
    COUNT(likes.photo_id) AS total_liked
FROM users
JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING total_liked = (SELECT COUNT(photos.id) FROM photos);


