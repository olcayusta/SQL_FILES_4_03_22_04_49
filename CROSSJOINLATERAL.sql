EXPLAIN ANALYSE
SELECT cr.id, cr.title, messages
FROM chat_room cr
         CROSS JOIN LATERAL (
    SELECT ARRAY(
                   SELECT jsonb_build_object(
                                  'id', cm.id,
                                  'text', cm.content,
                                  'type', cm.type,
                                  'user', (
                                      SELECT jsonb_build_object(
                                                     'id', u.id, 'displayName', u."displayName", 'picture', u.picture)
                                      FROM "user" u
                                      WHERE u.id = cm."userId"
                                  )
                              )
                   FROM chat_message cm
                   WHERE cm."roomId" = cr.id
                   ORDER BY cm.id
               ) AS messages
    ) p
WHERE cr.id = 1;