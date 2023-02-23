-- Find the 5 oldest users of the Instagram from the database provided

SELECT 
    username
FROM
    users
ORDER BY created_at
LIMIT 5

-- Find the users who have never posted a single photo on Instagram

SELECT 
    id, username
FROM
    users
WHERE
    id NOT IN (SELECT 
            user_id
        FROM
            photos)

-- Identify the winner of the contest and provide their details to the team

SELECT 
    username
FROM
    users
WHERE
    id = (SELECT 
            user_id
        FROM
            photos
        WHERE
            id = (SELECT 
                    photo_id
                FROM
                    likes
                GROUP BY photo_id
                ORDER BY COUNT(*) DESC
                LIMIT 1)) 
                
-- Identify and suggest the top 5 most commonly used hashtags on the platform

SELECT 
    tag_name, COUNT(*)
FROM
    (SELECT 
        tag_name
    FROM
        tags
    INNER JOIN photo_tags ON tags.id = photo_tags.tag_id) tag_count
GROUP BY tag_name
ORDER BY COUNT(*) DESC
LIMIT 5

-- What day of the week do most users register on?

SELECT 
    DAYNAME(created_at) AS week_day, COUNT(*) AS total_reg
FROM
    users
GROUP BY week_day
ORDER BY total_reg DESC
LIMIT 2

-- Provide how many times does average user posts on Instagram

SELECT 
    ROUND(SUM(total_posts) / COUNT(*), 2)
FROM
    (SELECT 
        user_id, COUNT(*) AS total_posts
    FROM
        photos
    GROUP BY user_id
    ORDER BY total_posts) posts
    
-- Provide the total number of photos on Instagram/total number of users

SELECT 
    ROUND((SELECT 
                    COUNT(*)
                FROM
                    photos) / (SELECT 
                    COUNT(*)
                FROM
                    users),
            2)

-- Provide data on users (bots) who have liked every single photo on the site

SELECT 
    id, username
FROM
    users
WHERE
    id IN (SELECT 
            user_id
        FROM
            likes
        GROUP BY user_id
        HAVING COUNT(*) = (SELECT 
                COUNT(*)
            FROM
                photos))







