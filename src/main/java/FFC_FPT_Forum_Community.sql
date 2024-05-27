-- Tạo cơ sở dữ liệu
CREATE DATABASE FFCFPTerForumComunity;
GO

-- Sử dụng cơ sở dữ liệu
USE FFCFPTerForumComunity;
GO
-- Bảng Users (Người Dùng)
CREATE TABLE Users (
    User_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho người dùng
    User_email NVARCHAR(255) NOT NULL, -- Email người dùng, bắt buộc
    User_password NVARCHAR(255) NOT NULL, -- Mật khẩu người dùng, bắt buộc
    User_role INT CHECK(User_role IN (0,1,2,3,4)) NOT NULL, -- Vai trò của người dùng, bắt buộc
    Username NVARCHAR(100) NOT NULL, -- Tên người dùng, bắt buộc
    User_fullName NVARCHAR(255), -- Họ và tên đầy đủ của người dùng
    User_wallet DECIMAL(10, 2) DEFAULT 0.00, -- Số dư trong ví của người dùng, mặc định là 0.00
    User_avatar NVARCHAR(255), -- Ảnh đại diện của người dùng
    User_story TEXT, -- Câu chuyện của người dùng
    User_rank INT DEFAULT 0, -- Hạng của người dùng, mặc định là 0
    User_score INT DEFAULT 0, -- Điểm của người dùng, mặc định là 0
    User_createDate DATETIME DEFAULT GETDATE(), -- Ngày tạo người dùng, mặc định là ngày hiện tại
    User_sex NVARCHAR(10), -- Giới tính của người dùng
    User_activeStatus BIT DEFAULT 0, -- Trạng thái hoạt động của người dùng, mặc định là 0-off, 1-on
    usernameVip NVARCHAR(100), -- Tên người dùng VIP
    CONSTRAINT chk_email CHECK (User_email LIKE '%@fpt.edu.vn' OR User_email LIKE '%@fe.edu.vn'), -- Kiểm tra định dạng email
    CONSTRAINT unique_email UNIQUE (User_email),
    CONSTRAINT chk_sex CHECK (User_sex IN ('Male', 'Female', 'Other')), -- Kiểm tra giới tính có hợp lệ không
    CONSTRAINT unique_name UNIQUE (Username)
);
GO
-- Bảng Shop (Cửa Hàng)
CREATE TABLE Shop (
    Shop_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho shop
    Shop_name NVARCHAR(255) NOT NULL, -- Tên của shop, bắt buộc
    Shop_phone NVARCHAR(20) NOT NULL, -- Số điện thoại của shop, bắt buộc
    Shop_campus NVARCHAR(255) NOT NULL, -- Cơ sở của shop, bắt buộc
    Shop_description TEXT, -- Mô tả về shop
    User_id INT NOT NULL, -- ID người dùng, bắt buộc
    CONSTRAINT fk_user_shop FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Tham chiếu đến User_id trong bảng Users
);
GO
-- Bảng Product (Sản Phẩm)
CREATE TABLE Product (
    Product_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho sản phẩm
    Product_name NVARCHAR(255) NOT NULL, -- Tên của sản phẩm, bắt buộc
    Product_description TEXT, -- Mô tả về sản phẩm
    Product_price DECIMAL(10, 2) NOT NULL, -- Giá của sản phẩm, bắt buộc
    Stock_quantity INT NOT NULL, -- Số lượng tồn kho của sản phẩm, bắt buộc
    Category NVARCHAR(100), -- Danh mục của sản phẩm
    Shop_id INT NOT NULL, -- ID của shop, bắt buộc
    CONSTRAINT fk_shop_product FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id) -- Tham chiếu đến Shop_id trong bảng Shop
);
GO
-- Bảng Discount (Giảm Giá)
CREATE TABLE Discount (
    Discount_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho giảm giá
    Shop_id INT NOT NULL, -- ID của shop, bắt buộc
    Code NVARCHAR(50) NOT NULL, -- Mã giảm giá, bắt buộc
    Discount_percent DECIMAL(5, 2) NOT NULL, -- Phần trăm giảm giá, bắt buộc
    Valid_from DATE NOT NULL, -- Ngày bắt đầu hiệu lực của giảm giá, bắt buộc
    Valid_to DATE NOT NULL, -- Ngày hết hạn của giảm giá, bắt buộc
    Usage_limit INT DEFAULT 0, -- Giới hạn số lần sử dụng (0 có nghĩa là không giới hạn)
    Usage_count INT DEFAULT 0, -- Theo dõi số lần mã giảm giá đã được sử dụng
    CONSTRAINT fk_shop_discount FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id) -- Tham chiếu đến Shop_id trong bảng Shop
);
GO
-- Bảng Order (Đơn Hàng)
CREATE TABLE [Order] (
    Order_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho đơn hàng
    User_id INT NOT NULL, -- ID của người dùng, bắt buộc
    Order_date DATETIME DEFAULT GETDATE(), -- Ngày đặt hàng, mặc định là ngày hiện tại
    Total_amount DECIMAL(10, 2) NOT NULL, -- Tổng số tiền của đơn hàng, bắt buộc
    Order_status NVARCHAR(50) CHECK (Order_status IN ('Pending', 'Completed', 'Cancelled')) NOT NULL, -- Trạng thái của đơn hàng
    CONSTRAINT fk_user_order FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Tham chiếu đến User_id trong bảng Users
);
GO
-- Bảng OrderItem (Chi Tiết Đơn Hàng)
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
-- Bảng Title (Danh Hiệu)
CREATE TABLE Title (
    Title_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho danh hiệu
    Title_name NVARCHAR(255) NOT NULL -- Tên của danh hiệu, bắt buộc
);
GO
-- Bảng UserTitle (Danh Hiệu Người Dùng)
CREATE TABLE UserTitle (
    UserTitle_id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự động tăng cho bảng trung gian
    User_id INT NOT NULL, -- ID của người dùng, bắt buộc
    Title_id INT NOT NULL, -- ID của danh hiệu, bắt buộc
    CONSTRAINT fk_user_usertitle FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Tham chiếu đến User_id trong bảng Users
    CONSTRAINT fk_title_usertitle FOREIGN KEY (Title_id) REFERENCES Title(Title_id) -- Tham chiếu đến Title_id trong bảng Title
);
GO
-- Tạo bảng FriendShip: lưu thông tin về mối quan hệ bạn bè
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
-- Tạo bảng Notification: lưu thông tin về thông báo
CREATE TABLE Notification (
    Notification_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho thông báo
    User_id INT NOT NULL, -- id của người dùng nhận thông báo, không được null
    Message NVARCHAR(MAX) NOT NULL, -- Nội dung thông báo, không được null
    Created_at DATETIME DEFAULT GETDATE(), -- Ngày và giờ tạo thông báo, mặc định là ngày và giờ hiện tại
    Status NVARCHAR(50) DEFAULT 'Unread', -- Trạng thái của thông báo, mặc định là 'Unread' (chưa đọc)
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Tham chiếu khóa ngoại tới bảng Users
);
GO
-- Tạo bảng Event: lưu thông tin về sự kiện
CREATE TABLE Event (
    Event_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho sự kiện
    Title NVARCHAR(255) NOT NULL, -- Tiêu đề của sự kiện, không được null
	Description TEXT, -- Mô tả sự kiện
    StartDate DATETIME NOT NULL, -- Ngày bắt đầu sự kiện, không được null
    EndDate DATETIME NOT NULL, -- Ngày kết thúc sự kiện, không được null
    User_id INT NOT NULL, -- id của người tạo sự kiện, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người dùng
);
GO
-- Tạo bảng Payment: lưu thông tin về thanh toán
CREATE TABLE Payment (
    Payment_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho thanh toán
    Payment_detail TEXT NOT NULL, -- Chi tiết thanh toán, không được null
    User_id INT NOT NULL, -- id của người dùng, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người dùng
);
GO
-- Tạo bảng Combo_ads: lưu thông tin về gói quảng cáo
CREATE TABLE Combo_ads (
    Adsdetail_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho gói quảng cáo
    Content TEXT NOT NULL, -- Nội dung gói quảng cáo, không được null
    budget DECIMAL(10, 2) NOT NULL -- Ngân sách của gói quảng cáo, không được null
);
GO
-- Tạo bảng Ads: lưu thông tin về quảng cáo
CREATE TABLE Ads (
    Ads_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho quảng cáo
    Adsdetail_id INT NOT NULL, -- id chi tiết gói quảng cáo, không được null
    Content TEXT NOT NULL, -- Nội dung quảng cáo, không được null
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
    MessageText TEXT NOT NULL, -- Nội dung tin nhắn, không được null
    TimeStamp DATETIME DEFAULT GETDATE(), -- Thời gian gửi tin nhắn, mặc định là ngày hiện tại
    FOREIGN KEY (From_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người gửi
    FOREIGN KEY (To_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người nhận
);
GO
-- Tạo bảng Feeback: lưu thông tin về phản hồi
CREATE TABLE Feedback (
    Feedback_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho phản hồi
    Feedback_detail TEXT NOT NULL, -- Chi tiết phản hồi
    Feedback_title NVARCHAR(255) NOT NULL, -- Tiêu đề phản hồi, không được null
	User_id INT NOT NULL, -- id người gửi, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người gửi
);
GO
-- Tạo bảng Topic: lưu thông tin về chủ đề
CREATE TABLE Topic (
    Topic_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho chủ đề
    Topic_name NVARCHAR(255) NOT NULL, -- Tên chủ đề, không được null
    Description TEXT -- Mô tả chủ đề
);
GO
-- Tạo bảng UserTopic: lưu thông tin về chủ đề của người dùng
CREATE TABLE UserTopic (
    UserTopic_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho chủ đề của người dùng
    User_id INT NOT NULL, -- id của người dùng, không được null
    Topic_id INT NOT NULL, -- id của chủ đề, không được null
    FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người dùng
    FOREIGN KEY (Topic_id) REFERENCES Topic(Topic_id) -- Khóa ngoại tham chiếu đến chủ đề
);
GO
-- Tạo bảng Group: lưu thông tin về nhóm
CREATE TABLE [Group] (
    Group_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho nhóm
    Creater_id INT NOT NULL, -- id của người tạo nhóm, không được null
    Group_name NVARCHAR(255) NOT NULL, -- Tên nhóm, không được null
    Group_description TEXT, -- Mô tả nhóm
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
    MessageText TEXT NOT NULL, -- Nội dung tin nhắn, không được null
    TimeStamp DATETIME DEFAULT GETDATE(), -- Thời gian gửi tin nhắn, mặc định là ngày hiện tại
    FOREIGN KEY (Group_id) REFERENCES [Group](Group_id), -- Khóa ngoại tham chiếu đến nhóm
    FOREIGN KEY (From_id) REFERENCES Users(User_id) -- Khóa ngoại tham chiếu đến người gửi tin nhắn
);
GO
-- Tạo bảng Post: lưu thông tin về bài viết
CREATE TABLE Post (
    Post_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho bài viết
    User_id INT NOT NULL, -- id của người đăng bài viết
    Group_id INT, -- id của nhóm mà bài viết thuộc về
    Topic_id INT, -- id của chủ đề mà bài viết thuộc về
    Content TEXT NOT NULL, -- Nội dung bài viết
    createDate DATETIME DEFAULT GETDATE(), -- Ngày tạo bài viết, mặc định là ngày hiện tại
    Status NVARCHAR(50), -- Trạng thái của bài viết
    postStatus NVARCHAR(50), -- Trạng thái bài viết (duyệt, chưa duyệt)
    Reason TEXT, -- Lý do (nếu có) của trạng thái bài viết
	FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người đăng bài viết
    FOREIGN KEY (Group_id) REFERENCES [Group](Group_id), -- Khóa ngoại tham chiếu đến nhóm
    FOREIGN KEY (Topic_id) REFERENCES Topic(Topic_id) -- Khóa ngoại tham chiếu đến chủ đề
);
GO
-- Tạo bảng Comment: lưu thông tin về bình luận của bài viết
CREATE TABLE Comment (
    Comment_id INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng cho bình luận
    Post_id INT, -- id của bài viết mà bình luận thuộc về
    User_id INT, -- id của người bình luận
    Content TEXT, -- Nội dung bình luận
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
    User_id INT , -- id của người dùng báo cáo
	Shop_id INT, -- id cua shop bi bao cao
    Post_id INT, -- id của bài viết bị báo cáo
    Reason TEXT, -- Lý do báo cáo
    Status NVARCHAR(50), -- Trạng thái của báo cáo
    FOREIGN KEY (User_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người báo cáo
    FOREIGN KEY (Reporter_id) REFERENCES Users(User_id), -- Khóa ngoại tham chiếu đến người báo cáo
    FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id), -- Khóa ngoại tham chiếu đến người báo cáo
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
	Shop_id INT,
	Comment_id INT,
	Product_id INT,
    UploadPath NVARCHAR(255) NOT NULL, -- Đường dẫn hoặc tên file của ảnh
    FOREIGN KEY (Comment_id) REFERENCES Comment(Comment_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (Product_id) REFERENCES Product(Product_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (Post_id) REFERENCES Post(Post_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (Shop_id) REFERENCES Shop(Shop_id), -- Khóa ngoại tham chiếu đến bài viết
    FOREIGN KEY (Event_id) REFERENCES Event(Event_id) -- Khóa ngoại tham chiếu đến bài viết
);
GO
INSERT INTO Users (User_email, User_password, User_role, Username, User_fullName, User_wallet, User_avatar, User_story, User_rank, User_score, User_sex, User_activeStatus, usernameVip)
VALUES 
    ('user1@fpt.edu.vn', '123', 0, 'user1', 'User One', 0.00, NULL, NULL, 0, 0, 'Male', 0, NULL),
    ('user2@fpt.edu.vn', '123', 1, 'user2', 'User Two', 0.00, NULL, NULL, 0, 0, 'Female', 0, NULL),
    ('user3@fpt.edu.vn', '123', 2, 'user3', 'User Three', 0.00, NULL, NULL, 0, 0, 'Other', 0, NULL),
    ('user4@fpt.edu.vn', '123', 3, 'user4', 'User Four', 0.00, NULL, NULL, 0, 0, 'Male', 0, NULL),
    ('user5@fpt.edu.vn', '123', 4, 'user5', 'User Five', 0.00, NULL, NULL, 0, 0, 'Female', 0, NULL);
GO
-- Thêm 3 shop với các giá trị Campus khác nhau
INSERT INTO Shop (Shop_name, Shop_phone, Shop_campus, Shop_description, User_id)
VALUES
    ('Shop One', '0123456789', 'FUDA', 'Description for Shop One', 1),
    ('Shop Two', '0987654321', 'HOLA', 'Description for Shop Two', 2),
    ('Shop Three', '0123987654', 'XAVALO', 'Description for Shop Three', 4);
GO
INSERT INTO Product (Product_name, Product_description, Product_price, Stock_quantity, Category, Shop_id)
VALUES 
    -- Sản phẩm cho shop có Shop_id là 1
    ('Product One Shop One', 'Description for Product One in Shop One', 10.00, 100, 'Category1', 1),
    ('Product Two Shop One', 'Description for Product Two in Shop One', 20.00, 150, 'Category2', 1),
    ('Product Three Shop One', 'Description for Product Three in Shop One', 30.00, 200, 'Category3', 1),

    -- Sản phẩm cho shop có Shop_id là 2
    ('Product One Shop Two', 'Description for Product One in Shop Two', 15.00, 110, 'Category1', 2),
    ('Product Two Shop Two', 'Description for Product Two in Shop Two', 25.00, 160, 'Category2', 2),
    ('Product Three Shop Two', 'Description for Product Three in Shop Two', 35.00, 210, 'Category3', 2),

    -- Sản phẩm cho shop có Shop_id là 3
    ('Product One Shop Three', 'Description for Product One in Shop Three', 20.00, 120, 'Category1', 3),
    ('Product Two Shop Three', 'Description for Product Two in Shop Three', 30.00, 170, 'Category2', 3),
    ('Product Three Shop Three', 'Description for Product Three in Shop Three', 40.00, 220, 'Category3', 3);
GO
-- Thêm danh hiệu
INSERT INTO Title (Title_name)
VALUES ('Học viên'), ('Cán bộ');
GO
-- Thêm mẫu dữ liệu vào bảng Topic
INSERT INTO Topic (Topic_name, Description) VALUES ('Technology', 'Discussion about technology topics'), ('Music', 'Discussion about music topics');
GO
-- Thêm mẫu dữ liệu vào bảng [Group]
INSERT INTO [Group] (Creater_id, Group_name, Group_description) VALUES (1, 'Technology Enthusiasts', 'A group for discussing technology topics'), (2, 'Music Lovers', 'A group for discussing music topics');
GO
-- Thêm mẫu dữ liệu vào bảng UserTopic (gán chủ đề cho người dùng)
INSERT INTO UserTopic (User_id, Topic_id) VALUES (1, 1), (2, 1), (3, 2);
GO
-- Thêm mẫu dữ liệu vào bảng UserTitle (gán danh hiệu cho người dùng)
INSERT INTO UserTitle (User_id, Title_id) VALUES (1, 1), (2, 1);
GO
-- Thêm mẫu dữ liệu vào bảng Post
INSERT INTO Post (User_id, Group_id, Topic_id, Content, Status, postStatus, Reason)
VALUES 
(1, NULL, 1, 'This is a sample post content.', 'Active', 'Approved', NULL),
(2, NULL, 2, 'Another sample post with group and topic.', 'Active', 'Pending', 'Under review');
GO
-- Insert dữ liệu mẫu vào bảng Comment
INSERT INTO Comment (Post_id, User_id, Content)
VALUES 
(1, 2, 'This is a sample comment on the first post.'),
(1, 1, 'Another comment on the second post.');
GO
-- Insert dữ liệu mẫu vào bảng Rate
INSERT INTO Rate (Post_id, User_id, TypeRate)
VALUES 
(1, 2, 5),
(2, 1, 4);
GO
-- Insert dữ liệu mẫu vào bảng Event
INSERT INTO Event (Title, Description, StartDate, EndDate, User_id)
VALUES 
    ('Tech Conference', 'Annual tech conference featuring industry experts.', '2024-06-15 09:00:00', '2024-06-17 18:00:00', 1),
    ('Music Festival', 'Three-day music festival showcasing various artists.', '2024-07-20 12:00:00', '2024-07-22 23:59:59', 2),
    ('Charity Gala', 'Fundraising gala for a local charity organization.', '2024-08-10 18:30:00', '2024-08-10 23:00:00', 3);
GO
-- Insert dữ liệu mẫu vào bảng UserFollow
INSERT INTO UserFollow (User_id, Event_id, Topic_id)
VALUES 
(1, 1, NULL),
(2, NULL, 1);
GO
-- Insert dữ liệu mẫu vào bảng PostImage
INSERT INTO Upload(Post_id, UploadPath)
VALUES 
(1, 'post1_image1.jpg'),
(1, 'post1_image2.jpg'),
(2, 'post2_image1.jpg');
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




SELECT * FROM PostWithUploadAndComment;


CREATE OR ALTER VIEW GroupView3 AS
SELECT 
    g.Group_id,
    g.Creater_id,
    g.Group_name,
    g.Group_description,
    g.image,
    mg.MemberGroup_id,
    u.USER_ID,
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
    up.Shop_id,
    up.Comment_id AS Upload_comment_id,
    up.Product_id,
    up.UploadPath,
    up.Post_id AS Upload_post_id,
    (SELECT COUNT(*) FROM MemberGroup WHERE Group_id = g.Group_id) AS memberCount -- Đếm số thành viên nhóm
FROM [Group] g
LEFT JOIN MemberGroup mg ON g.Group_id = mg.Group_id
LEFT JOIN Users u ON mg.User_id = u.User_id
LEFT JOIN Post p ON g.Group_id = p.Group_id
LEFT JOIN Comment c ON p.Post_id = c.Post_id
LEFT JOIN Upload up ON p.Post_id = up.Post_id;

SELECT * FROM GroupView3;

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



ALTER TABLE [Group]
ADD image NVARCHAR(255);

ALTER TABLE [Group]
ADD memberCount INT DEFAULT 0;

ALTER TABLE [Group]
ALTER COLUMN Group_description NVARCHAR(255);
