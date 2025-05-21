-- Tabell: ”Författare” 
-- I tabellen författare vill vi ha en ”Identietskolumn” (identity) kallad ID som PK. 
-- Därutöver vill vi ha kolumnerna: Förnamn, Efternamn och Födelsedatum i 
-- passande datatyper.
Use Bokhandel


CREATE TABLE Författare(
    Id int IDENTITY(1,1) PRIMARY KEY,
    [Förnamn] NVARCHAR(100) NOT NULL,
    Efternamn NVARCHAR(100) NOT NULL,
    [Födelsedatum] DATE NOT NULL
);

INSERT INTO Författare VALUES ('Henning', 'Mankell', '1948-02-03');
INSERT INTO Författare VALUES ('J.R.R', 'Tolkien', '1892-01-03');
INSERT INTO Författare VALUES ('August', 'Strindberg', '1849-01-22');
INSERT INTO Författare VALUES ('Astrid', 'Lindgren', '1907-11-14');
INSERT INTO Författare VALUES ('Chrisopher', 'Tolkien', '1924-11-21');

GO

-- Tabell: ”Förlag”
-- I tabellen förlag vill vi ha en ”Identietskolumn” (identity) kallad ID som PK, Namn och kontaktinfo.

CREATE TABLE Förlag (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100) NOT NULL,
    Kontaktinfo NVARCHAR(255)
);

INSERT INTO Förlag VALUES('Norstedts', 'order@norstedts.se');
INSERT INTO Förlag VALUES('Harpercollins Publishers', 'consumercare@harpercollins.com');
INSERT INTO Förlag VALUES('LL-förlaget', 'll-forlaget@mtm.se');
INSERT INTO Förlag VALUES('Rabén Sjögren', 'rabén@sjögren.se');


-- Tabell: ”Böcker” 
-- I tabellen böcker vill vi ha ISBN som primärnyckel med lämpliga constraints. 
-- Utöver det vill vi ha kolumnerna: Titel, Språk, Pris, och Utgivningsdatum av 
-- passande datatyper. Sist vill vi ha en FK-kolumn ”FörfattareID” som pekar mot 
-- tabellen ”Författare”.  

CREATE TABLE Böcker(
    ISBN CHAR(13) PRIMARY KEY,
    Titel NVARCHAR(255) NOT NULL,
    Språk NVARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) CHECK (Pris >= 0) NOT NULL,
    Utgivningsdatum DATE,
    Typ NVARCHAR(30) NOT NULL,
    FörlagId INT,
    FOREIGN KEY (FörlagId) REFERENCES Förlag(Id) 
);

-- Henning Mankell
INSERT INTO Böcker VALUES('9789113139913', 'Hundarna i Riga', 'Svenska', 162.00,'2025-01-22', 'E-bok', 1);
INSERT INTO Böcker VALUES('9789113139906', 'Mördare utan ansikte', 'Svenska', 162.00, '2024-07-18', 'E-bok', 1);

-- J.R.R. Tolkien
INSERT INTO Böcker VALUES('9780007203543', 'Fellowship of the Ring', 'Engelska', 335.00, '2005-10-17', 'Inbunden', 2);
INSERT INTO Böcker VALUES('9780008376130', 'Two Towers', 'Engelska', 335.00, '2005-10-17', 'Inbunden', 2);
INSERT INTO Böcker VALUES('9780007203567', 'Return of the King', 'Engelska', 335.00, '2005-10-17', 'Inbunden', 2);

-- August Strindberg
INSERT INTO Böcker VALUES('9789170533860', 'Fröken Julie', 'Svenska', 189.00, '2012-02-01', 'Häftad', 3);
INSERT INTO Böcker VALUES('9789113093659', 'Hemsöborna', 'Svenska', 231.00, '2018-10-31', 'Häftad', 3);

-- Astrid Lindgren
INSERT INTO Böcker VALUES('9789129697858', 'Bröderna Lejonhjärta', 'Svenska', 99.00, '2015-03-02', 'Pocket', 4);
INSERT INTO Böcker VALUES('9789129678154', 'Mio min Mio', 'Svenska', 99.00, '2011-08-15', 'Pocket', 4);
INSERT INTO Böcker VALUES('9789129729887', 'Emil i Lönneberga', 'Svenska', 209.00, '2021-05-28', 'Inbunden', 4);
INSERT INTO Böcker VALUES('9789129698442', 'Känner du Pippi Långstrump?','Svenska', 159.00, '2015-05-22', 'Inbunden', 4);

-- Chrisopher Tolkien
INSERT INTO Böcker VALUES('9780007203543', 'Fellowship of the Ring', 'Engelska', 335.00, '2005-10-17', 'Inbunden', 5);
INSERT INTO Böcker VALUES('9780008376130', 'Two Towers', 'Engelska', 335.00, '2005-10-17', 'Inbunden', 5);
INSERT INTO Böcker VALUES('9780007203567', 'Return of the King', 'Engelska', 335.00, '2005-10-17', 'Inbunden', 5);

GO

-- Tabell: ”BokFörfattare” är en kopplingstabell mellan böcker och författare
-- en bok kan ha flera författare och en författare kan ha skrivit flera böcker
-- many to many relation

CREATE TABLE BokFörfattare (
    ISBN CHAR(13),
    FörfattareID INT,
    PRIMARY KEY (ISBN, FörfattareID),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN),
    FOREIGN KEY (FörfattareID) REFERENCES Författare(Id)
);

-- Henning Mankell
INSERT INTO BokFörfattare VALUES('9789113139913', 1);
INSERT INTO BokFörfattare VALUES('9789113139906', 1);

-- J.R.R. Tolkien
INSERT INTO BokFörfattare VALUES('9780007203543', 2);
INSERT INTO BokFörfattare VALUES('9780008376130', 2);
INSERT INTO BokFörfattare VALUES('9780007203567', 2);

-- Chrisopher Tolkien, Lägger till författare här för att ha det mer strukturerat. Även om ID är 2 och 5.
INSERT INTO BokFörfattare VALUES('9780007203543', 5);
INSERT INTO BokFörfattare VALUES('9780008376130', 5);
INSERT INTO BokFörfattare VALUES('9780007203567', 5);


-- August Strindberg
INSERT INTO BokFörfattare VALUES('9789170533860', 3);
INSERT INTO BokFörfattare VALUES('9789113093659', 3);

-- Astrid Lindgren
INSERT INTO BokFörfattare VALUES('9789129697858', 4);
INSERT INTO BokFörfattare VALUES('9789129678154', 4);
INSERT INTO BokFörfattare VALUES('9789129729887', 4);
INSERT INTO BokFörfattare VALUES('9789129698442', 4);

GO

-- Tabell: ”Butiker” 
-- Utöver ett identity-ID så behöver tabellen kolumner för att lagra butiksnamn 
-- samt addressuppgifter. 

CREATE TABLE Butiker(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100),
    Epost NVARCHAR(100),
    Telnummer NVARCHAR(10),
    Gatuadress NVARCHAR(100) 
);

INSERT INTO Butiker VALUES('Bokbutiken', 'Bokbutiken@gmail.com', '0701234567', 'Bokgatan 1');
INSERT INTO Butiker VALUES('Bokhandeln', 'Bokhandeln@gmail.com', '0707654321', 'Bokhagevägen 2');
INSERT INTO Butiker VALUES('Bokaffären', 'Bokaffären@gmail.com', '0709876543', 'Boklundsvägen 3');

GO


-- Tabell: ”LagerSaldo” 
-- I denna tabell vill vi ha 3 kolumner: ButikID som kopplas mot Butiker, ISBN som 
-- kopplas mot böcker, samt Antal som säger hur många exemplar det finns av en 
-- given bok i en viss butik. Som PK vill vi ha en kompositnyckel på kolumnerna 
-- ButikID och ISBN. 

CREATE TABLE LagerSaldo(
    ButikID INT,
    ISBN CHAR(13),
    Antal INT CHECK (Antal >= 0),
    PRIMARY KEY (ButikID, ISBN),
    FOREIGN KEY (ButikID) REFERENCES Butiker(Id),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN)
);


-- För Butik 1
INSERT INTO LagerSaldo VALUES(1, '9789113139913', 10);
INSERT INTO LagerSaldo VALUES(1, '9789113139906', 5);
INSERT INTO LagerSaldo VALUES(1, '9780007203543', 2);
INSERT INTO LagerSaldo VALUES(1, '9780008376130', 3);
INSERT INTO LagerSaldo VALUES(1, '9780007203567', 4);
INSERT INTO LagerSaldo VALUES(1, '9789170533860', 3);
INSERT INTO LagerSaldo VALUES(1, '9789113093659', 2);
INSERT INTO LagerSaldo VALUES(1, '9789129697858', 4);
INSERT INTO LagerSaldo VALUES(1, '9789129678154', 5);
INSERT INTO LagerSaldo VALUES(1, '9789129729887', 3);
INSERT INTO LagerSaldo VALUES(1, '9789129698442', 1);  

-- För Butik 2
INSERT INTO LagerSaldo VALUES(2, '9789113139913', 5);
INSERT INTO LagerSaldo VALUES(2, '9789113139906', 3);
INSERT INTO LagerSaldo VALUES(2, '9780007203543', 1);
INSERT INTO LagerSaldo VALUES(2, '9780008376130', 2);
INSERT INTO LagerSaldo VALUES(2, '9780007203567', 3);
INSERT INTO LagerSaldo VALUES(2, '9789170533860', 4);
INSERT INTO LagerSaldo VALUES(2, '9789113093659', 8);
INSERT INTO LagerSaldo VALUES(2, '9789129697858', 6);
INSERT INTO LagerSaldo VALUES(2, '9789129678154', 9);
INSERT INTO LagerSaldo VALUES(2, '9789129729887', 1);
INSERT INTO LagerSaldo VALUES(2, '9789129698442', 2);  

-- För Butik 3
INSERT INTO LagerSaldo VALUES(3, '9789113139913', 8);
INSERT INTO LagerSaldo VALUES(3, '9789113139906', 7);
INSERT INTO LagerSaldo VALUES(3, '9780007203543', 8);
INSERT INTO LagerSaldo VALUES(3, '9780008376130', 6);
INSERT INTO LagerSaldo VALUES(3, '9780007203567', 4);
INSERT INTO LagerSaldo VALUES(3, '9789170533860', 3);
INSERT INTO LagerSaldo VALUES(3, '9789113093659', 2);
INSERT INTO LagerSaldo VALUES(3, '9789129697858', 1);
INSERT INTO LagerSaldo VALUES(3, '9789129698442', 12);
INSERT INTO LagerSaldo VALUES(3, '9789129678154', 1); 
INSERT INTO LagerSaldo VALUES(3, '9789129729887', 2); 



GO

-- genrer tabellen innehåller en lista på genrer som böckerna kan tillhöra

CREATE TABLE Genrer(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100) NOT NULL
);


INSERT INTO Genrer VALUES('Deckare');
INSERT INTO Genrer VALUES('Fantasy');
INSERT INTO Genrer VALUES('Drama');
INSERT INTO Genrer VALUES('Barnbok');

GO

-- tabellen BokGenrer är en kopplingstabell mellan böcker och genrer
-- en bok kan tillhöra flera genrer och en genre kan ha flera böcker
CREATE TABLE BokGenrer(
    ISBN CHAR(13),
    GenreId INT,
    PRIMARY KEY (ISBN, GenreId),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN),
    FOREIGN KEY (GenreId) REFERENCES Genrer(Id)
);

INSERT INTO BokGenrer VALUES('9789113139913', 1);
INSERT INTO BokGenrer VALUES('9789113139906', 1);
INSERT INTO BokGenrer VALUES('9780007203543', 2);
INSERT INTO BokGenrer VALUES('9780008376130', 2);
INSERT INTO BokGenrer VALUES('9780007203567', 2);
INSERT INTO BokGenrer VALUES('9789170533860', 3);
INSERT INTO BokGenrer VALUES('9789113093659', 3);
INSERT INTO BokGenrer VALUES('9789129697858', 4);
INSERT INTO BokGenrer VALUES('9789129678154', 4);
INSERT INTO BokGenrer VALUES('9789129729887', 4);
INSERT INTO BokGenrer VALUES('9789129698442', 4);

GO


-- betyg ett generellt betyg och inte kopplat till en specifik butik
-- betyg är en decimal mellan 1 och 5
CREATE TABLE Betyg(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Betyg DECIMAL(5,1) CHECK (Betyg >= 1 AND Betyg <= 5) NOT NULL,
    BokISBN CHAR(13),
    FOREIGN KEY (BokISBN) REFERENCES Böcker(ISBN)  
);

INSERT INTO Betyg VALUES(3.2, '9789113139913');
INSERT INTO Betyg VALUES(3.3, '9789113139906');
INSERT INTO Betyg VALUES(4.2, '9780007203543');
INSERT INTO Betyg VALUES(4.2, '9780008376130');
INSERT INTO Betyg VALUES(4.2, '9780007203567');
INSERT INTO Betyg VALUES(3.3, '9789170533860');
INSERT INTO Betyg VALUES(3.6, '9789113093659');
INSERT INTO Betyg VALUES(4.3, '9789129697858');
INSERT INTO Betyg VALUES(4.2, '9789129678154');
INSERT INTO Betyg VALUES(4.1, '9789129729887');
INSERT INTO Betyg VALUES(4.0, '9789129698442');

GO

CREATE TABLE Kunder(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100) NOT NULL,
    Epost NVARCHAR(100) NOT NULL,
    Telnummer NVARCHAR(10) NOT NULL,
    Gatuadress NVARCHAR(100) NOT NULL
);

INSERT INTO Kunder VALUES('Kalle', 'Kalle.Östman@gmail.com', '0701234567', 'Kallevägen 1');
INSERT INTO Kunder VALUES('Lisa', 'Lisa.Johansson@hotmail.com', '0707654321', 'Lisagatan 2');
INSERT INTO Kunder VALUES('Erik', 'Erik.Kinnvall@live.se', '0709876543', 'Eriksvägen 3');
INSERT INTO Kunder VALUES('Anna', 'Anna.Simonsson@hotmail.com', '0701234567', 'Anna gatan 4');
INSERT INTO Kunder VALUES('Oskar', 'Oskar.Jacobsson@gmail.com', '0707654321', 'Oskargatan 5');
INSERT INTO Kunder VALUES('Sara', 'Sara.Ulvesson@gmail.com', '0709876543', 'Saravägen 6');
INSERT INTO Kunder VALUES('Maja', 'Maja.Ivarsson@hotmail.com', '0701234567', 'Majagatan 7');
INSERT INTO Kunder VALUES('Filip', 'Filip.Johansson@gmail.com', '0707654321', 'Filipgatan 8');
INSERT INTO Kunder VALUES('Hanna', 'Hanna.Fredriksson@hotmail.com', '0709876543', 'Hannagatan 9');
INSERT INTO Kunder VALUES('Liam', 'Liam.Hansson@live.se', '0701234567', 'Liamgatan 10');
INSERT INTO Kunder VALUES('Noah', 'Noah.Hasa@gmail.com', '0707654321', 'Noahsvägen 11');
INSERT INTO Kunder VALUES('Ella', 'Ella.Friberg@hotmail.com', '0709876543', 'Ellagatan 12');
INSERT INTO Kunder VALUES('Alva', 'Alva.Lindström@gmail.com', '0701234567', 'Alvagatan 13');
INSERT INTO Kunder VALUES('Wilma', 'Wilma.Koskinen@live.se', '0707654321', 'Wilmagatan 14');
INSERT INTO Kunder VALUES('Hugo', 'Hugo.Samos@hotmail.com', '0709876543', 'Hugovägen 15');

GO
-- antal ordrar kopplat till en butik och en bok. Kan vara intressant att se hur många ordrar som har lagts på en viss bok i en viss butik
CREATE TABLE AntalOrdrar(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ButikID INT,
    BokISBN CHAR(13),
    Datum DATE,
    KunderID INT,
    FOREIGN KEY (ButikID) REFERENCES Butiker(Id),
    FOREIGN KEY (BokISBN) REFERENCES Böcker(ISBN),
    FOREIGN KEY (KunderID) REFERENCES Kunder(Id)
);

INSERT INTO AntalOrdrar VALUES(3, '9789113139913', '2025-01-22', 1);
INSERT INTO AntalOrdrar VALUES(1, '9789113139906', '2024-07-18', 2);
INSERT INTO AntalOrdrar VALUES(2, '9780007203543', '2005-10-17', 3);
INSERT INTO AntalOrdrar VALUES(1, '9780008376130', '2005-10-17', 3);
INSERT INTO AntalOrdrar VALUES(3, '9780007203567', '2005-10-17', 3);
INSERT INTO AntalOrdrar VALUES(2, '9789170533860', '2012-02-01', 4);
INSERT INTO AntalOrdrar VALUES(1, '9789113093659', '2018-10-31', 5);
INSERT INTO AntalOrdrar VALUES(2, '9789129697858', '2015-03-02', 6);
INSERT INTO AntalOrdrar VALUES(3, '9789129678154', '2011-08-15', 7);
INSERT INTO AntalOrdrar VALUES(2, '9789129729887', '2021-05-28', 8);
INSERT INTO AntalOrdrar VALUES(2, '9789129698442', '2015-05-22', 9);
INSERT INTO AntalOrdrar VALUES(3, '9789113139913', '2025-01-22', 10);
INSERT INTO AntalOrdrar VALUES(3, '9789113139906', '2024-07-18', 11);
INSERT INTO AntalOrdrar VALUES(1, '9780007203543', '2005-10-17', 12);
INSERT INTO AntalOrdrar VALUES(3, '9780008376130', '2005-10-17', 13);
INSERT INTO AntalOrdrar VALUES(1, '9780007203567', '2005-10-17', 14);
INSERT INTO AntalOrdrar VALUES(3, '9789170533860', '2012-02-01', 15);
INSERT INTO AntalOrdrar VALUES(2, '9789113093659', '2018-10-31', 16);
INSERT INTO AntalOrdrar VALUES(3, '9789129697858', '2015-03-02', 17);
INSERT INTO AntalOrdrar VALUES(1, '9789129678154', '2011-08-15', 18);
INSERT INTO AntalOrdrar VALUES(2, '9789129729887', '2021-05-28', 19);

GO

 
-- Här får man bara åldern -- alltså, hur gamla författarna skulle varit i år. 
-- Några utav författarna lever inte idag och därav höga siffror.
CREATE VIEW TitlarPerFörfattare AS
SELECT TOP 1
    CONCAT(Författare.Förnamn, ' ', Författare.Efternamn) AS Namn,
    DATEDIFF(YEAR, Författare.[Födelsedatum], GETDATE()) AS Ålder,
    COUNT(DISTINCT Böcker.ISBN) AS Titlar,
    SUM(Böcker.Pris * LagerSaldo.Antal) AS Lagervärde
FROM
    Författare
    INNER JOIN BokFörfattare 
        ON Författare.Id = BokFörfattare.FörfattareID
    INNER JOIN Böcker
        ON BokFörfattare.ISBN = Böcker.ISBN 
    INNER JOIN LagerSaldo
        ON Böcker.ISBN = LagerSaldo.ISBN
    GROUP BY
        Författare.Förnamn, Författare.Efternamn, Författare.[Födelsedatum]
    ORDER BY Författare.Födelsedatum ASC;

GO

-- Denna vy kan vara användbar för bokhandeln för att se vilka genrer som säljer bäst i varje butik. 
-- Det kan hjälpa dem att anpassa sin marknadsföring och sitt sortiment för att öka försäljningen.
-- Genom att se vilka genrer som säljer bäst kan de också identifiera trender och kundpreferenser. Går såklart att utveckla mer genom att till exempel titta på vilka genrer som säljer bäst baserat på kön, betyg eller ålder. Behövs mer data dock.

CREATE VIEW BokhandelVyn AS
SELECT TOP 10
    Butiker.Namn AS Butik,
    Genrer.Namn AS Genre,
    COUNT(AntalOrdrar.BokISBN) AS AntalBöckerSålda
FROM 
    Butiker
    INNER JOIN AntalOrdrar 
        ON Butiker.Id = AntalOrdrar.ButikID
    INNER JOIN Böcker
        ON AntalOrdrar.BokISBN = Böcker.ISBN
    INNER JOIN BokGenrer
        ON Böcker.ISBN = BokGenrer.ISBN
    INNER JOIN Genrer
        ON BokGenrer.GenreId = Genrer.Id
       
GROUP BY 
    Butiker.Namn, Genrer.Namn
ORDER BY 
    Butiker.Namn, COUNT(AntalOrdrar.BokISBN) DESC;


GO



-- FLyttabok Stored Procedure
-- En stored procedure där till exempel butiker/anställda kan flytta böcker om nödvändigt. 
-- Tar hänsyn till att det ska finnas tillräckligt med böcker i den butik som boken ska flyttas ifrån.
-- Tar även hänsyn till att det ska finnas en bok i den butik som boken ska flyttas till.
-- Allt ska ske i en transaktion så att det inte blir några problem om något går fel. 
-- Om något går fel så ska rollback transaction köras.
-- Om allt går bra så ska commit transaction köras.
-- Om något går fel så ska ett felmeddelande skrivas ut.

CREATE PROCEDURE FlyttaBok (
    @ISBN CHAR(13),
    @FrånButikId INT,
    @TillButikId INT,
    @Antal INT = 1
)

AS
BEGIN 
    SET NOCOUNT ON;

    BEGIN TRY
    BEGIN TRANSACTION;

    -- Kontrollerar att det finns tillräckligt med böcker i den butik som boken ska flyttas ifrån
    IF NOT EXISTS(
        SELECT 1 FROM LagerSaldo
        WHERE ISBN = @ISBN AND ButikID = @FrånButikId AND Antal >= @Antal
    )

    BEGIN
        PRINT 'Inte tillräckligt med böcker i den butik som boken ska flyttas ifrån.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

-- Uppdaterar lagersaldot i den butik som boken ska flyttas ifrån
-- och i den butik som boken ska flyttas till
UPDATE LagerSaldo SET Antal = Antal - @Antal WHERE ISBN = @ISBN AND ButikID = @FrånButikId;
UPDATE LagerSaldo SET Antal = Antal + @Antal WHERE ISBN = @ISBN AND ButikID = @TillButikId;


COMMIT TRANSACTION;
PRINT 'Transaction successful!';
END TRY

BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END
    
    PRINT 'Ett fel inträffade: ' + ERROR_MESSAGE();
END CATCH
END

GO

-- Testa att flytta en bok från en butik till en annan
-- Flytta 1 bok från butik 1 till butik 2
EXEC FlyttaBok '9789113139913', 1, 2, 2;




-- spara en bakup av hela filen för inlämning


BACKUP DATABASE Bokhandel
TO DISK = 'C:\Code\Databaser-Tobias-ObergAI24\Bokhandel.bak'
WITH NOFORMAT, NOINIT,
NAME = 'Bokhandel-Full Database Backup'
GO

