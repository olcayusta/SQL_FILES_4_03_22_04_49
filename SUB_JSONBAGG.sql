EXPLAIN ANALYSE
SELECT cr.id,
       cr.title,
       (
           SELECT jsonb_agg(item)
           FROM (
                    SELECT cm.id      AS id,
                           cm.content AS text,
                           cm.type    AS type,
                           (SELECT jsonb_build_object('id', u.id, 'displayName', u."displayName", 'picture', u.picture)
                            FROM "user" u
                            WHERE u.id = cm."userId")
                    FROM chat_message cm
                    WHERE cm."roomId" = cr.id
                ) item
       ) AS items
FROM chat_room cr;