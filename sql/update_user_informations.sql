UPDATE users
SET username = %(username)s,
    email = %(email)s
WHERE id = %(user_id)s;