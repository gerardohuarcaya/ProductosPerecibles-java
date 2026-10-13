package dao;

import org.mindrot.jbcrypt.BCrypt;

public class GenerarHash {

    public static void main(String[] args) {

        String contraseña = "123456";

        String hash = BCrypt.hashpw(
                contraseña,
                BCrypt.gensalt(10)
        );

        System.out.println("Contraseña: " + contraseña);
        System.out.println("Hash BCrypt: " + hash);
    }
}
