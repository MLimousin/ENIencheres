package fr.eni.ENIencheres.dal;

import java.sql.Connection;
import java.sql.SQLException;

public class JdbcTools {
	static Connection connect() {
        Connection cnx = null;
        try {
            cnx = ConnectionProvider.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cnx;
    }

}
