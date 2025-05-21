# Databaser-Tobias-ObergAI24

# Skapande av USER
Jag skapar en USER som endast har SELECT-rättigheter. Detta förhindrar att USER ändrar eller tar bort kod i databasen oavsett om det är avsiktligt eller ej. Till exempel att en anställd ska kunna se vad som finns i butiklagret och inte råka göra en ändring eller ta bort något av vikt. 
För mer dokumentering om andra funktionaliteter se SQL-kod. 


<!-- CREATE LOGIN bokhandlare1 WITH PASSWORD = 'ITHS';

-- Använd rätt databas
USE Bokhandel;

-- Skapa en användare i databasen kopplad till login
CREATE USER bokhandlare1 FOR LOGIN bokhandlare1;

-- Tilldela endast SELECT-rättigheter
GRANT SELECT ON SCHEMA::dbo TO bokhandlare1; -->

