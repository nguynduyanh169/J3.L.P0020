USE [SimpleBlog]
GO
ALTER TABLE [dbo].[Comment] DROP CONSTRAINT [FK_Comment_Article]
GO
ALTER TABLE [dbo].[Comment] DROP CONSTRAINT [FK_Comment_Account]
GO
ALTER TABLE [dbo].[Article] DROP CONSTRAINT [FK_Article_Account]
GO
ALTER TABLE [dbo].[Account] DROP CONSTRAINT [FK_Account_Role]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 15/12/2021 7:41:21 PM ******/
DROP TABLE [dbo].[Role]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 15/12/2021 7:41:21 PM ******/
DROP TABLE [dbo].[Comment]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 15/12/2021 7:41:21 PM ******/
DROP TABLE [dbo].[Article]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 15/12/2021 7:41:21 PM ******/
DROP TABLE [dbo].[Account]
GO
USE [master]
GO
/****** Object:  Database [SimpleBlog]    Script Date: 15/12/2021 7:41:21 PM ******/
DROP DATABASE [SimpleBlog]
GO
/****** Object:  Database [SimpleBlog]    Script Date: 15/12/2021 7:41:21 PM ******/
CREATE DATABASE [SimpleBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SimpleBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SimpleBlog.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SimpleBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SimpleBlog_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SimpleBlog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SimpleBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleBlog] SET RECOVERY FULL 
GO
ALTER DATABASE [SimpleBlog] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SimpleBlog] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SimpleBlog', N'ON'
GO
USE [SimpleBlog]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 15/12/2021 7:41:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NULL,
	[fullName] [nvarchar](255) NULL,
	[role] [int] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Article]    Script Date: 15/12/2021 7:41:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[articleId] [nvarchar](255) NOT NULL,
	[title] [nvarchar](255) NULL,
	[shortDescription] [nvarchar](max) NULL,
	[articleContent] [nvarchar](max) NULL,
	[author] [nvarchar](255) NULL,
	[authorName] [nvarchar](255) NULL,
	[postingDate] [datetime] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[articleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 15/12/2021 7:41:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[commentId] [nvarchar](255) NOT NULL,
	[commentContent] [nvarchar](max) NULL,
	[articleId] [nvarchar](255) NULL,
	[status] [int] NULL,
	[commentBy] [nvarchar](255) NULL,
	[commentDate] [datetime] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[commentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 15/12/2021 7:41:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleId] [int] NOT NULL,
	[roleName] [nvarchar](255) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'anhnd16091998@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'D anh', 1, 1)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'baobao1@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Bao Ho', 1, 1)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'chubao@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Bao Le', 2, 1)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'cuonghx@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Xuan Cuong', 1, 1)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'Hoquangbao1@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Bao Le Quang', 1, 1)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'kaje@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Hai Hoang', 1, 0)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'sadthuseetinh@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Hai Hoang', 1, 1)
INSERT [dbo].[Account] ([email], [password], [fullName], [role], [status]) VALUES (N'tuongdm@gmail.com', N'8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414', N'Tuong Manh', 1, 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'07e76358-0780-422d-8615-192f95bfca8e', N'Hoi dap flutter', N'flutter error', N'Em vừa gặp trường hợp khi rút dây sau khi debug xong thì app của mình không thể request lên server để lấy response về. Mọi người có cao kiến gì không ạ
', N'baobao1@gmail.com', N'Bao Ho', CAST(N'2021-12-09 11:15:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'0d7193cb-ae57-483c-8e75-6602d0782206', N'CH Play', N'up app lên google play store', N'Mình nên xuất bản luôn hay tạo thử nghiệm mở rộng.Thời gian up app trung bình bao nhiu lâu, có mẹo nào nhanh hơn ko. Mình up app gần tuần rồi mà vẫn chưa duyệt', N'baobao1@gmail.com', N'Bao Ho', CAST(N'2021-12-08 10:51:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'16715b04-fd95-4c02-bd5d-cd0573354fb9', N'Tim viec', N'Tim viec flutter', N'Không biết group mình có team nào tuyển remote. Mình hiện tại cũng đã làm qua flutter 1 năm. Chưa tốt nghiệp có thể làm fulltime không biết group mình có team nào tuyển ko', N'cuonghx@gmail.com', N'Xuan Cuong', CAST(N'2021-12-13 20:36:32.613' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'29f43927-5c50-47b8-8416-79fd18d37771', N'Tuyen dung', N'tim nhan su', N'
Hi. Mình cần 1 bạn Build Thêm bớt sửa Flutter project có sẵn đã có backend. Code mới mua full document.ib m ạ', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-03 07:39:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'2ad1036e-d95f-490e-afc7-4b3dd7f229ca', N'Tim ung vien', N'Tuyen dung flutter', N'A cần tuyển 1 bạn chịu khó, kinh nghiệm thì không yêu cầu cao, biết design app khi cần.
Làm việc online fulltime. Ib a nhé trao đổi kĩ hơn', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-13 20:57:32.457' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'2eb8a4ba-7318-4176-9831-20dc54bd16df', N'Hỏi flutter 2', N'flutter hoi dap', N'các pro cho mình hỏi ngủ tý. Làm sao để bấm vào 1 button (hình điện thoạt chẳng hạn) thì chuyển qua phần gọi đt và gọi đến số mình chỉ định. Ai biết chỉ em với. không thì cho em từ khóa search với ah. thank anh em', N'baobao1@gmail.com', N'Bao Ho', CAST(N'2021-12-01 10:05:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'3bf6a7d2-a677-4e80-ad96-e6a67138f067', N'firestore', N'upload to firestore', N'Có bác nào làm việc với isolate vụ upload ảnh lên firestore bằng isolate chưa ạ. Em đang gặp issue khi upload lên firestore không inialize được Firebase. Nguyên nhân có thể là do gọi channel method bị null vì isolate nó k gọi đến native code để lấy config được', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-11 10:58:49.703' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'5918e4d3-624b-4fe8-983d-ea13257a9322', N'flutter wallet', N'tích hợp wallet', N'Hi mn, không biết flutter có hỗ trợ kết nối với các wallet như metamask hoặc ví nào khác không ạ.', N'Hoquangbao1@gmail.com', N'Bao Le Quang', CAST(N'2021-12-15 19:32:28.867' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'5abe01b0-7241-4141-a3b9-afd82b417aa9', N'test', N'test', N'test', N'cuonghx@gmail.com', N'Xuan Cuong', CAST(N'2021-12-15 08:00:00.937' AS DateTime), -1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'698b2548-9238-420c-a9d8-7d96353dcd5d', N'Google Play', N'Up app lên gg play', N'E đang gặp vấn đề đẩy app lên chợ android nguyên nhân do policy mới bên android. Nhờ các cao nhân hoặc đội ngũ chuyên đẩy app lên chợ android hỗ trợ.', N'baobao1@gmail.com', N'Bao Ho', CAST(N'2021-12-12 08:55:38.977' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'6accc8a7-daae-43a9-8dbd-b249f54c88c9', N'Tim nhan vien', N'Tuyen dung flutter', N'CTy mình đang lập team mobile, bác nào muốn lead team
không inbox em?. Cty Nhật ở Mễ Trì ạ!', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-11 15:10:10.003' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'966696ec-5956-11ec-bf63-0242ac130002', N'Android', N'flutter', N'Chào anh chị, anh chị cho em hỏi em đã có chút kiến thức về Android Native, giờ muốn qua flutter. Nên học sâu về Native hơn hay là qua flutter luôn ạ.', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-07 22:11:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'a794d701-de88-4b1c-85a0-710dca20cd73', N'flutter app', N'weather app', N'Mình đang làm cái app thời tiết.
Ae cho hỏi làm sao để mình hiện cái app lên màn hình khoáhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-13 20:49:12.367' AS DateTime), -1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', N'Job react', N'Tìm việc react', N'Mình có kinh nghiệm 2 năm react js, native, js, flutter', N'Hoquangbao1@gmail.com', N'Bao Le Quang', CAST(N'2021-12-14 21:11:28.893' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'bfd12270-69a3-456a-82b2-e1e5197fc01d', N'Tạo FAB', N'Flutter FAB', N'Tôi đã tạo một FAB với notch ở màn hình 1. Khi tôi chuyển sang màn hình 2 rồi về lại thì notch không còn. Phải hot reload, notch mới xuất hiện trở lại. Làm sao để notch không bị biến mất khi qua lại giữa các màn hình. Xin cảm ơ', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-11-09 11:11:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'c698c21a-f765-498e-9252-a4e5096dd1fb', N'Job fullstack', N'Tuyen dung flutter', N'HCM- CẦN THÊM REMOTE FLUTTER va JAVA THEO TỪNG DỰ ÁN, IB THÔNG TIN GIÚP MÌNH NHÉ.Job fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstackJob fullstack', N'cuonghx@gmail.com', N'Xuan Cuong', CAST(N'2021-12-15 07:54:33.187' AS DateTime), -1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'cd32c979-c876-43c8-99df-7e63f8793b3b', N'flutter job', N'Tim viec flutter', N'HCM- CẦN THÊM REMOTE FLUTTER THEO TỪNG DỰ ÁN, IB THÔNG TIN GIÚP MÌNH NHÉ.', N'cuonghx@gmail.com', N'Xuan Cuong', CAST(N'2021-12-15 07:56:56.347' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'ce656163-d716-49be-ba4d-324a043556ed', N'Flutter Web View', N'Web View', N'Hi mn. Em có bài toán thế này. Dẫn từ Flutter sang 1 webview, sau đó web đó hoạt động một số tác vụ và trả về data, và bên mobile nhận data đó. thì hướng làm thế nào ạ? các cao nhân cho e xin chỉ giáo với keyword ạ. cơ bản cũng giống kiểu đăng nhập bằng tài khoản google nhưng gg có sdk rồi. còn tự mình làm thì thế nào được nhỉ?', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-11-10 12:00:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'de9eb1b4-5957-11ec-bf63-0242ac130002', N'Firebase', N'Push noti', N'Chào mọi người, mọi người dành chút thời gian cho em hỏi xíu ạ, em đang gặp vấn đề khi tạo push notification khi có cuộc gọi đến, ví dụ như zalo có cuộc gọi đến nhưng ta đang ở trong một app khác thì nó chỉ đẩy một notify, để thông báo có cuộc gọi kèm theo button nghe, từ chối, hiện tại thì em đang không biết làm như nào, bác nào làm rồi hoặc có key sreach hoặc  slution nào thì chỉ cho em với ạ, em cảm ơn
', N'baobao1@gmail.com', N'Bao Ho', CAST(N'2021-12-06 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'e31ce88d-dac2-4925-b572-b130e8239e27', N'test', N'test', N'test', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-15 08:08:55.907' AS DateTime), -1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'e3e8f76d-1478-402d-b3b5-88650f5a94f9', N'job onl', N'tìm flutter online', N'Ai muốn làm thêm online khi rảnh về flutter thì inbox nha
', N'cuonghx@gmail.com', N'Xuan Cuong', CAST(N'2021-12-14 19:43:00.800' AS DateTime), 1)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [articleContent], [author], [authorName], [postingDate], [status]) VALUES (N'f6e9b50f-bce5-42c1-a0a1-e42cc0b590d9', N'php to flutter', N'khac nhau giua php va flutter', N'Từ web php chuyển qua flutter được ko nhỉ. Có khác nhau nhiều ko ta.', N'sadthuseetinh@gmail.com', N'Hai Hoang', CAST(N'2021-12-12 08:50:05.950' AS DateTime), 1)
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'11e755a2-1185-41d4-ac36-9288b95b18f1', N'heloo', N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', 1, N'cuonghx@gmail.com', CAST(N'2021-12-15 07:52:07.610' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'1481d7a6-5ce1-4d61-a6ee-584e31df2e55', N'ib minh nhe 0336125544', N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', 1, N'cuonghx@gmail.com', CAST(N'2021-12-15 07:51:38.897' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'2f859ce6-2417-4c6d-8c1d-e2173a318ed7', N'test', N'698b2548-9238-420c-a9d8-7d96353dcd5d', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-13 20:24:16.180' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'3166e675-99ec-4412-9f21-ebfcee0cc057', N'ok', N'698b2548-9238-420c-a9d8-7d96353dcd5d', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-13 20:24:11.330' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'342f0157-1e50-4394-93e9-9a0bb5395284', N'ok sadthuseetinh', N'cd32c979-c876-43c8-99df-7e63f8793b3b', 1, N'cuonghx@gmail.com', CAST(N'2021-12-15 07:59:08.143' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'3eafdc1e-4058-4d61-bcba-d9bad001b0c6', N'mình tuyển nha ib mình 0983456723', N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-14 21:12:38.250' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'3f635003-7ea8-4ce8-a3ef-71abd5b196a1', N'alo cau', N'3bf6a7d2-a677-4e80-ad96-e6a67138f067', 1, N'tuongdm@gmail.com', CAST(N'2021-12-11 15:11:55.383' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'3f6e4878-23dc-4aca-897e-20faac85b042', N'có ai ko', N'e3e8f76d-1478-402d-b3b5-88650f5a94f9', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-14 19:51:08.410' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'3fea80f2-ada4-4668-ba12-39418f0df4fc', N'ok', N'cd32c979-c876-43c8-99df-7e63f8793b3b', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-15 08:17:44.243' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'46cc1221-4627-479d-9ded-f73dd8e30b3a', N'ib mình nhé ', N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', 1, N'Hoquangbao1@gmail.com', CAST(N'2021-12-15 19:32:44.677' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'4756dd5c-59c2-11ec-bf63-0242ac130002', N'Test', N'07e76358-0780-422d-8615-192f95bfca8e', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-09 13:59:00.000' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'546f1a5c-a7e4-4ef4-a2ce-0caeb4e79527', N'heloo', N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', 1, N'cuonghx@gmail.com', CAST(N'2021-12-15 07:52:08.473' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'5b7ce976-5466-4aac-8afa-7127aaf60a8c', N'hay', N'698b2548-9238-420c-a9d8-7d96353dcd5d', 1, N'cuonghx@gmail.com', CAST(N'2021-12-13 20:35:45.740' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'63430f21-eb9c-483b-b5e1-09f5ae7e2726', N'Tessst', N'07e76358-0780-422d-8615-192f95bfca8e', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-10 14:02:00.000' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'7c87f1ea-afc6-427e-b2a9-ce69d0acc893', N'alo', N'bbc2390d-1874-4999-8bac-54a4aeaa3f82', 1, N'cuonghx@gmail.com', CAST(N'2021-12-15 07:51:59.073' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'9856bcf7-321b-42f3-8e7a-d937e205fff1', N'mình đây', N'2ad1036e-d95f-490e-afc7-4b3dd7f229ca', 1, N'Hoquangbao1@gmail.com', CAST(N'2021-12-14 21:10:38.977' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'9c2b0c87-d2cc-4bd8-88d4-47782893d238', N'hi ib mình', N'5918e4d3-624b-4fe8-983d-ea13257a9322', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-15 19:36:02.367' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'a301e8d7-976e-497f-84fd-034ab1e0411f', N'hi mn', N'07e76358-0780-422d-8615-192f95bfca8e', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-11 09:35:03.403' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'b4a4010b-ea1f-4e94-9c43-41220100b1a0', N'hi', N'cd32c979-c876-43c8-99df-7e63f8793b3b', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-15 08:15:20.780' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'bc1bde10-9e3b-422b-93cd-59078fa038c7', N'alo', N'3bf6a7d2-a677-4e80-ad96-e6a67138f067', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-11 10:59:29.423' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'c75c6b3b-56c4-41a4-8540-7753d6a17411', N'cute wibu', N'de9eb1b4-5957-11ec-bf63-0242ac130002', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-11 09:29:37.267' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'e1724ae1-5c03-4b58-813a-64cb3213a9d8', N'Mình ứng tuyển nha', N'e3e8f76d-1478-402d-b3b5-88650f5a94f9', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-14 19:51:30.290' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'faed4159-2b03-46fb-bf4b-dc0764735ba0', N'ok', N'f6e9b50f-bce5-42c1-a0a1-e42cc0b590d9', 1, N'baobao1@gmail.com', CAST(N'2021-12-12 08:56:34.390' AS DateTime))
INSERT [dbo].[Comment] ([commentId], [commentContent], [articleId], [status], [commentBy], [commentDate]) VALUES (N'ff9b2272-e349-4357-aa00-b5a5824f5209', N'alo minh 0982333456', N'cd32c979-c876-43c8-99df-7e63f8793b3b', 1, N'sadthuseetinh@gmail.com', CAST(N'2021-12-15 07:58:32.230' AS DateTime))
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (1, N'member')
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (2, N'admin')
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([role])
REFERENCES [dbo].[Role] ([roleId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Account] FOREIGN KEY([author])
REFERENCES [dbo].[Account] ([email])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_Account]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Account] FOREIGN KEY([commentBy])
REFERENCES [dbo].[Account] ([email])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Account]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Article] FOREIGN KEY([articleId])
REFERENCES [dbo].[Article] ([articleId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Article]
GO
USE [master]
GO
ALTER DATABASE [SimpleBlog] SET  READ_WRITE 
GO
