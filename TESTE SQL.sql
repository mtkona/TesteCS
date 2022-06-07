-- ----------------------------------------------
-- Criação de tabelas
-- ----------------------------------------------

-- tabelas - modelagem e estrutura
-- TB_ClientSector  (Public, Private)
-- TB_Trade (value of trade, Client Sector)


CREATE TABLE TB_ClientSector
(ID_ClientSector Smallint NOT NULL IDENTITY(1,1),
 DS_ClientSector Varchar(20) NOT NULL, 
 CONSTRAINT PK_ClientSector PRIMARY KEY (ID_ClientSector));
GO
 

CREATE TABLE TB_Trade
(ID_Trade Int NOT NULL IDENTITY(1,1), 
 VL_TradeValue decimal(15,8) NOT NULL, 
 ID_ClientSector SmallInt NOT NULL,
 CONSTRAINT PK_Trade PRIMARY KEY (ID_Trade),
 CONSTRAINT FK_ClientSector FOREIGN KEY (ID_ClientSector)
        REFERENCES TB_ClientSector (ID_ClientSector));
GO


-- ----------------------------------------------
-- Stored Procedures
-- ----------------------------------------------

-- Client Sector
CREATE PROCEDURE PRC_ClientSector_Insert (@DS_ClientSector varchar(20)) 
AS
BEGIN
  INSERT INTO TB_ClientSector(DS_ClientSector) VALUES (@DS_ClientSector);
END;
GO

CREATE PROCEDURE PRC_ClientSector_Update(
@ID_ClientSector smallint,
@DS_ClientSector varchar(20))
AS 
BEGIN
  UPDATE TB_ClientSector
     SET DS_CLIENTSECTOR  = @DS_ClientSector
    WHERE ID_CLIENTSECTOR = @ID_ClientSector;
END;

GO

CREATE PROCEDURE PRC_ClientSector_Delete(
@ID_ClientSector smallint)
AS 
BEGIN
  DELETE FROM TB_ClientSector
    WHERE ID_CLIENTSECTOR = @ID_ClientSector;
END;
GO


-- Trade
CREATE PROCEDURE PRC_Trade_Insert(
@VL_TradeValue decimal(15,8),
@ID_ClientSector smallint)
AS 
BEGIN
  INSERT INTO TB_Trade(VL_TradeValue, ID_ClientSector) VALUES (@VL_TradeValue, @ID_ClientSector);
END;
GO

CREATE PROCEDURE PRC_Trade_Update(
@ID_Trade int,
@VL_TradeValue decimal(15,8),
@ID_ClientSector smallint)
AS 
BEGIN
  UPDATE TB_Trade SET
     VL_TradeValue = @VL_TradeValue,
     ID_ClientSector = @ID_ClientSector
  WHERE ID_Trade = @ID_Trade;

END;
GO

CREATE PROCEDURE PRC_Trade_Delete(
@ID_Trade int)
AS 
BEGIN
  DELETE FROM TB_Trade  WHERE ID_Trade = @ID_Trade;

END;
GO

CREATE PROCEDURE PRC_Trade_Select
AS 
BEGIN
  SELECT T.VL_TradeValue,
         CASE WHEN T.VL_TradeValue<1000000 AND DS_ClientSector = 'Public' THEN 'LOWRISK'
         WHEN T.VL_TradeValue>1000000 AND DS_ClientSector = 'Public' THEN 'MEDIUMRISK'
         WHEN T.VL_TradeValue>1000000 AND DS_ClientSector = 'Private' THEN 'HIGHRISK'
         END
    FROM TB_Trade T
  INNER JOIN TB_ClientSector CS
    ON CS.ID_ClientSector = T.ID_ClientSector

END;
GO

-- ----------------------------------------------
-- Execução do processo para teste
-- ----------------------------------------------
exec PRC_ClientSector_Insert 'Public'
exec PRC_ClientSector_Insert 'Private'
exec PRC_Trade_Insert 2000000,2
exec PRC_Trade_Insert 400000,1
exec PRC_Trade_Insert 500000,1
exec PRC_Trade_Insert 3000000,1
exec PRC_Trade_Select