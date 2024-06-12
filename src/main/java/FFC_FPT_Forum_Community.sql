-- Tạo cơ sở dữ liệu
CREATE DATABASE FFCFPTerForumComunity;
GO

-- Sử dụng cơ sở dữ liệu
USE FFCFPTerForumComunity;
GO
-- Bảng Users
CREATE TABLE Users (
    Username NVARCHAR(100) NOT NULL, -- Tên người dùng, bắt buộc
    User_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho người dùng
    User_email NVARCHAR(255) NOT NULL, -- Email người dùng, bắt buộc
    User_password NVARCHAR(255) NOT NULL, -- Mật khẩu người dùng, bắt buộc
    User_role INT CHECK(User_role IN (0,1,2,3)) NOT NULL, -- Vai trò của người dùng, bắt buộc 0= ban,1 user,2 manager,3 admin
    User_fullName NVARCHAR(255), -- Họ và tên đầy đủ của người dùng
    User_wallet DECIMAL(10, 2) DEFAULT 0.00, -- Số dư trong ví của người dùng, mặc định là 0.00
    User_avatar NVARCHAR(255), -- Ảnh đại diện của người dùng
    User_story NVARCHAR(255), -- Câu chuyện của người dùng
    User_rank INT DEFAULT 0, -- Hạng của người dùng, mặc định là 0
    User_score INT DEFAULT 0, -- Điểm của người dùng, mặc định là 0
    User_createDate DATETIME DEFAULT GETDATE(), -- Ngày tạo người dùng, mặc định là ngày hiện tại
    User_sex NVARCHAR(10), -- Giới tính của người dùng
    User_activeStatus BIT DEFAULT 0, -- Trạng thái hoạt động của người dùng, mặc định là 0-off, 1-on
    CONSTRAINT chk_email CHECK (User_email LIKE '%@fpt.edu.vn' OR User_email LIKE '%@fe.edu.vn'), -- Kiểm tra định dạng email
    CONSTRAINT unique_email UNIQUE (User_email),
    CONSTRAINT chk_sex CHECK (User_sex IN ('Male', 'Female', 'Other')), -- Kiểm tra giới tính có hợp lệ không
    CONSTRAINT unique_name UNIQUE (Username)
);
GO
-- Bảng Shop
CREATE TABLE Shop (
    Owner_id INT NOT NULL, -- ID của chủ
    Shop_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho shop
    Shop_name NVARCHAR(255) NOT NULL, -- Tên của shop, bắt buộc
    Shop_phone NVARCHAR(20) NOT NULL, -- Số điện thoại của shop, bắt buộc
    Shop_campus NVARCHAR(255) NOT NULL, -- Cơ sở của shop, bắt buộc
    Description NVARCHAR(255), -- Mô tả về shop
    Image NVARCHAR(255), -- Ảnh bìa của shop
    Status BIT DEFAULT 0, -- Trạng thái hoạt động của SHOP, mặc định là 0-off, 1-on
    CONSTRAINT fk_user_shop FOREIGN KEY (Owner_id) REFERENCES Users(User_id) -- Tham chiếu đến User_id trong bảng Users
);
GO
-- Bảng Category
CREATE TABLE Category (
    Category_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho danh mục
    Category_name NVARCHAR(255) NOT NULL, -- Tên của danh mục, bắt buộc
    Category_description NVARCHAR(255) -- Mô tả về danh mục
);
-- Bảng Product (cập nhật thêm cột Category_id và khóa ngoại)
CREATE TABLE Product (
    Shop_id INT NOT NULL, -- ID của shop, bắt buộc
    Description NVARCHAR(255), -- Mô tả về sản phẩm
    Product_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho sản phẩm
    Product_name NVARCHAR(255) NOT NULL, -- Tên của sản phẩm, bắt buộc
    Product_price DECIMAL(10, 2) NOT NULL, -- Giá của sản phẩm, bắt buộc
    Stock_quantity INT NOT NULL, -- Số lượng tồn kho của sản phẩm, bắt buộc
    Category_id INT, -- ID của danh mục sản phẩm
    CONSTRAINT fk_shop_product FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id), -- Tham chiếu đến Shop_id trong bảng Shop
    CONSTRAINT fk_category_product FOREIGN KEY (Category_id) REFERENCES Category(Category_id) -- Tham chiếu đến Category_id trong bảng Category
);
GO

-- Bảng Discount
CREATE TABLE Discount (
    Code NVARCHAR(50) NOT NULL, -- Mã giảm giá, bắt buộc
    Owner_id INT , -- ID của user
    Shop_id INT , -- ID của shop
    Discount_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho giảm giá
    Discount_percent DECIMAL(5, 2) NOT NULL, -- Phần trăm giảm giá, bắt buộc
    Valid_from DATE NOT NULL, -- Ngày bắt đầu hiệu lực của giảm giá, bắt buộc
    Valid_to DATE NOT NULL, -- Ngày hết hạn của giảm giá, bắt buộc
    Usage_limit INT DEFAULT 0, -- Giới hạn số lần sử dụng (0 có nghĩa là không giới hạn)
    Usage_count INT DEFAULT 0, -- Theo dõi số lần mã giảm giá đã được sử dụng
    CONSTRAINT fk_shop_discount FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id), -- Tham chiếu đến Shop_id trong bảng Shop
    CONSTRAINT fk_user_discount FOREIGN KEY (Owner_id) REFERENCES Users(User_id) -- Tham chiếu đến User_id trong bảng Users
);
GO

-- Bảng Order
CREATE TABLE [Order] (
    User_id INT NOT NULL, -- ID của người dùng, bắt buộc
    Order_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho đơn hàng
    Order_date DATETIME DEFAULT GETDATE(), -- Ngày đặt hàng, mặc định là ngày hiện tại
    Order_status NVARCHAR(50) CHECK (Order_status IN ('Null','Pending','Accept','Completed','Cancelled')) NOT NULL, -- Trạng thái của đơn hàng
    Total_amount DECIMAL(10, 2) NOT NULL, -- Tổng số tiền của đơn hàng, bắt buộc
    CONSTRAINT fk_user_order FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Tham chiếu đến User_id trong bảng Users
);
GO

-- Bảng OrderItem
CREATE TABLE OrderItem (
    OrderItem_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho chi tiết đơn hàng
    Order_id INT NOT NULL, -- ID của đơn hàng, bắt buộc
    Product_id INT NOT NULL, -- ID của sản phẩm, bắt buộc
    Quantity INT NOT NULL, -- Số lượng sản phẩm, bắt buộc
    Unit_price DECIMAL(10, 2) NOT NULL, -- Giá mỗi đơn vị sản phẩm, bắt buộc
    CONSTRAINT fk_order_orderitem FOREIGN KEY (Order_id) REFERENCES [Order](Order_id), -- Tham chiếu đến Order_id trong bảng Order
    CONSTRAINT fk_product_orderitem FOREIGN KEY (Product_id) REFERENCES Product(Product_id) -- Tham chiếu đến Product_id trong bảng Product
);
GO

-- Bảng Title
CREATE TABLE Title (
    Title_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho danh hiệu
    Title_name NVARCHAR(255) NOT NULL -- Tên của danh hiệu, bắt buộc
);
GO

-- Bảng UserTitle
CREATE TABLE UserTitle (
    UserTitle_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho bảng trung gian
    User_id INT NOT NULL, -- ID của người dùng, bắt buộc
    Title_id INT NOT NULL, -- ID của danh hiệu, bắt buộc
    CONSTRAINT fk_user_usertitle FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Tham chiếu đến User_id trong bảng Users
    CONSTRAINT fk_title_usertitle FOREIGN KEY (Title_id) REFERENCES Title(Title_id) -- Tham chiếu đến Title_id trong bảng Title
);
GO

-- Bảng FriendShip
CREATE TABLE FriendShip (
    Friendship_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho mối quan hệ bạn bè
    User_id INT NOT NULL, -- id của người dùng, không được null
    Friend_id INT NOT NULL, -- id của bạn bè, không được null
    Request_status NVARCHAR(50) NOT NULL, -- Trạng thái yêu cầu, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người dùng
    FOREIGN KEY (Friend_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến bạn bè
    UNIQUE (User_id, Friend_id) -- Đảm bảo mỗi cặp người dùng chỉ có một mối quan hệ bạn bè duy nhất
);
GO

-- Bảng Notification
CREATE TABLE Notification (
    Notification_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho thông báo
    User_id INT NOT NULL, -- id của người dùng nhận thông báo, không được null
    Message NVARCHAR(MAX) NOT NULL, -- Nội dung thông báo, không được null
    Created_at DATETIME DEFAULT GETDATE(), -- Ngày và giờ tạo thông báo, mặc định là ngày và giờ hiện tại
    Status NVARCHAR(50) DEFAULT 'Unread', -- Trạng thái của thông báo, mặc định là 'Unread' (chưa đọc)
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Tham chiếu khóa ngoại tới bảng Users
);
GO

-- Bảng Event
CREATE TABLE Event (
    Event_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho sự kiện
    Title NVARCHAR(255) NOT NULL, -- Tiêu đề sự kiện, không được null
    Description NVARCHAR(MAX), -- Mô tả sự kiện
    Start_date DATETIME NOT NULL, -- Ngày bắt đầu sự kiện, không được null
    End_date DATETIME NOT NULL, -- Ngày kết thúc sự kiện, không được null
    Location NVARCHAR(255), -- Địa điểm tổ chức sự kiện
    Created_by INT NOT NULL, -- Người tạo sự kiện, không được null
    Created_at DATETIME DEFAULT GETDATE(), -- Ngày và giờ tạo sự kiện, mặc định là ngày và giờ hiện tại
    FOREIGN KEY (Created_by) REFERENCES Users(User_id) -- Tham chiếu khóa ngoại tới bảng Users
);
GO
-- Tạo bảng Payment: lưu thông tin về thanh toán
CREATE TABLE Payment (
    Payment_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho thanh toán
    Payment_detail NVARCHAR(255) NOT NULL, -- Chi tiết thanh toán, không được null
    User_id INT NOT NULL, -- id của người dùng, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người dùng
);
GO
-- Tạo bảng Combo_ads: lưu thông tin về gói quảng cáo
CREATE TABLE Combo_ads (
    Adsdetail_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho gói quảng cáo
    Content NVARCHAR(255) NOT NULL, -- Nội dung gói quảng cáo, không được null
    budget DECIMAL(10, 2) NOT NULL -- Ngân sách của gói quảng cáo, không được null
);
GO
-- Tạo bảng Ads: lưu thông tin về quảng cáo
CREATE TABLE Ads (
    Ads_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho quảng cáo
    Adsdetail_id INT NOT NULL, -- id chi tiết gói quảng cáo, không được null
    Content NVARCHAR(255) NOT NULL, -- Nội dung quảng cáo, không được null
    Image NVARCHAR(255), -- Hình ảnh quảng cáo
    User_id INT NOT NULL, -- id của người đăng quảng cáo, không được null
    FOREIGN KEY (Adsdetail_id) REFERENCES Combo_ads(Adsdetail_id), -- Khóa ngoại tham chiếu đến chi tiết gói quảng cáo
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người dùng
);
GO
-- Tạo bảng Message: lưu thông tin về tin nhắn
CREATE TABLE Message (
    Message_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho tin nhắn
    From_id INT NOT NULL, -- id người gửi, không được null
    To_id INT NOT NULL, -- id người nhận, không được null
    MessageText NVARCHAR(255) NOT NULL, -- Nội dung tin nhắn, không được null
    TimeStamp DATETIME DEFAULT GETDATE(), -- Thời gian gửi tin nhắn, mặc định là ngày hiện tại
    FOREIGN KEY (From_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người gửi
    FOREIGN KEY (To_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người nhận
);
GO
-- Tạo bảng Feeback: lưu thông tin về phản hồi
CREATE TABLE Feedback (
    Feedback_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho phản hồi
    Feedback_detail NVARCHAR(255) NOT NULL, -- Chi tiết phản hồi
    Feedback_title NVARCHAR(255) NOT NULL, -- Tiêu đề phản hồi, không được null
	User_id INT NOT NULL, -- id người gửi, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người gửi
);
GO
-- Tạo bảng Topic: lưu thông tin về chủ đề
CREATE TABLE Topic (
    Topic_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho chủ đề
    Topic_name NVARCHAR(255) NOT NULL, -- Tên chủ đề, không được null
    Description NVARCHAR(255) -- Mô tả chủ đề
);
GO
-- Tạo bảng Group: lưu thông tin về nhóm
CREATE TABLE [Group] (
    Group_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho nhóm
    Creater_id INT NOT NULL, -- id của người tạo nhóm, không được null
    Group_name NVARCHAR(255) NOT NULL, -- Tên nhóm, không được null
    Group_description NVARCHAR(255), -- Mô tả nhóm
	Image NVARCHAR(255),
	memberCount INT DEFAULT 0,
	Status NVARCHAR(25),
    FOREIGN KEY (Creater_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người tạo nhóm
);
GO
-- Tạo bảng MemberGroup: lưu thông tin về thành viên của nhóm
CREATE TABLE MemberGroup (
    MemberGroup_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho thành viên nhóm
    User_id INT NOT NULL, -- id của người dùng, không được null
    Group_id INT NOT NULL, -- id của nhóm, không được null
    Status NVARCHAR(50) NOT NULL, -- Trạng thái của thành viên trong nhóm, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người dùng
    FOREIGN KEY (Group_id) REFERENCES [Group](Group_id) -- Khóa ngoại tham chiếu đến nhóm
);
GO
CREATE TABLE GroupChatMessage (
    GroupChatMessage_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho tin nhắn trong nhóm
    Group_id INT NOT NULL, -- ID của nhóm, không được null
    From_id INT NOT NULL, -- ID người gửi tin nhắn, không được null
    MessageText NVARCHAR(255) NOT NULL, -- Nội dung tin nhắn, không được null
    TimeStamp DATETIME DEFAULT GETDATE(), -- Thời gian gửi tin nhắn, mặc định là ngày hiện tại
    FOREIGN KEY (Group_id) REFERENCES [Group](Group_id), -- Khóa ngoại tham chiếu đến nhóm
    FOREIGN KEY (From_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người gửi tin nhắn
);
GO
-- Tạo bảng Post: lưu thông tin về bài viết
CREATE TABLE Post (
    Post_id INT IDENTITY(1,1) PRIMARY KEY,
    User_id INT NOT NULL,
    Group_id INT,
    Topic_id INT,
    Content NVARCHAR(255) NOT NULL,
    createDate NVARCHAR(20), -- Đổi kiểu dữ liệu của createDate thành NVARCHAR
    Status NVARCHAR(50),
    postStatus NVARCHAR(50),
    Reason NVARCHAR(255),
    FOREIGN KEY (User_id) REFERENCES Users(User_id),
    FOREIGN KEY (Group_id) REFERENCES [Group](Group_id),
    FOREIGN KEY (Topic_id) REFERENCES Topic(Topic_id)
);
GO
-- Tạo bảng Comment: lưu thông tin về bình luận của bài viết
CREATE TABLE Comment (
    Comment_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho bình luận
    Post_id INT, -- id của bài viết mà bình luận thuộc về
    User_id INT, -- id của người bình luận
    Content NVARCHAR(255), -- Nội dung bình luận
    Date DATETIME DEFAULT GETDATE(), -- Thời gian bình luận, mặc định là ngày hiện tại
    FOREIGN KEY (Post_id) REFERENCES Post(Post_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người bình luận
);
GO
-- Tạo bảng Rate: lưu thông tin về đánh giá của bài viết
CREATE TABLE Rate (
    Rate_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho đánh giá
    Post_id INT, -- id của bài viết được đánh giá
    User_id INT, -- id của người đánh giá
    TypeRate INT, -- Loại đánh giá
    FOREIGN KEY (Post_id) REFERENCES Post(Post_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người đánh giá
);
GO
-- Tạo bảng PostReport: lưu thông tin về báo cáo của bài viết
CREATE TABLE Report (
    Report_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho báo cáo
    Reporter_id INT, -- id của người báo cáo
    User_id INT, -- id của người dùng bị báo cáo
    Shop_id INT, -- id của shop bị báo cáo
    Post_id INT, -- id của bài viết bị báo cáo
    Reason NVARCHAR(255), -- Lý do báo cáo
    Status NVARCHAR(50), -- Trạng thái của báo cáo
    FOREIGN KEY (Reporter_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người báo cáo
    FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người dùng bị báo cáo
    FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id), -- Khóa ngoại tham chiếu đến shop
    FOREIGN KEY (Post_id) REFERENCES Post(Post_id) -- Khóa ngoại tham chiếu đến bài viết bị báo cáo
);
GO
CREATE TABLE UserFollow (
    UserFollow_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho bảng UserFollow
    User_id INT NOT NULL, -- id của người dùng theo dõi, không được null
    Event_id INT, -- id của sự kiện được theo dõi
    Topic_id INT, -- id của chủ đề được theo dõi
    FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Tham chiếu khóa ngoại tới bảng Users
    FOREIGN KEY (Event_id) REFERENCES Event(Event_id), -- Tham chiếu khóa ngoại tới bảng Event
    FOREIGN KEY (Topic_id) REFERENCES Topic(Topic_id) -- Tham chiếu khóa ngoại tới bảng Topic
);
GO
CREATE TABLE Upload (
    Upload_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho ảnh của bài viết
    Post_id INT, -- ID của bài viết, khóa ngoại tham chiếu đến bảng Post
	Event_id INT,
	Product_id INT,
    UploadPath NVARCHAR(255) NOT NULL, -- Đường dẫn hoặc tên file của ảnh
    FOREIGN KEY (Product_id) REFERENCES Product(Product_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (Post_id) REFERENCES Post(Post_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (Event_id) REFERENCES Event(Event_id) -- Khóa ngoại tham chiếu đến bài viết
);
GO
CREATE VIEW PostWithUploadAndComment AS
SELECT 
    p.Post_id,
    p.User_id,
    p.Group_id,
    p.Topic_id,
    p.Content,
    p.createDate,
    p.Status,
    p.postStatus,
    p.Reason,
    u.UploadPath AS UploadPath,
    c.Comment_id,
    c.User_id AS Comment_User_id,
    c.Content AS Comment_Content,
    c.Date AS Comment_Date
FROM 
    Post p
LEFT JOIN 
    Upload u ON p.Post_id = u.Post_id
LEFT JOIN 
    Comment c ON p.Post_id = c.Post_id;
GO
CREATE OR ALTER VIEW GroupView AS
SELECT 
    g.Group_id,
    g.Creater_id,
    g.Group_name,
    g.Group_description,
    g.Image,
	g.Status,
    mg.MemberGroup_id,
	mg.Status AS Group_status,
    u.User_id,
    u.User_email,
    u.User_fullName,
    u.User_avatar,
    u.User_activeStatus,
    p.Post_id,
    p.User_id AS Post_user_id,
    p.Group_id AS Post_group_id,
    p.Content AS Post_content,
    p.createDate AS Post_createDate,
    p.Status AS Post_status,
    c.Comment_id,
    c.Post_id AS Comment_post_id,
    c.User_id AS Comment_user_id,
    c.Content AS Comment_content,
    c.Date AS Comment_date,
    up.Upload_id,
    up.Event_id,
    up.UploadPath,
    up.Post_id AS Upload_post_id,
   (SELECT COUNT(*) FROM MemberGroup mg WHERE mg.Group_id = g.Group_id AND mg.Status IN ('approved', 'host')) AS memberCount  -- Đếm số thành viên nhóm
FROM [Group] g
LEFT JOIN MemberGroup mg ON g.Group_id = mg.Group_id
LEFT JOIN Users u ON mg.User_id = u.User_id
LEFT JOIN Post p ON g.Group_id = p.Group_id
LEFT JOIN Comment c ON p.Post_id = c.Post_id
LEFT JOIN Upload up ON p.Post_id = up.Post_id;

GO
-- Chèn dữ liệu mẫu vào bảng Users
INSERT INTO Users (Username, User_email, User_password, User_role, User_fullName, User_wallet, User_avatar, User_story, User_rank, User_score, User_sex, User_activeStatus)
VALUES 
('ban', 'duoc1@fpt.edu.vn', '123', 0,N'Thành Được', 100.00, Null, Null, 1, 10, 'Male', 1),
('swpduoc', 'duoc@fpt.edu.vn', '123', 1, N'Thành Được', 100.00, Null, Null, 1, 10, 'Male', 1),
('swpdiem', 'diem@fe.edu.vn', '123', 1, N'Thị Diễm', 200.00, Null, Null, 2, 20, 'Female', 1),
('swpphuc', 'phuc@fe.edu.vn', '123', 2, N'Hoàng Phúc', 200.00, Null, Null, 2, 20, 'Male', 1),
('swptrung', 'trung@fe.edu.vn', '123', 3, N'Quốc Trung', 200.00, Null, Null, 2, 20, 'Male', 1),
('vipswptruong', 'truong@fpt.edu.vn', '123', 3, N'Hải Trường', 500.00, Null, Null, 3, 30, 'Male', 1);

-- Chèn dữ liệu mẫu vào bảng Shop
INSERT INTO Shop (Owner_id, Shop_name, Shop_phone, Shop_campus, Description, Image, Status)
VALUES 
(1, 'Shop A', '0123456789', 'Campus A', 'Description for Shop A', NULL, 1),
(2, 'Shop B', '0123456789', 'Campus B', 'Description for Shop B', NULL, 1),
(3, 'Shop C', '0123456789', 'Campus C', 'Description for Shop C', NULL, 1),
(4, 'Shop D', '0123456789', 'Campus D', 'Description for Shop D', NULL, 1),
(5, 'Shop E', '0123456789', 'Campus E', 'Description for Shop E', NULL, 1),
(6, 'Shop F', '0123456789', 'Campus F', 'Description for Shop F', NULL, 1);

-- Chèn dữ liệu mẫu vào bảng Product
INSERT INTO Product (Shop_id, Description, Product_name, Product_price, Stock_quantity)
VALUES 
(1, 'Description for Product 1', 'Product 1', 10.50, 100),
(1, 'Description for Product 2', 'Product 2', 20.75, 200),
(2, 'Description for Product 3', 'Product 3', 15.25, 150),
(3, 'Description for Product 4', 'Product 4', 30.00, 120),
(4, 'Description for Product 5', 'Product 5', 25.50, 180),
(5, 'Description for Product 6', 'Product 6', 12.75, 220),
(6, 'Description for Product 7', 'Product 7', 18.50, 170);

-- Chèn dữ liệu mẫu vào bảng Discount
INSERT INTO Discount (Code, Owner_id, Shop_id, Discount_percent, Valid_from, Valid_to, Usage_limit, Usage_count)
VALUES 
('DISC10', NULL, 1, 10.00, '2024-05-01', '2024-05-31', 100, 0),
('DISC20', NULL, 2, 20.00, '2024-05-01', '2024-05-31', 200, 0),
('DISC30', NULL, 3, 30.00, '2024-05-01', '2024-05-31', 300, 0),
('DISC40', NULL, 4, 40.00, '2024-05-01', '2024-05-31', 400, 0),
('DISC50', NULL, 5, 50.00, '2024-05-01', '2024-05-31', 500, 0),
('DISC60', NULL, 6, 60.00, '2024-05-01', '2024-05-31', 600, 0);

-- Chèn dữ liệu mẫu vào bảng Order
INSERT INTO [Order] (User_id, Order_date, Order_status, Total_amount)
VALUES 
(1, '2024-05-15', 'Completed', 100.00),
(2, '2024-05-16', 'Completed', 150.00),
(3, '2024-05-17', 'Completed', 200.00),
(4, '2024-05-18', 'Completed', 250.00),
(5, '2024-05-19', 'Completed', 300.00),
(6, '2024-05-20', 'Completed', 350.00);

-- Chèn dữ liệu mẫu vào bảng OrderItem
INSERT INTO OrderItem (Order_id, Product_id, Quantity, Unit_price)
VALUES 
(1, 1, 5, 10.50),
(1, 2, 10, 20.75),
(2, 3, 7, 15.25),
(2, 4, 8, 30.00),
(3, 5, 6, 25.50),
(3, 6, 12, 12.75),
(4, 1, 4, 10.50),
(4, 3, 9, 15.25),
(5, 2, 11, 20.75),
(5, 4, 5, 30.00),
(6, 1, 8, 10.50),
(6, 5, 15, 25.50);
GO
-- Chèn dữ liệu mẫu vào bảng Combo_ads
INSERT INTO Combo_ads (Content, budget)
VALUES 
('Combo 1: Small Ad Package', 100.00),
('Combo 2: Medium Ad Package', 200.00),
('Combo 3: Large Ad Package', 300.00);
GO
-- Chèn dữ liệu mẫu vào bảng Ads
INSERT INTO Ads (Adsdetail_id, Content, Image, User_id)
VALUES 
(1, 'Small Ad Content', NULL, 1),
(2, 'Medium Ad Content', NULL, 2),
(3, 'Large Ad Content', NULL, 3);
GO
-- Chèn dữ liệu mẫu vào bảng Message
INSERT INTO Message (From_id, To_id, MessageText)
VALUES 
(1, 2, 'Hello, how are you?'),
(2, 1, 'I''m fine, thanks!');
GO
-- Chèn dữ liệu mẫu vào bảng Feedback
INSERT INTO Feedback (Feedback_detail, Feedback_title, User_id)
VALUES 
('Great service!', 'Service Feedback', 1),
('Product quality could be improved.', 'Product Feedback', 2);
GO
-- Chèn dữ liệu mẫu vào bảng Topic
INSERT INTO Topic (Topic_name, Description)
VALUES 
('Technology', 'Discussions related to technology'),
('Food', 'Discussions related to food');
GO
-- Chèn dữ liệu mẫu vào bảng UserTopic
INSERT INTO UserTopic (User_id, Topic_id)
VALUES 
(1, 1),
(2, 2),
(3, 1);
GO
-- Chèn dữ liệu mẫu vào bảng Group
INSERT INTO [Group] (Creater_id, Group_name, Group_description, Image, memberCount)
VALUES 
(1, 'Technology Enthusiasts', 'A group for tech lovers', NULL, 10),
(2, 'Foodies', 'A group for food enthusiasts', NULL, 15);
GO
-- Chèn dữ liệu mẫu vào bảng MemberGroup
INSERT INTO MemberGroup (User_id, Group_id, Status)
VALUES 
(1, 1, 'Active'),
(2, 1, 'Active'),
(3, 2, 'Active');
GO
-- Chèn dữ liệu mẫu vào bảng GroupChatMessage
INSERT INTO GroupChatMessage (Group_id, From_id, MessageText)
VALUES 
(1, 1, 'Welcome to the Technology Enthusiasts group!'),
(1, 2, 'Thank you! Excited to be here.');
GO
-- Chèn dữ liệu mẫu vào bảng Post
INSERT INTO Post (User_id, Group_id, Topic_id, Content, Status, postStatus)
VALUES 
(1, Null, Null, 'Excited to join this group!', 'Active', 'Friends'),
(2, Null, Null, 'Looking for recommendations on good restaurants.', 'Active', 'Public'),
(1, 1, NULL, 'Excited to join this group!', 'Active', 'Friends'),
(2, Null, 1, 'Looking for recommendations on good restaurants.', 'Active', 'Public'),
(2, Null, 2,'Looking for recommendations on good restaurants.', 'Active', 'Public');


GO
-- Chèn dữ liệu mẫu vào bảng Comment
INSERT INTO Comment (Post_id, User_id, Content)
VALUES 
(1, 2, 'Welcome!'),
(2, 1, 'I recommend trying the Italian restaurant downtown.');
GO
-- Chèn dữ liệu mẫu vào bảng Rate
INSERT INTO Rate (Post_id, User_id, TypeRate)
VALUES 
(1, 2, 1),
(2, 1, 1);
GO
-- Chèn dữ liệu mẫu vào bảng Report
INSERT INTO Report (Reporter_id, User_id, Shop_id, Post_id, Reason, Status)
VALUES 
(1, 2, NULL, NULL, 'Inappropriate content', 'Pending'),
(2, 1, NULL, NULL, 'Spam', 'Pending');
GO
-- Chèn dữ liệu mẫu vào bảng UserFollow
INSERT INTO UserFollow (User_id, Event_id, Topic_id)
VALUES 
(1, NULL, 1),
(2, NULL, 2),
(3, NULL, 1);
GO

SELECT * FROM PostWithUploadAndComment;
-- Xem thông tin từ bảng Users
SELECT * FROM Users;
-- Xem thông tin từ bảng FriendShip
SELECT * FROM FriendShip;
-- Xem thông tin từ bảng Notification
SELECT * FROM Notification;
-- Xem thông tin từ bảng Event
SELECT * FROM Event;
-- Xem thông tin từ bảng Payment
SELECT * FROM Payment;
-- Xem thông tin từ bảng Combo_ads
SELECT * FROM Combo_ads;
-- Xem thông tin từ bảng Ads
SELECT * FROM Ads;
-- Xem thông tin từ bảng Message
SELECT * FROM Message;
-- Xem thông tin từ bảng Feeback
SELECT * FROM Feedback;
-- Xem thông tin từ bảng Topic
SELECT * FROM Topic;
-- Xem thông tin từ bảng UserTopic
SELECT * FROM UserTopic;   
-- Xem thông tin từ bảng [Group]
SELECT * FROM [Group];
-- Xem thông tin từ bảng MemberGroup
SELECT * FROM MemberGroup;
-- Xem thông tin từ bảng Post
SELECT * FROM Post;
-- Xem thông tin từ bảng Comment
SELECT * FROM Comment;
-- Xem thông tin từ bảng Rate
SELECT * FROM Rate;
-- Xem thông tin từ bảng PostReport
SELECT * FROM Report;

SELECT * FROM Shop;

SELECT * FROM [Order];

SELECT * FROM OrderItem;

SELECT * FROM Title;

SELECT * FROM UserTitle;

SELECT * FROM Product;

SELECT * FROM Discount;

SELECT * FROM GroupChatMessage;

SELECT * FROM Upload;

SELECT * FROM UserFollow

SELECT * FROM GroupView