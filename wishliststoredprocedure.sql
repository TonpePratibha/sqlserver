use BookstoreDB;
select * from users;
select * from wishlist;
select * from books;
create Procedure getwishlist 
as 
begin 
select * from wishlist;
end;

exec getwishlist;




DROP PROCEDURE IF EXISTS getwishlistbyuserid;


CREATE PROCEDURE getwishlistbyuserid
    @userid INT
AS
BEGIN
 SET NOCOUNT ON;
    SELECT 
        b.Id AS BookId,
        b.BookName,
        b.Author,
        b.Description,
        b.Price,
        b.DiscountPrice,
        b.Quantity,
        b.BookImage
    FROM Wishlist w
    INNER JOIN Books b ON w.BookId = b.Id
    WHERE w.AddedBy = @userid;
END

exec getwishlistbyuserid 5



ALTER PROCEDURE getwishlistbyuserid
    @userid INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        
        SELECT 
            b.Id AS BookId,
            b.BookName,
            b.Author,
            b.Description,
            b.Price,
            b.DiscountPrice,
            b.Quantity,
            b.BookImage
        FROM Wishlist w
        INNER JOIN Books b ON w.BookId = b.Id
        WHERE w.AddedBy = @userid;

        COMMIT;

        
        PRINT 'Wishlist retrieved successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK;

        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

exec getwishlistbyuserid 5




ALTER PROCEDURE getwishlistbyuserid
    @userid INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM Users WHERE Id = @userid)
        BEGIN     
            RAISERROR('User not found.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Wishlist WHERE AddedBy = @userid)
        BEGIN         
            PRINT 'Wishlist is empty.';
            SELECT TOP 0
                b.Id AS BookId,
                b.BookName,
                b.Author,
                b.Description,
                b.Price,
                b.DiscountPrice,
                b.Quantity,
                b.BookImage
            FROM Books b
            WHERE 1 = 0; 
            COMMIT TRANSACTION;
            RETURN;
        END
        SELECT 
            b.Id AS BookId,
            b.BookName,
            b.Author,
            b.Description,
            b.Price,
            b.DiscountPrice,
            b.Quantity,
            b.BookImage
        FROM Wishlist w
        INNER JOIN Books b ON w.BookId = b.Id
        WHERE w.AddedBy = @userid;

        COMMIT TRANSACTION;
        PRINT 'Wishlist retrieved successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

exec getwishlistbyuserid 5



create procedure deletewishlistbyuserid
@userid int,
@bookid int
as
begin 
delete from wishlist where AddedBy=@userid and BookId=@bookid;
end

exec deletewishlistbyuserid 5,3;


alter procedure deletewishlistbyuserid
    @userid int,
    @bookid int
as
begin
    set nocount on;
    begin try
        begin transaction;
        delete from Wishlist 
        where AddedBy = @userid and BookId = @bookid;
        if @@ROWCOUNT = 0
        begin
            rollback;
            select 'Error' as Status, 'No wishlist item found to delete.' as Message;
            return;
        end
        commit;
        select 'Success' as Status, 'Wishlist item deleted successfully.' as Message;
    end try
    begin catch
        rollback;
        select 'Error' as Status, ERROR_MESSAGE() as Message;
   end catch
end;
exec deletewishlistbyuserid 5,3;





select * from users;
select * from Wishlist;
insert into wishlist values(19,7),(19,5);


CREATE PROCEDURE AddToWishlist
    @UserId INT,
    @BookId INT
AS
BEGIN
    SET NOCOUNT ON;
 
    IF NOT EXISTS (SELECT 1 FROM Books WHERE Id = @BookId)
        RETURN;

    IF NOT EXISTS (SELECT 1 FROM Users WHERE Id = @UserId)
        RETURN;

    IF EXISTS (SELECT 1 FROM Cart WHERE PurchasedBy = @UserId AND BookId = @BookId)
        RETURN;

    IF EXISTS (SELECT 1 FROM Wishlist WHERE AddedBy = @UserId AND BookId = @BookId)
        RETURN;

    
    INSERT INTO Wishlist (AddedBy, BookId)
    VALUES (@UserId, @BookId);
END;

exec AddToWishlist 5 ,20;


ALTER PROCEDURE AddToWishlist
    @UserId INT,
    @BookId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
		IF NOT EXISTS (SELECT 1 FROM Books WHERE Id = @BookId)
        BEGIN
            ROLLBACK;
           SELECT 'Error' AS Status, 'Book does not exist.' AS Message;
            RETURN;
        END    
        IF NOT EXISTS (SELECT 1 FROM Users WHERE Id = @UserId)
        BEGIN
            ROLLBACK;
            SELECT 'Error' AS Status, 'User does not exist.' AS Message;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM Cart WHERE PurchasedBy = @UserId AND BookId = @BookId)
        BEGIN
            ROLLBACK;
            SELECT 'Error' AS Status, 'This book has already been in cart.' AS Message;
            RETURN;
        END

      
        IF EXISTS (SELECT 1 FROM Wishlist WHERE AddedBy = @UserId AND BookId = @BookId)
        BEGIN
            ROLLBACK;
            SELECT 'Error' AS Status, 'This book is already in your wishlist.' AS Message;
            RETURN;
        END

       
        INSERT INTO Wishlist (AddedBy, BookId)
        VALUES (@UserId, @BookId);

        COMMIT;
        SELECT 'Success' AS Status, 'Book added to wishlist successfully.' AS Message;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        SELECT 'Error' AS Status, ERROR_MESSAGE() AS Message;
    END CATCH
END;

exec AddToWishlist 5,3
