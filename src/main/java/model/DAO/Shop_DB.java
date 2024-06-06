/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAO.DBinfo.dbPass;
import static model.DAO.DBinfo.dbURL;
import static model.DAO.DBinfo.dbUser;
import static model.DAO.DBinfo.driver;
import model.Discount;
import model.Order;
import model.OrderItem;
import model.Product;
import model.Shop;
import model.Upload;
import java.util.Collections;
import java.util.Comparator;

/**
 *
 * @author Admin
 */
public class Shop_DB {

    public Shop_DB() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(User_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Shop getShopByUserID(int userID) {
        Shop shop = null;
        String query = "SELECT * FROM Shop WHERE Owner_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int shopID = rs.getInt("Shop_id");
                String shopName = rs.getString("Shop_name");
                String shopPhone = rs.getString("Shop_phone");
                String shopCampus = rs.getString("Shop_campus");
                String shopDescription = rs.getString("Description");
                String shopImage = rs.getString("Image");
                int ownerID = rs.getInt("Owner_id");
                int shopStatus = rs.getInt("Status");
                shop = new Shop(shopID, shopName, shopPhone, shopCampus, shopDescription, ownerID, shopImage, shopStatus);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return shop;
    }

    public static Shop getShopHaveStatusIs1ByUserID(int userID) {
        Shop shop = null;
        String query = "SELECT * FROM Shop WHERE Owner_id = ? AND Status = 1";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int shopID = rs.getInt("Shop_id");
                String shopName = rs.getString("Shop_name");
                String shopPhone = rs.getString("Shop_phone");
                String shopCampus = rs.getString("Shop_campus");
                String shopDescription = rs.getString("Description");
                String shopImage = rs.getString("Image");
                int ownerID = rs.getInt("Owner_id");
                int shopStatus = rs.getInt("Status");
                shop = new Shop(shopID, shopName, shopPhone, shopCampus, shopDescription, ownerID, shopImage, shopStatus);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return shop;
    }

    public static Shop getShopHaveStatusIs1ByShopID(int shopID) {
        Shop shop = null;
        String query = "SELECT * FROM Shop WHERE Shop_id = ? AND Status = 1";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, shopID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String shopName = rs.getString("Shop_name");
                String shopPhone = rs.getString("Shop_phone");
                String shopCampus = rs.getString("Shop_campus");
                String shopDescription = rs.getString("Description");
                String shopImage = rs.getString("Image");
                int ownerID = rs.getInt("Owner_id");
                int shopStatus = rs.getInt("Status");
                shop = new Shop(shopID, shopName, shopPhone, shopCampus, shopDescription, ownerID, shopImage, shopStatus);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return shop;
    }

    public static void setStatusIs0ByShopID(int shopID) {
        String updateQuery = "UPDATE Shop SET Status = 0 WHERE Shop_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setInt(1, shopID);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void addShop(Shop shop) {
        String insertQuery = "INSERT INTO Shop (Owner_id, Shop_name, Shop_phone, Shop_campus, Description, Image, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {

            pstmt.setInt(1, shop.getOwnerID());
            pstmt.setString(2, shop.getName());
            pstmt.setString(3, shop.getPhone());
            pstmt.setString(4, shop.getCampus());
            pstmt.setString(5, shop.getDescription());
            pstmt.setString(6, shop.getImage());
            pstmt.setInt(7, shop.getStatus());

            pstmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Shop> getAllShop() {
        ArrayList<Shop> shops = new ArrayList<>();
        String query = "SELECT * FROM Shop";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int shopID = rs.getInt("Shop_id");
                String shopName = rs.getString("Shop_name");
                String shopPhone = rs.getString("Shop_phone");
                String shopCampus = rs.getString("Shop_campus");
                String description = rs.getString("Description");
                int ownerID = rs.getInt("Owner_id");
                String image = rs.getString("Image");
                boolean status = rs.getBoolean("Status");

                Shop shop = new Shop(shopID, shopName, shopPhone, shopCampus, description, ownerID, image, status ? 1 : 0);
                shops.add(shop);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return shops;
    }

    public static void addNewProduct(Product product) {
        String insertQuery = "INSERT INTO Product (Shop_id, Product_name, Product_price, Stock_quantity, Description) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
            pstmt.setInt(1, product.getShopId());
            pstmt.setString(2, product.getName());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setInt(4, product.getQuantity());
            pstmt.setString(5, product.getProductDescription());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Product> getAllProduct() {
        ArrayList<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("Product_id");
                int shopId = rs.getInt("Shop_id");
                String productName = rs.getString("Product_name");
                double productPrice = rs.getDouble("Product_price");
                int stockQuantity = rs.getInt("Stock_quantity");
                String description = rs.getString("Description");

                Product product = new Product(productId, productName, productPrice, stockQuantity, description, shopId);
                products.add(product);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return products;
    }

    public static ArrayList<Product> getAllProductByShopID(int shopID) {
        ArrayList<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE Shop_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, shopID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("Product_id");
                int shopId = rs.getInt("Shop_id");
                String productName = rs.getString("Product_name");
                double productPrice = rs.getDouble("Product_price");
                int stockQuantity = rs.getInt("Stock_quantity");
                String description = rs.getString("Description");
                Product product = new Product(productId, productName, productPrice, stockQuantity, description, shopId);
                products.add(product);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public static void addNewUploadProduct(Upload upload) {
        String insertQuery = "INSERT INTO Upload (Post_id, Event_id, Product_id, UploadPath) VALUES (?, ?, ?, ?)";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
            pstmt.setObject(1, upload.getPostId() == 1 ? null : upload.getPostId());
            pstmt.setObject(2, upload.getEventId() == 1 ? null : upload.getEventId());
            pstmt.setObject(3, upload.getProductId());
            pstmt.setString(4, upload.getUploadPath());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Upload> getAllUploadByProductID(int productID) {
        ArrayList<Upload> uploads = new ArrayList<>();
        String query = "SELECT * FROM Upload WHERE Product_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, productID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int uploadId = rs.getInt("Upload_id");
                Integer postId = rs.getObject("Post_id", Integer.class);
                Integer eventId = rs.getObject("Event_id", Integer.class);
                String uploadPath = rs.getString("UploadPath");

                // Set default value of 1 if the field is null
                postId = (postId == null) ? 1 : postId;
                eventId = (eventId == null) ? 1 : eventId;

                Upload upload = new Upload(uploadId, postId, eventId, productID, uploadPath);
                uploads.add(upload);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return uploads;
    }

    public static Upload getUploadFirstByProductID(int productID) {
        Upload upload = null;
        String query = "SELECT TOP 1 * FROM Upload WHERE Product_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            System.out.println("Connected to the database.");
            pstmt.setInt(1, productID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int uploadId = rs.getInt("Upload_id");
                Integer postId = rs.getObject("Post_id", Integer.class);
                Integer eventId = rs.getObject("Event_id", Integer.class);
                String uploadPath = rs.getString("UploadPath");

                // Set default value of 1 if the field is null
                postId = (postId == null) ? 1 : postId;
                eventId = (eventId == null) ? 1 : eventId;

                upload = new Upload(uploadId, postId, eventId, productID, uploadPath);
            } else {
                System.out.println("No upload found for the given product ID: " + productID);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return upload;
    }

    public static void removeAllUploadByProductID(int productID) {
        String deleteQuery = "DELETE FROM Upload WHERE Product_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(deleteQuery)) {
            pstmt.setInt(1, productID);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Number of uploads deleted: " + rowsAffected);
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void updateProduct(Product product) {
        String updateQuery = "UPDATE Product SET Shop_id = ?, Product_name = ?, Product_price = ?, Stock_quantity = ?, Description = ? WHERE Product_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setInt(1, product.getShopId());
            pstmt.setString(2, product.getName());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setInt(4, product.getQuantity());
            pstmt.setString(5, product.getProductDescription());
            pstmt.setInt(6, product.getProductId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Product getProductByID(int productID) {
        Product product = null;
        String query = "SELECT * FROM Product WHERE Product_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, productID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int shopId = rs.getInt("Shop_id");
                String productName = rs.getString("Product_name");
                double productPrice = rs.getDouble("Product_price");
                int stockQuantity = rs.getInt("Stock_quantity");
                String description = rs.getString("Description");
                product = new Product(productID, productName, productPrice, stockQuantity, description, shopId);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return product;
    }

    public static void updateShop(Shop shop) {
        String updateQuery = "UPDATE Shop SET Shop_name = ?, Shop_phone = ?, Shop_campus = ?, Description = ?, Image = ?, Status = ? WHERE Shop_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setString(1, shop.getName());
            pstmt.setString(2, shop.getPhone());
            pstmt.setString(3, shop.getCampus());
            pstmt.setString(4, shop.getDescription());
            pstmt.setString(5, shop.getImage());
            pstmt.setInt(6, shop.getStatus());
            pstmt.setInt(7, shop.getShopID());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Shop getShopByShopID(int shopID) {
        Shop shop = null;
        String query = "SELECT * FROM Shop WHERE Shop_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, shopID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String shopName = rs.getString("Shop_name");
                String shopPhone = rs.getString("Shop_phone");
                String shopCampus = rs.getString("Shop_campus");
                String shopDescription = rs.getString("Description");
                String shopImage = rs.getString("Image");
                int ownerID = rs.getInt("Owner_id");
                int shopStatus = rs.getInt("Status");
                shop = new Shop(shopID, shopName, shopPhone, shopCampus, shopDescription, ownerID, shopImage, shopStatus);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return shop;
    }

    public static void addOrder(Order order) {
        String insertQuery = "INSERT INTO [Order] (User_id, Order_date, Order_status, Total_amount, Note, Discount_id, Feedback, Star, Receiver_phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
            pstmt.setInt(1, order.getUserID());
            pstmt.setObject(2, order.getOrderDate() != null ? new java.sql.Date(order.getOrderDate().getTime()) : null);
            pstmt.setString(3, order.getStatus());
            pstmt.setDouble(4, order.getTotal());
            pstmt.setString(5, order.getNote());
            pstmt.setObject(6, order.getDiscountid() == 1 ? null : order.getDiscountid());
            pstmt.setString(7, order.getFeedback());
            pstmt.setInt(8, order.getStar()); // Set the Star field
            pstmt.setString(9, order.getReceiverPhone());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Order getOrderHasStatusIsNullByUserID(int userID) {
        Order order = null;
        String query = "SELECT TOP 1 * FROM [Order] WHERE User_id = ? AND Order_status = 'null'";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int orderID = rs.getInt("Order_id");
                Date orderDate = rs.getDate("Order_date");
                String orderStatus = rs.getString("Order_status");
                double totalAmount = rs.getDouble("Total_amount");
                String note = rs.getString("Note");
                int discountID = rs.getInt("Discount_id");
                String feedback = rs.getString("Feedback");
                int star = rs.getInt("Star"); // Get the Star field
                String receiverPhone = rs.getString("Receiver_phone");

                order = new Order(userID, orderID, orderDate, orderStatus, totalAmount, discountID, note, feedback, star, receiverPhone);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return order;
    }

    public static void updateOrderbyID(Order order) {
        String updateQuery = "UPDATE [Order] SET User_id = ?, Order_date = ?, Order_status = ?, Total_amount = ?, Note = ?, Discount_id = ?, Feedback = ?, Star = ?, Receiver_phone = ? WHERE Order_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setInt(1, order.getUserID());

            // Tạo một đối tượng Date mới để lấy ngày hiện tại
            Date currentDate = new Date();
            pstmt.setObject(2, new java.sql.Date(currentDate.getTime()));

            pstmt.setString(3, order.getStatus());
            pstmt.setDouble(4, order.getTotal());
            pstmt.setString(5, order.getNote());
            pstmt.setObject(6, order.getDiscountid() == 0 ? null : order.getDiscountid());
            pstmt.setString(7, order.getFeedback());
            pstmt.setInt(8, order.getStar()); // Set the Star field
            pstmt.setString(9, order.getReceiverPhone());
            pstmt.setInt(10, order.getOrder_ID());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Order> getOrdersByShopId(int shopId) {
        ArrayList<Order> orders = new ArrayList<>();
        String query = "SELECT o.* "
                + "FROM [Order] o "
                + "JOIN OrderItem oi ON o.Order_id = oi.Order_id "
                + "JOIN Product p ON oi.Product_id = p.Product_id "
                + "WHERE p.Shop_id = ? AND o.Order_status IS NOT NULL AND o.Order_status != 'null' "
                + "GROUP BY o.Order_id, o.User_id, o.Order_date, o.Order_status, o.Total_amount, o.Note, o.Discount_id, o.Feedback, o.Star, o.Receiver_phone";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, shopId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // Create an Order object from the query result
                Order order = new Order();
                order.setOrder_ID(rs.getInt("Order_id"));
                order.setUserID(rs.getInt("User_id"));
                order.setOrderDate(rs.getDate("Order_date"));
                order.setStatus(rs.getString("Order_status"));
                order.setTotal(rs.getDouble("Total_amount"));
                order.setNote(rs.getString("Note"));
                order.setDiscountid(rs.getInt("Discount_id"));
                order.setFeedback(rs.getString("Feedback"));
                order.setStar(rs.getInt("Star"));
                order.setReceiverPhone(rs.getString("Receiver_phone"));

                // Add the Order object to the list
                orders.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Sort the list by order date from newest to oldest
        orders.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));

        return orders;
    }

    public static Order getOrderbyID(int orderId) {
        Order order = null;
        String query = "SELECT * FROM [Order] WHERE Order_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int userID = rs.getInt("User_id");
                Date orderDate = rs.getDate("Order_date");
                String orderStatus = rs.getString("Order_status");
                double totalAmount = rs.getDouble("Total_amount");
                String note = rs.getString("Note");
                int discountID = rs.getInt("Discount_id");
                String feedback = rs.getString("Feedback");
                int star = rs.getInt("Star");
                String receiverPhone = rs.getString("Receiver_phone");

                order = new Order(userID, orderId, orderDate, orderStatus, totalAmount, discountID, note, feedback, star, receiverPhone);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return order;
    }

    public static void updateOrderStatus(int orderID, String newStatus) {
        String updateQuery = "UPDATE [Order] SET Order_status = ? WHERE Order_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, orderID);

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void updateOrderFeedback(int orderID, String feedback) {
        String updateQuery = "UPDATE [Order] SET Feedback = ? WHERE Order_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setString(1, feedback);
            pstmt.setInt(2, orderID);

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void updateOrderStar(int orderID, int star) {
        String updateQuery = "UPDATE [Order] SET Star = ? WHERE Order_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setInt(1, star);
            pstmt.setInt(2, orderID);

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Order> getAllOrdersByUserID(int userID) {
        ArrayList<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM [Order] WHERE User_id = ? ORDER BY Order_ID DESC";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String status = rs.getString("Order_status");
                if (status != null && !status.equals("null")) {
                    Order order = new Order();
                    order.setOrder_ID(rs.getInt("Order_id"));
                    order.setUserID(rs.getInt("User_id"));
                    order.setOrderDate(rs.getDate("Order_date"));
                    order.setStatus(status);
                    order.setTotal(rs.getDouble("Total_amount"));
                    order.setNote(rs.getString("Note"));
                    order.setDiscountid(rs.getInt("Discount_id"));
                    order.setFeedback(rs.getString("Feedback"));
                    order.setStar(rs.getInt("Star"));
                    order.setReceiverPhone(rs.getString("Receiver_phone"));

                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return orders;
    }

    public static ArrayList<OrderItem> getAllOrderItemByOrderIdHasStatusIsNull(int orderId) {
        ArrayList<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT oi.* FROM OrderItem oi JOIN [Order] o ON oi.Order_id = o.Order_id WHERE oi.Order_id = ? AND o.Order_status = 'Null'";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int orderItemId = rs.getInt("OrderItem_id");
                int orderID = rs.getInt("Order_id");
                int productID = rs.getInt("Product_id");
                int quantity = rs.getInt("Quantity");
                double price = rs.getDouble("Unit_price");

                OrderItem orderItem = new OrderItem(orderItemId, orderID, productID, quantity, price);
                orderItems.add(orderItem);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderItems;
    }

    public static void addNewOrderItem(OrderItem orderItem) {
        String insertQuery = "INSERT INTO OrderItem (Order_id, Product_id, Quantity, Unit_price) VALUES (?, ?, ?, ?)";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
            pstmt.setInt(1, orderItem.getOrder_id());
            pstmt.setInt(2, orderItem.getProductID());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getPrice());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void updateOrderItem(OrderItem orderItem) {
        String updateQuery = "UPDATE OrderItem SET Quantity = ?, Unit_price = ? WHERE OrderItem_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
            pstmt.setInt(1, orderItem.getQuantity());
            pstmt.setDouble(2, orderItem.getPrice());
            pstmt.setInt(3, orderItem.getOrderItem_id());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void deleteOrderItemByID(int orderItemID) {
        String deleteQuery = "DELETE FROM OrderItem WHERE OrderItem_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(deleteQuery)) {
            pstmt.setInt(1, orderItemID);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Number of order items deleted: " + rowsAffected);
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<OrderItem> getAllOrderItemByOrderID(int orderId) {
        ArrayList<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM OrderItem WHERE Order_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int orderItemId = rs.getInt("OrderItem_id");
                int orderID = rs.getInt("Order_id");
                int productID = rs.getInt("Product_id");
                int quantity = rs.getInt("Quantity");
                double price = rs.getDouble("Unit_price");

                OrderItem orderItem = new OrderItem(orderItemId, orderID, productID, quantity, price);
                orderItems.add(orderItem);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderItems;
    }

    public void addNewDiscount(Discount discount) {
        String sql = "INSERT INTO Discount (Code, Owner_id, Shop_id, Discount_percent, Valid_from, Valid_to, Usage_limit, Usage_count, Condition) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, discount.getCode());
            pstmt.setObject(2, discount.getOwnerId() == 1 ? null : discount.getOwnerId());
            pstmt.setInt(3, discount.getShopId());
            pstmt.setDouble(4, discount.getDiscountPercent());
            pstmt.setDate(5, new java.sql.Date(discount.getValidFrom().getTime()));
            pstmt.setDate(6, new java.sql.Date(discount.getValidTo().getTime()));
            pstmt.setInt(7, discount.getUsageLimit());
            pstmt.setInt(8, discount.getUsageCount());
            pstmt.setDouble(9, discount.getCondition());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<Discount> getAllDiscountByShopID(int shopID) {
        ArrayList<Discount> discounts = new ArrayList<>();
        String query = "SELECT * FROM Discount WHERE Shop_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, shopID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int discountID = rs.getInt("Discount_id");
                String code = rs.getString("Code");
                int ownerID = rs.getInt("Owner_id");
                double discountPercent = rs.getDouble("Discount_percent");
                Date validFrom = rs.getDate("Valid_from");
                Date validTo = rs.getDate("Valid_to");
                int usageLimit = rs.getInt("Usage_limit");
                int usageCount = rs.getInt("Usage_count");
                double condition = rs.getDouble("Condition");

                Discount discount = new Discount(discountID, code, ownerID, shopID, discountPercent, validFrom, validTo, usageLimit, usageCount, condition);
                discounts.add(discount);

                // In ra đối tượng Discount
                System.out.println("Discount ID: " + discountID);
                System.out.println("Code: " + code);
                System.out.println("Owner ID: " + ownerID);
                System.out.println("Shop ID: " + shopID);
                System.out.println("Discount Percent: " + discountPercent);
                System.out.println("Valid From: " + validFrom);
                System.out.println("Valid To: " + validTo);
                System.out.println("Usage Limit: " + usageLimit);
                System.out.println("Usage Count: " + usageCount);
                System.out.println("Condition: " + condition);
                System.out.println("---------------------------");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return discounts;
    }

    public static void updateDiscount(Discount discount) {
        String sql = "UPDATE Discount SET Code = ?, Owner_id = ?, Shop_id = ?, Discount_percent = ?, Valid_from = ?, Valid_to = ?, Usage_limit = ?, Usage_count = ?, Condition = ? WHERE Discount_id = ?";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, discount.getCode());
            pstmt.setObject(2, discount.getOwnerId() == 1 ? null : discount.getOwnerId());
            pstmt.setInt(3, discount.getShopId());
            pstmt.setDouble(4, discount.getDiscountPercent());
            pstmt.setDate(5, new java.sql.Date(discount.getValidFrom().getTime()));
            pstmt.setDate(6, new java.sql.Date(discount.getValidTo().getTime()));
            pstmt.setInt(7, discount.getUsageLimit());
            pstmt.setInt(8, discount.getUsageCount());
            pstmt.setDouble(9, discount.getCondition());
            pstmt.setInt(10, discount.getDiscountId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Discount getDiscountByID(int discountID) {
        Discount discount = null;
        String query = "SELECT * FROM Discount WHERE Discount_id = ?";
        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, discountID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String code = rs.getString("Code");
                int ownerID = rs.getInt("Owner_id");
                int shopID = rs.getInt("Shop_id");
                double discountPercent = rs.getDouble("Discount_percent");
                Date validFrom = rs.getDate("Valid_from");
                Date validTo = rs.getDate("Valid_to");
                int usageLimit = rs.getInt("Usage_limit");
                int usageCount = rs.getInt("Usage_count");
                double condition = rs.getDouble("Condition");

                discount = new Discount(discountID, code, ownerID, shopID, discountPercent, validFrom, validTo, usageLimit, usageCount, condition);

                // In ra đối tượng Discount
                System.out.println("Discount ID: " + discountID);
                System.out.println("Code: " + code);
                System.out.println("Owner ID: " + ownerID);
                System.out.println("Shop ID: " + shopID);
                System.out.println("Discount Percent: " + discountPercent);
                System.out.println("Valid From: " + validFrom);
                System.out.println("Valid To: " + validTo);
                System.out.println("Usage Limit: " + usageLimit);
                System.out.println("Usage Count: " + usageCount);
                System.out.println("Condition: " + condition);
                System.out.println("---------------------------");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return discount;
    }

    public static ArrayList<Discount> getAllDiscountOrder(Integer ownerID, Integer shopID) {
        ArrayList<Discount> discounts = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Discount WHERE (Owner_id = ? OR Owner_id IS NULL) AND (Shop_id = ? OR Shop_id IS NULL) AND GETDATE() BETWEEN Valid_from AND Valid_to AND Usage_limit > 0");

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass); PreparedStatement pstmt = con.prepareStatement(query.toString())) {
            if (ownerID != null) {
                pstmt.setInt(1, ownerID);
            } else {
                pstmt.setNull(1, java.sql.Types.INTEGER);
            }

            if (shopID != null) {
                pstmt.setInt(2, shopID);
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int discountID = rs.getInt("Discount_id");
                String code = rs.getString("Code");
                int owner_id = rs.getInt("Owner_id");
                int shop_id = rs.getInt("Shop_id");
                double discountPercent = rs.getDouble("Discount_percent");
                Date validFrom = rs.getDate("Valid_from");
                Date validTo = rs.getDate("Valid_to");
                int usageLimit = rs.getInt("Usage_limit");
                int usageCount = rs.getInt("Usage_count");
                double condition = rs.getDouble("Condition");

                Discount discount = new Discount(discountID, code, owner_id, shop_id, discountPercent, validFrom, validTo, usageLimit, usageCount, condition);
                discounts.add(discount);

                // Print the Discount object
                System.out.println("Discount ID: " + discountID);
                System.out.println("Code: " + code);
                System.out.println("Owner ID: " + owner_id);
                System.out.println("Shop ID: " + shop_id);
                System.out.println("Discount Percent: " + discountPercent);
                System.out.println("Valid From: " + validFrom);
                System.out.println("Valid To: " + validTo);
                System.out.println("Usage Limit: " + usageLimit);
                System.out.println("Usage Count: " + usageCount);
                System.out.println("Condition: " + condition);
                System.out.println("---------------------------");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Shop_DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return discounts;
    }
}
