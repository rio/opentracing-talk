SELECT
	episodes.title,
	quotes.characters,
	quotes.quote
FROM
	quotes 
JOIN
	episodes
ON
	episodes.id = quotes.episode
WHERE 
	quotes.characters LIKE '%Spock%'
