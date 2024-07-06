/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package chat;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class AESUtil {

    private static final String ALGORITHM = "AES";
    private static final String TRANSFORMATION = "AES/ECB/PKCS5Padding";
    private static final String AES_KEY = "myaesencryptionk"; // 16 bytes key for AES-128

    public static String encrypt(String message) throws Exception {
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        SecretKeySpec keySpec = new SecretKeySpec(AES_KEY.getBytes("UTF-8"), ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        byte[] encryptedBytes = cipher.doFinal(message.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    public static String decrypt(String encryptedMessage) throws Exception {
        try {
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            SecretKeySpec keySpec = new SecretKeySpec(AES_KEY.getBytes("UTF-8"), ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, keySpec);
            byte[] encryptedBytes = Base64.getDecoder().decode(encryptedMessage);
            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            return new String(decryptedBytes, "UTF-8");
        } catch (Exception e) {
            // Xử lý ngoại lệ và in ra thông báo lỗi
            e.printStackTrace();
            return null; // Trả về null nếu có lỗi xảy ra trong quá trình giải mã
        }
    }

    public static void main(String[] args) {
        try {
            String originalMessage = "31";
            String encryptedMessage = AESUtil.encrypt(originalMessage);
            String decryptedMessage = AESUtil.decrypt(encryptedMessage);

            System.out.println("Original Message: " + originalMessage);
            System.out.println("Encrypted Message: " + encryptedMessage);
            System.out.println("Decrypted Message: " + decryptedMessage);

            // Kiểm tra xem giải mã có khớp với thông điệp gốc không
            if (originalMessage.equals(decryptedMessage)) {
                System.out.println("Mã hóa và giải mã thành công!");
            } else {
                System.out.println("Có lỗi trong quá trình mã hóa/giải mã!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
