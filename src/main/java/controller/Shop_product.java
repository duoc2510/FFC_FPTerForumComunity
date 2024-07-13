/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import model.DAO.Shop_DB;
import model.DAO.User_DB;
import model.Discount;
import model.Order;
import model.OrderItem;
import model.Product;
import model.Shop;
import model.Upload;
import model.User;
import notifications.NotificationWebSocket;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Shop_product extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Shop_product</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop_product at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/marketplace/myShop.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // Phương thức hỗ trợ để lấy tên tệp tin từ một Part
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                // Trong trường hợp upload nhiều tệp tin, tìm và trả về tên tệp tin cuối cùng
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                return Paths.get(fileName).getFileName().toString();
            }
        }

        return "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NotificationWebSocket nw = new NotificationWebSocket();

        User user = (User) request.getSession().getAttribute("USER");
        Shop shop = (Shop) request.getSession().getAttribute("SHOP");
        Shop_DB sdb = new Shop_DB();
        User_DB udb = new User_DB();
        String orderid = request.getParameter("orderid");

        String action = request.getParameter("action");
        switch (action) {
            case "add":
                try {
                    // Đường dẫn đến thư mục lưu trữ ảnh
                    String uploadPath = request.getServletContext().getRealPath("/static/images");

                    // Tạo thư mục nếu nó không tồn tại
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs(); // Sử dụng mkdirs() để tạo cả các thư mục cha nếu chúng không tồn tại
                    }

                    // Nhận thông tin từ form
                    String productName = request.getParameter("productName");
                    String productPrice1 = request.getParameter("productPrice");
                    double productPrice = Double.parseDouble(productPrice1);
                    String productQuantity1 = request.getParameter("productQuantity");
                    int productQuantity = Integer.parseInt(productQuantity1);
                    String description = request.getParameter("productDescription");

                    // Khởi tạo ArrayList để lưu đường dẫn của ảnh mới
                    ArrayList<String> imagePaths = new ArrayList<>();
// Lặp qua danh sách các tệp tin từ request
                    Collection<Part> fileParts = request.getParts();
                    for (Part filePart : fileParts) {
                        if (filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                            // Nếu tệp tin được chọn
                            String fileName = extractFileName(filePart);

                            // Lưu ảnh vào thư mục
                            try (InputStream input = filePart.getInputStream()) {
                                // Đường dẫn của thư mục 'images' tương đối với thư mục gốc
                                String relativeUploadPath = "images";

                                // Đường dẫn đầy đủ đến thư mục 'images' trong ứng dụng
                                String absoluteUploadPath = request.getServletContext().getRealPath(relativeUploadPath);

                                // Lưu ảnh vào thư mục 'images'
                                Path filePath = new File(uploadDir, fileName).toPath();
                                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);

                                // Lưu đường dẫn tương đối của ảnh mới vào ArrayList
                                String relativeImagePath = relativeUploadPath + File.separator + fileName;
                                imagePaths.add(relativeImagePath);
                            }

                        }
                    }
                    // Thêm sản phẩm mới vào
                    Product pro = new Product(1, productName, productPrice, productQuantity, description, shop.getShopID());
                    sdb.addNewProduct(pro);

                    ArrayList<Product> productlist = sdb.getAllProductByShopID(shop.getShopID());

                    Product pr = null;
                    if (productlist.size() == 1) {
                        pr = productlist.get(0);
                    } else if (productlist.size() > 1) {
                        pr = productlist.get(productlist.size() - 1);
                    }
                    // Sử dụng imagePaths ở đây cho mục đích của bạn
                    for (String imagePath : imagePaths) {
                        Upload up = new Upload(1, 1, 1, pr.getProductId(), imagePath);
                        sdb.addNewUploadProduct(up);
                    }

                    request.setAttribute("products", productlist);
                    response.sendRedirect("myshop");
//            request.getRequestDispatcher("/marketplace/myShop.jsp").forward(request, response);

                } catch (Exception e) {
                    e.printStackTrace(); // In ra lỗi (thực tế nên xử lý lỗi phù hợp với ứng dụng của bạn)
                }
                break;

            case "edit":

                try {
                    // Đường dẫn đến thư mục lưu trữ ảnh
                    String uploadPath = request.getServletContext().getRealPath("/static/images");

                    // Tạo thư mục nếu nó không tồn tại
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs(); // Sử dụng mkdirs() để tạo cả các thư mục cha nếu chúng không tồn tại
                    }

                    // Nhận thông tin từ form
                    String id = request.getParameter("id");
                    int productId = Integer.parseInt(id);
                    String productName = request.getParameter("productName");
                    String productPrice1 = request.getParameter("productPrice");
                    double productPrice = Double.parseDouble(productPrice1);
                    String productQuantity1 = request.getParameter("productQuantity");
                    int productQuantity = Integer.parseInt(productQuantity1);
                    String description = request.getParameter("productDescription");

                    // Khởi tạo ArrayList để lưu đường dẫn của ảnh mới
                    ArrayList<String> imagePaths = new ArrayList<>();
// Lặp qua danh sách các tệp tin từ request
                    Collection<Part> fileParts = request.getParts();
                    for (Part filePart : fileParts) {
                        if (filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                            // Nếu tệp tin được chọn
                            String fileName = extractFileName(filePart);

                            // Lưu ảnh vào thư mục
                            try (InputStream input = filePart.getInputStream()) {
                                // Đường dẫn của thư mục 'images' tương đối với thư mục gốc
                                String relativeUploadPath = "images";

                                // Đường dẫn đầy đủ đến thư mục 'images' trong ứng dụng
                                String absoluteUploadPath = request.getServletContext().getRealPath(relativeUploadPath);

                                // Lưu ảnh vào thư mục 'images'
                                Path filePath = new File(uploadDir, fileName).toPath();
                                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);

                                // Lưu đường dẫn tương đối của ảnh mới vào ArrayList
                                String relativeImagePath = relativeUploadPath + File.separator + fileName;
                                imagePaths.add(relativeImagePath);
                            }

                        }
                    }
                    Product pro = sdb.getProductByID(productId);
                    pro.setName(productName);
                    pro.setPrice(productPrice);
                    pro.setProductDescription(description);
                    pro.setQuantity(productQuantity);
                    sdb.updateProduct(pro);

                    ArrayList<Product> productlist = sdb.getAllProductByShopID(shop.getShopID());

                    // Sử dụng imagePaths ở đây cho mục đích của bạn
                    if (imagePaths != null && !imagePaths.isEmpty()) {
                        sdb.removeAllUploadByProductID(productId);
                        for (String imagePath : imagePaths) {
                            Upload up = new Upload(1, 1, 1, pro.getProductId(), imagePath);
                            sdb.addNewUploadProduct(up);
                        }
                    }

                    request.setAttribute("products", productlist);
                    response.sendRedirect("myshop");
//            request.getRequestDispatcher("/marketplace/myShop.jsp").forward(request, response);

                } catch (Exception e) {
                    e.printStackTrace(); // In ra lỗi (thực tế nên xử lý lỗi phù hợp với ứng dụng của bạn)
                }
                break;

            case "editbrand":
                try {
                    // Đường dẫn đến thư mục lưu trữ ảnh
                    String uploadPath = request.getServletContext().getRealPath("/static/images");

                    // Tạo thư mục nếu nó không tồn tại
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs(); // Sử dụng mkdirs() để tạo cả các thư mục cha nếu chúng không tồn tại
                    }

                    // Nhận thông tin từ form
                    String id = request.getParameter("id");
                    int shopId = Integer.parseInt(id);
                    String name = request.getParameter("shopName");
                    String phone = request.getParameter("shopPhone");
                    String decription = request.getParameter("shopDescription");

                    // Lấy file từ request
                    Part filePart = request.getPart("file");
                    String imagePath = null;

                    // Nếu tệp tin được chọn
                    if (filePart != null && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        String fileName = extractFileName(filePart);

                        // Lưu ảnh vào thư mục
                        try (InputStream input = filePart.getInputStream()) {
                            // Đường dẫn của thư mục 'images' tương đối với thư mục gốc
                            String relativeUploadPath = "images";

                            // Đường dẫn đầy đủ đến thư mục 'images' trong ứng dụng
                            String absoluteUploadPath = request.getServletContext().getRealPath(relativeUploadPath);

                            // Lưu ảnh vào thư mục 'images'
                            Path filePath = new File(uploadDir, fileName).toPath();
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);

                            // Lưu đường dẫn tương đối của ảnh mới
                            imagePath = relativeUploadPath + File.separator + fileName;
                        }
                    }

                    // Lấy sản phẩm hiện tại từ cơ sở dữ liệu
                    Shop sh = sdb.getShopHaveStatusIs1ByShopID(shopId);
                    sh.setDescription(decription);
                    sh.setName(name);
                    sh.setPhone(phone);
                    if (imagePath != null) {
                        sh.setImage(imagePath);
                    }
                    sdb.updateShop(sh);
                    request.getSession().setAttribute("SHOP", sh);
                    ArrayList<Product> productlist = sdb.getAllProductByShopID(shop.getShopID());
                    request.setAttribute("products", productlist);
                    response.sendRedirect("myshop");
                } catch (Exception e) {
                    e.printStackTrace(); // In ra lỗi (thực tế nên xử lý lỗi phù hợp với ứng dụng của bạn)
                }
                break;

            case "deleteshop":
                String id = request.getParameter("id");
                int shopId = Integer.parseInt(id);
                sdb.setStatusIs0ByShopID(shopId);
                response.sendRedirect("index.jsp");
                break;
            case "adddiscount":
                try {
                    String code = request.getParameter("discountCode");
                    int shopIdnew = Integer.parseInt(request.getParameter("shopId"));
                    double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));
                    double discountConditionInput = Double.parseDouble(request.getParameter("discountConditionInput"));
                    String validFromStr = request.getParameter("validFrom");
                    String validToStr = request.getParameter("validTo");
                    int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date validFrom = dateFormat.parse(validFromStr);
                    Date validTo = dateFormat.parse(validToStr);

                    Discount discount = new Discount(code, 0, shopIdnew, discountPercent, validFrom, validTo, usageLimit, discountConditionInput);
                    sdb.addNewDiscount(discount);

                    ArrayList<Discount> discountlist = sdb.getAllDiscountByShopID(shop.getShopID());
                    request.setAttribute("discounts", discountlist);

                    // Forward the request to the shop page
                    response.sendRedirect("myshop");

                } catch (ParseException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace(); // Print the error (ideally, handle it properly)
                }
                break;
            case "editdiscount":
                try {
                    String code = request.getParameter("discountCode");
                    int shopIdnew = Integer.parseInt(request.getParameter("shopId"));
                    int discountid = Integer.parseInt(request.getParameter("discountId"));
                    double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));
                    double discountConditionInput = Double.parseDouble(request.getParameter("discountConditionInput"));
                    String validFromStr = request.getParameter("validFrom");
                    String validToStr = request.getParameter("validTo");
                    int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date validFrom = dateFormat.parse(validFromStr);
                    Date validTo = dateFormat.parse(validToStr);
                    Discount dis = sdb.getDiscountByID(discountid);
                    dis.setOwnerId(1);
                    dis.setCode(code);
                    dis.setDiscountPercent(discountPercent);
                    dis.setCondition(discountConditionInput);
                    dis.setValidFrom(validFrom);
                    dis.setValidTo(validTo);
                    dis.setUsageLimit(usageLimit);
                    sdb.updateDiscount(dis);

                    ArrayList<Discount> discountlist = sdb.getAllDiscountByShopID(shop.getShopID());
                    request.setAttribute("discounts", discountlist);

                    // Forward the request to the shop page
                    response.sendRedirect("myshop");

                } catch (ParseException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace(); // Print the error (ideally, handle it properly)
                }
                break;

            case "chapnhan": ////shop chấp nhận
                int orderid1 = Integer.parseInt(orderid);
                Order or = sdb.getOrderbyID(orderid1);
                sdb.updateOrderStatus(orderid1, "Accept");
                nw.saveNotificationToDatabase(or.getUserID(), "Đơn hàng của bạn đã được chấp nhận!", "/marketplace/history");
                nw.sendNotificationToClient(or.getUserID(), "Đơn hàng của bạn đã được chấp nhận!", "/marketplace/history");
                response.sendRedirect("myshop");
                break;
            case "thatbai": /////shop hủy đơn
                int orderid2 = Integer.parseInt(orderid);
                Order or1 = sdb.getOrderbyID(orderid2);
                //trả tiền lại cho người đặt nếu đã thanh toán
                User owner1 = udb.getUserById(or1.getUserID());
                if (or1.getPayment_status().equals("dathanhtoan")) {
                    boolean updateSuccess = User_DB.updateWalletByEmail(owner1.getUserEmail(), owner1.getUserWallet() + or1.getTotal());
                    ///Trả về thông báo tại đây
                    nw.saveNotificationToDatabaseWithStatusIsBalance(owner1.getUserId(), "Trả lại tiền đơn hàng vì shop hủy đơn :" + or1.getTotal(), "/walletbalance");

                }
                nw.saveNotificationToDatabase(or1.getUserID(), "Đơn hàng của bạn không được chấp nhận!", "/marketplace/history");
                nw.sendNotificationToClient(or1.getUserID(), "Đơn hàng của bạn không được chấp nhận!", "/marketplace/history");
                sdb.updateOrderStatus(orderid2, "Fail");
                ArrayList<OrderItem> orderitemlistnew = sdb.getAllOrderItemByOrderID(orderid2);
                for (OrderItem ot : orderitemlistnew) {
                    Product p = sdb.getProductByID(ot.getProductID());
                    p.setQuantity(p.getQuantity() + ot.getQuantity()); // Reduce the quantity by the amount ordered
                    sdb.updateProduct(p);
                }
                response.sendRedirect("myshop");
                break;
            case "thanhcong":  ///////shop đã giao hàng thành công
                int orderid3 = Integer.parseInt(orderid);
                Order order = sdb.getOrderbyID(orderid3);

                User updatedUser = User_DB.getUserByEmailorUsername(user.getUserEmail());
                request.getSession().setAttribute("USER", updatedUser);
                sdb.updateOrderStatus(orderid3, "Completed");
//                sdb.addNewNotification(order.getUserID(), "Đơn hàng của bạn đã giao thành công! Vui lòng bấm đã nhận được hàng!", "/marketplace/history");
                nw.saveNotificationToDatabase(order.getUserID(), "Đơn hàng của bạn đã giao thành công! Vui lòng bấm đã nhận được hàng!", "/marketplace/history");
                nw.sendNotificationToClient(order.getUserID(), "Đơn hàng của bạn đã giao thành công! Vui lòng bấm đã nhận được hàng!", "/marketplace/history");
                response.sendRedirect("myshop");
                break;
            case "huydon":   //////người đặt hủy đơn
                int orderid4 = Integer.parseInt(orderid);
                Order or2 = sdb.getOrderbyID(orderid4);
                //trả tiền lại cho người đặt nếu đã thanh toán
                if (or2.getPayment_status().equals("dathanhtoan")) {
                    boolean updateSuccess = User_DB.updateWalletByEmail(user.getUserEmail(), user.getUserWallet() + or2.getTotal());
                    ///Trả về thông báo tại đây
                    nw.saveNotificationToDatabaseWithStatusIsBalance(user.getUserId(), "Trả lại tiền đơn hàng vì bạn đã hủy đơn :" + or2.getTotal(), "/walletbalance");

                }
                sdb.updateOrderStatus(orderid4, "Cancelled");
                ArrayList<OrderItem> orderitemlistnewnew = sdb.getAllOrderItemByOrderID(orderid4);
                for (OrderItem ot : orderitemlistnewnew) {
                    Product p = sdb.getProductByID(ot.getProductID());
                    p.setQuantity(p.getQuantity() + ot.getQuantity()); // Reduce the quantity by the amount ordered
                    sdb.updateProduct(p);
                }

                for (OrderItem ot : orderitemlistnewnew) {
                    Product p1 = sdb.getProductByID(ot.getProductID());
                    Shop shop1 = sdb.getShopHaveStatusIs1ByShopID(p1.getShopId());
//                    sdb.addNewNotification(shop1.getOwnerID(), "Người đặt đã hủy đơn do 1 số nguyên nhân!", "/marketplace/myshop");
                    nw.saveNotificationToDatabase(shop1.getOwnerID(), "Người đặt đã hủy đơn do 1 số nguyên nhân!", "/marketplace/myshop");
                    nw.sendNotificationToClient(shop1.getOwnerID(), "Người đặt đã hủy đơn do 1 số nguyên nhân!", "/marketplace/myshop");
                    break;
                }

                response.sendRedirect("history");
                break;
            case "danhanhang":  ///người đặt đã nhận hàng
                int orderid5 = Integer.parseInt(orderid);
                response.sendRedirect("history?orderid=" + orderid5);
                break;
            case "danhgia":  ///người đặt đánh giá
                int orderid6 = Integer.parseInt(orderid);
                Order or3 = sdb.getOrderbyID(orderid6);

                ArrayList<OrderItem> orderitemlist1 = sdb.getAllOrderItemByOrderID(orderid6);
                double total1 = 0;
                for (OrderItem o : orderitemlist1) {
                    total1 = total1 + (o.getPrice() * o.getQuantity());
                }

                ArrayList<OrderItem> orderitemlistnewnew1 = sdb.getAllOrderItemByOrderID(orderid6);
                for (OrderItem ot : orderitemlistnewnew1) {
                    Product p2 = sdb.getProductByID(ot.getProductID());
                    Shop shop2 = sdb.getShopHaveStatusIs1ByShopID(p2.getShopId());
                    User owner = udb.getUserById(shop2.getOwnerID());
                    if (or3.getDiscountid() > 0) {
                        Discount dis = sdb.getDiscountByID(or3.getDiscountid());
                        if (dis.getShopId() == 0) {
                            boolean check = udb.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() + (total1 - or3.getTotal()) - (total1 * 5 / 100));
                            nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Trả lại tiền voucher hệ thống :" + (total1 - or3.getTotal()) + "và trừ tiền hoa hồng đơn hàng :" + (total1 * 5 / 100), "/walletbalance");

                        } else {
                            boolean check = udb.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() - (total1 * 5 / 100));
                            nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Trừ tiền hoa hồng đơn hàng :" + (total1 * 5 / 100), "/walletbalance");

                        }
                    }

                    //trả tiền lại cho shop khi đã thành công
                    if (or3.getPayment_status().equals("dathanhtoan")) {
                        boolean updateSuccess = User_DB.updateWalletByEmail(owner.getUserEmail(), owner.getUserWallet() + or3.getTotal());
                        ///Trả về thông báo tại đây
                        nw.saveNotificationToDatabaseWithStatusIsBalance(owner.getUserId(), "Thanh toán tiền đơn hàng đã thành công :" + or3.getTotal(), "/walletbalance");
                    }
                    nw.saveNotificationToDatabase(shop2.getOwnerID(), "Người đặt đã nhận được hàng và đã đánh giá!", "/marketplace/allshop/shopdetail?shopid=" + shop2.getShopID());
                    nw.sendNotificationToClient(shop2.getOwnerID(), "Người đặt đã nhận được hàng và đã đánh giá!", "/marketplace/allshop/shopdetail?shopid=" + shop2.getShopID());
                    break;
                }
                String stars = request.getParameter("stars");
                int star = Integer.parseInt(stars);
                String comment = request.getParameter("comment");
                sdb.updateOrderStatus(orderid6, "Success");
                sdb.updateOrderFeedback(orderid6, comment);
                sdb.updateOrderStar(orderid6, star);
                String msg = "Thanks for your order! ";
                session.setAttribute("message", msg);
                response.sendRedirect("/FPTer/martketplace/allshop");
                break;

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
