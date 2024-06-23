package controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import model.Ads;
import model.DAO.Ads_DB;
import model.Upload;
import model.User;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Advertising_Boost extends HttpServlet {

    private static final Logger logger = Logger.getLogger(Advertising_Boost.class.getName());
    private static final String UPLOAD_DIR = "upload";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/advertising/boost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String errorMessage = "";

        // Retrieve parameters from the form
        String title = request.getParameter("productName");
        String description = request.getParameter("productDescription");
        String adsDetailIdStr = request.getParameter("adsDetailId");

        // Validate and convert adsDetailId
        int adsDetailId = 0;
        if (adsDetailIdStr != null && !adsDetailIdStr.isEmpty()) {
            try {
                adsDetailId = Integer.parseInt(adsDetailIdStr);
            } catch (NumberFormatException e) {
                errorMessage = "Invalid adsDetailId format.";
                logger.log(Level.SEVERE, errorMessage, e);
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
        } else {
            errorMessage = "adsDetailId is missing.";
            logger.log(Level.SEVERE, errorMessage);
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        User user = (User) request.getSession().getAttribute("USER");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = user.getUserId();

        Part filePart = request.getPart("file");
        if (filePart == null || filePart.getSize() == 0) {
            errorMessage = "File part is missing or empty.";
            logger.log(Level.SEVERE, errorMessage);
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        String fileName = extractFileName(filePart);

        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadFolder = new File(uploadFilePath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String savePath = uploadFilePath + File.separator + fileName;
        try {
            filePart.write(savePath);
        } catch (IOException e) {
            errorMessage = "Failed to write file to disk.";
            logger.log(Level.SEVERE, errorMessage, e);
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        String filePathForDatabase = UPLOAD_DIR + File.separator + fileName;

        Ads ads = new Ads();
        ads.setAdsDetail_id(adsDetailId);
        ads.setContent(description);
        ads.setImage(filePathForDatabase);
        ads.setUser_id(userId);
        ads.setCurrentView(""); // Update as needed
        ads.setLocation("");    // Update as needed
        ads.setURI(request.getParameter("URI"));

        Upload upload = new Upload();
        upload.setEventId(0); // Update as needed
        upload.setUploadPath(filePathForDatabase);

        Ads_DB adsDB = new Ads_DB();
        String message;
        if (adsDB.boostAdsvertising(ads, upload)) {
            message = "Advertising boosted successfully!";
        } else {
            message = "Failed to boost advertising.";
            errorMessage = message;
            logger.log(Level.SEVERE, errorMessage);
        }

        request.getSession().setAttribute("message", message);
        response.sendRedirect(request.getContextPath() + "/advertising");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
