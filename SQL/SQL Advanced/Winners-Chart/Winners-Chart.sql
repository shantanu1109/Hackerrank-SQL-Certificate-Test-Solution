SELECT 
  event_id, 
  GROUP_CONCAT(IF(ranking = 1, participant_name, NULL) ORDER BY participant_name ASC SEPARATOR ',') AS first,
  GROUP_CONCAT(IF(ranking = 2, participant_name, NULL) ORDER BY participant_name ASC SEPARATOR ',') AS second,
  GROUP_CONCAT(IF(ranking = 3, participant_name, NULL) ORDER BY participant_name ASC SEPARATOR ',') AS third
FROM (
  SELECT 
    event_id, 
    participant_name, 
    MAX(score) AS best_score,
    DENSE_RANK() OVER (PARTITION BY event_id ORDER BY MAX(score) DESC) AS ranking
  FROM scoretable
  GROUP BY event_id, participant_name
) AS rankings
WHERE ranking <= 3
GROUP BY event_id
ORDER BY event_id ASC;
