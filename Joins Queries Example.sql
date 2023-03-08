SELECT * FROM teams;
SELECT * FROM players;

--Old Inner Join Syntax along with filter condition teamName = 'Hornets'
SELECT playerID,
       firstname || ' ' || lastname PlayerName,
       teamName
FROM players p, teams t
WHERE p.teamID = t.teamID
AND teamName = 'Hornets';

--Old multi-table Inner Join Syntax along with filter condition teamName = 'Hornets'
SELECT playerID,
       firstname || ' ' || lastname PlayerName,
       teamName,
       address,
       shirtcolor
FROM teams t, players p, fields f
WHERE t.teamid = p.teamid
AND homefield = fieldname
AND shirtcolor = 'Yellow';

--ANSI New Inner Join, either use the USING or the ON clause, along with filter condition teamName = 'Hornets'
SELECT * /*playerID,
       firstname || ' ' || lastname PlayerName,
       teamName*/
FROM players INNER JOIN teams
--USING (teamID)
ON players.teamID = teams.teamID
WHERE teamName = 'Hornets';

--ANSI new Multi-table Inner Join along with filter condition shirtcolor = yellow
SELECT teamid,
       playerID,
       firstname || ' ' || lastname PlayerName,
       teamName,
       address,
       shirtcolor
FROM teams t
JOIN players p
USING (teamid)
JOIN fields f
ON homefield = fieldname
WHERE shirtcolor = 'Yellow';

--Right Join
SELECT playerID,
       firstname || ' ' || lastname PlayerName,
       teamName
FROM teams RIGHT JOIN players
--USING (teamID);
ON players.teamID = teams.teamID;

--Left Join, OUTER is optional
SELECT playerID,
       firstname || ' ' || lastname PlayerName,
       teamName
FROM teams LEFT OUTER JOIN players
--USING (teamID);
ON players.teamID = teams.teamID;

--Inverse Outer Join Type 1
SELECT * --teams.teamID,
       --teamName
FROM teams LEFT OUTER JOIN players -- or use LEFT OUTER JOIN
USING (teamID)
WHERE playerid IS NULL;

--Inverse Outer Join Type 2
SELECT * --teams.teamID,
       --teamName
FROM teams t RIGHT OUTER JOIN players p -- or use LEFT OUTER JOIN
ON p.teamID = t.teamID
WHERE p.teamID IS NULL;

--FULL OUTER JOIN
SELECT * --playerID, firstname, lastname, teamName
FROM teams FULL OUTER JOIN players
--ON players.teamID = teams.teamID;
USING (teamID);

--INVERSE FULL JOIN Type 1
SELECT * --playerID, firstname, lastname, teamName
FROM teams FULL OUTER JOIN players
USING (teamID)
WHERE teamID IS NULL
OR playerid IS NULL;

--INVERSE FULL JOIN Type 2
SELECT * --playerID, firstname, lastname, teamName
FROM teams FULL OUTER JOIN players
ON players.teamID = teams.teamID
WHERE players.teamID IS NULL
OR players.playerid IS NULL;

--INNER Self-Join - Old Syntax - returns only those employees who report to a manager
SELECT e1.employeenumber AS employee_number,
       e1.firstname || ' ' || e1.lastname AS employee_name,
       e2.employeenumber AS manager_emp_number,
       e2.firstname || ' ' || e2.lastname AS manager_name
FROM employees e1, employees e2
WHERE e1.reportsto = e2.employeenumber
ORDER BY 2;