USE [KGERPLive]
GO
/****** Object:  StoredProcedure [dbo].[Accounting_KGLiabilities]    Script Date: 7/14/2021 9:39:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Accounting_KGLiabilities]
	@FromDate DateTime,
	@CompanyId int
AS
BEGIN
	SELECT * FROM (SELECT Head2.Id, Head2.AccName as AccName, SUM(VoucherDetail.CreditAmount)- SUM(VoucherDetail.DebitAmount) as Balance, Head2.OrderNo as OrderNo 
	FROM VoucherDetail
    INNER JOIN Voucher on VoucherDetail.VoucherId = Voucher.VoucherId
    INNER JOIN HeadGL on VoucherDetail.AccountHeadId = HeadGL.Id
    INNER JOIN Head5 on HeadGL.ParentId = Head5.Id
    INNER JOIN Head4 on Head5.ParentId = Head4.Id
    INNER JOIN Head3 on Head4.ParentId = Head3.Id
    INNER JOIN Head2 on Head3.ParentId = Head2.Id
    INNER JOIN Head1 on Head2.ParentId = Head1.Id

 where Head1.AccCode = 2 And Head2.AccCode != 24 and Head2.CompanyId = @CompanyId
  and VoucherDetail.IsActive=1
 and Voucher.VoucherDate  <=  @FromDate
   group by Head2.AccName, Head2.Id, Head2.OrderNo) A
   WHERE A.Balance != 0
   order by A.OrderNo
END




GO
/****** Object:  StoredProcedure [dbo].[Accounting_KGCurrentLiabilities]    Script Date: 7/14/2021 9:38:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Accounting_KGCurrentLiabilities]
	@FromDate DateTime,
	@CompanyId int
AS
BEGIN
	SELECT * FROM (SELECT Head3.Id, Head3.AccName as AccName, (SUM(VoucherDetail.CreditAmount) - SUM(VoucherDetail.DebitAmount)) as Balance, Head3.OrderNo as OrderNo 
	FROM VoucherDetail
    INNER JOIN Voucher on VoucherDetail.VoucherId = Voucher.VoucherId
    INNER JOIN HeadGL on VoucherDetail.AccountHeadId = HeadGL.Id
    INNER JOIN Head5 on HeadGL.ParentId = Head5.Id
    INNER JOIN Head4 on Head5.ParentId = Head4.Id
    INNER JOIN Head3 on Head4.ParentId = Head3.Id
    INNER JOIN Head2 on Head3.ParentId = Head2.Id
 where Head2.AccCode = 24 and Head2.CompanyId = @CompanyId
  and VoucherDetail.IsActive = 1
 and Voucher.VoucherDate <= @FromDate
   group by Head3.AccName, Head3.Id, Head3.OrderNo) A
   WHERE A.Balance != 0
   order by A.OrderNo

END




GO
/****** Object:  StoredProcedure [dbo].[Accounting_KGCurrentAsset]    Script Date: 7/14/2021 9:37:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Accounting_KGCurrentAsset]
	@FromDate DateTime,
	@CompanyId int
AS
BEGIN
	SELECT * FROM (SELECT Head3.Id, Head3.AccName as AccName, SUM(VoucherDetail.DebitAmount) - SUM(VoucherDetail.CreditAmount) as Balance, Head3.OrderNo as OrderNo 
	FROM VoucherDetail
    INNER JOIN Voucher on VoucherDetail.VoucherId = Voucher.VoucherId
    INNER JOIN HeadGL on VoucherDetail.AccountHeadId = HeadGL.Id
    INNER JOIN Head5 on HeadGL.ParentId = Head5.Id
    INNER JOIN Head4 on Head5.ParentId = Head4.Id
    INNER JOIN Head3 on Head4.ParentId = Head3.Id
    INNER JOIN Head2 on Head3.ParentId = Head2.Id
 where Head2.AccCode = 13 and Head2.CompanyId= @CompanyId and VoucherDetail.IsActive=1
 and Voucher.VoucherDate  <=  @FromDate
   group by Head3.AccName, Head3.Id, Head3.OrderNo) A
   Where A.Balance != 0 
   order by A.OrderNo
END



GO
/****** Object:  StoredProcedure [dbo].[Accounting_KGAsset]    Script Date: 7/14/2021 9:35:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Accounting_KGAsset]
	@FromDate DateTime,
	@CompanyId int
AS
BEGIN
	SELECT * FROM (SELECT Head2.Id, Head2.AccName as AccName, SUM(VoucherDetail.DebitAmount) - SUM(VoucherDetail.CreditAmount) as Balance, Head2.OrderNo as OrderNo 
	FROM VoucherDetail
    INNER JOIN Voucher on VoucherDetail.VoucherId = Voucher.VoucherId
    INNER JOIN HeadGL on VoucherDetail.AccountHeadId = HeadGL.Id
    INNER JOIN Head5 on HeadGL.ParentId = Head5.Id
    INNER JOIN Head4 on Head5.ParentId = Head4.Id
    INNER JOIN Head3 on Head4.ParentId = Head3.Id
    INNER JOIN Head2 on Head3.ParentId = Head2.Id
    INNER JOIN Head1 on Head2.ParentId = Head1.Id

 where Head1.AccCode = 1 And Head2.AccCode != 13 and Head2.CompanyId = @CompanyId
  and VoucherDetail.IsActive=1
 and Voucher.VoucherDate  <=  @FromDate -- '2021/07/18'
   group by Head2.AccName, Head2.Id, Head2.OrderNo) A
   WHERE A.Balance != 0
   order by A.OrderNo
END
