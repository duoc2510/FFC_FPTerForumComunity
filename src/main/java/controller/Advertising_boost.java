package controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Ads;
import model.Ads_combo;
import model.DAO.Ads_DB;
import model.Upload;
import model.User;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10 // 10 MB
)
public class Advertising_Boost extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the session, do not create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        // Check if the user is logged in
        if (session != null && session.getAttribute("USER") != null) {
            // Retrieve the current user from the session
            User currentUser = (User) session.getAttribute("USER");

            // Fetch the list of ads for the current user
            Ads_DB adsDB = new Ads_DB();
            List<Ads> allAds = adsDB.getAllAdsByUserID(currentUser.getUserId());

            // Fetch all combo data
            List<Ads_combo> allComboAds = adsDB.getAllComboAds();

            // Create a map of Adsdetail_id to ComboAds
            Map<Integer, Ads_combo> comboAdsMap = new HashMap<>();
            for (Ads_combo combo : allComboAds) {
                comboAdsMap.put(combo.getAdsDetailId(), combo);
            }

            // Associate each ad with its combo data
            Map<Ads, Ads_combo> adsWithComboData = new HashMap<>();
            for (Ads ad : allAds) {
                Ads_combo combo = comboAdsMap.get(ad.getAdsDetailId());
                adsWithComboData.put(ad, combo);
            }

            // Set the map of ads with combo data as an attribute in the request
            request.setAttribute("adsWithComboData", adsWithComboData);

            // Set the response content type and forward the request to the JSP page
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("/advertising/boostAds.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("USER");

        switch (action) {
            case "boost":
                // Quick Boost By combo 
                try {
                    // Path to the directory where images will be stored
                    String uploadPath = request.getServletContext().getRealPath("/upload");

                    // Create the directory if it doesn't exist
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // Retrieve parameters from the form
                    String title = request.getParameter("Title");
                    String content = request.getParameter("Content");
                    int adsDetailId = Integer.parseInt(request.getParameter("adsDetailId"));
                    String uri = request.getParameter("URI");
                    String location = request.getParameter("location");
//                    String targetSex = request.getParameter("targetSex");

                    // Create Ads object and populate it
                    Ads ads = new Ads();
                    ads.setAdsDetailId(adsDetailId);
                    ads.setTitle(title);
                    ads.setContent(content);
                    ads.setUserId(user.getUserId());  // Assuming user ID is static for demo purposes
                    ads.setCurrentReact(0);  // Set initial view count
                    ads.setLocation(location);  // Assuming location will be set later
                    ads.setUri(uri);
                    ads.setTargetSex(null);

                    // Handle image upload
                    String fileName = null;
                    Part filePart = request.getPart("file"); // Assuming the form field name is "file"
                    if (filePart != null && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        fileName = extractFileName(filePart);

                        // Save the image file
                        try (InputStream input = filePart.getInputStream()) {
                            Path filePath = new File(uploadDir, fileName).toPath();
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);

                            // Set the image path in the Ads object
                            String relativeImagePath = "upload" + File.separator + fileName;
                            ads.setImage(relativeImagePath);
                        }
                    }

                    ads.setUploadPath(fileName != null ? "upload" + File.separator + fileName : "");

                    // Call boostAdvertising with the Ads object
                    Ads_DB adsDB = new Ads_DB();
                    adsDB.boostAdvertising(ads);

                    // Redirect to the advertising page
                    response.sendRedirect(request.getContextPath() + "/advertising/boost");
                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception for debugging
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
                }
                break;

            case "boostInCampaign":
                try {
                    // Path to the directory where images will be stored
                    String uploadPath = request.getServletContext().getRealPath("/upload");

                    // Create the directory if it doesn't exist
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // Retrieve parameters from the form
                    String title = request.getParameter("Title");
                    String content = request.getParameter("Content");
                    int adsDetailId = Integer.parseInt(request.getParameter("adsDetailId"));
                    String uri = request.getParameter("URI");
                    String location = request.getParameter("location");
                    String targetSex = request.getParameter("targetSex");

                    // Create Ads object and populate it
                    Ads ads = new Ads();
                    ads.setAdsDetailId(adsDetailId);
                    ads.setTitle(title);
                    ads.setContent(content);
                    ads.setUserId(user.getUserId());  // Assuming user ID is static for demo purposes
                    ads.setCurrentReact(0);  // Set initial view count
                    ads.setLocation(location);  // Assuming location will be set later
                    ads.setUri(uri);

                    if (targetSex == "all") {
                        ads.setTargetSex(null);
                    } else {
                        ads.setTargetSex(targetSex);
                    }

                    // Handle image upload
                    String fileName = null;
                    Part filePart = request.getPart("file"); // Assuming the form field name is "file"
                    if (filePart != null && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        fileName = extractFileName(filePart);

                        // Save the image file
                        try (InputStream input = filePart.getInputStream()) {
                            Path filePath = new File(uploadDir, fileName).toPath();
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);

                            // Set the image path in the Ads object
                            String relativeImagePath = "upload" + File.separator + fileName;
                            ads.setImage(relativeImagePath);
                        }
                    }

                    ads.setUploadPath(fileName != null ? "upload" + File.separator + fileName : "");

                    // Call boostAdvertising with the Ads object
                    Ads_DB adsDB = new Ads_DB();
                    adsDB.boostAdvertising(ads);

                    // Redirect to the advertising page
                    response.sendRedirect(request.getContextPath() + "/advertising/campaign/detail?id=" + ads.getAdsDetailId());

                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception for debugging
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
                }
                break;

            case "changeActive":
                try {
                    int adsId = Integer.parseInt(request.getParameter("adsId"));
                    int isActive = Integer.parseInt(request.getParameter("isActive"));

                    Ads_DB adsDB = new Ads_DB();
                    adsDB.changeActive(adsId, isActive);

                    // Respond with JSON
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true}");
                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception for debugging

                    // Respond with JSON error message
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"An error occurred while processing your request.\"}");
                }
                break;

            case "delete":
                try {
                    int adsId = Integer.parseInt(request.getParameter("id"));
                    Ads_DB adsDB = new Ads_DB();
                    adsDB.removeAdvertising(adsId);

                    // Trả về phản hồi JSON
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print("{\"success\": true}");
                    out.flush();

                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception for debugging

                    // Respond with JSON error message
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"An error occurred while processing your request.\"}");
                }
                break;

            default:
                throw new AssertionError("Unknown action: " + action);
        }
    }

// Utility method to extract the file name from the Part header
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Advertising Boost Servlet";
    }
}
