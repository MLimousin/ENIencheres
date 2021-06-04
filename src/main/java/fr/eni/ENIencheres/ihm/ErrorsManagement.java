package fr.eni.ENIencheres.ihm;

import java.util.List;

import fr.eni.ENIencheres.bll.BLLException;
import fr.eni.ENIencheres.dal.DALException;
import jakarta.servlet.http.HttpServletRequest;

public class ErrorsManagement {
	/**
     * Treat a BLLException errors message and them to an ArrayList
     * @param e The BLLException
     * @param errors The ArrayList
     * @param request The instance of the HTTP request
     */
    public static void BLLExceptionsCatcher(BLLException e, List<String> errors, HttpServletRequest request) {
        for (Integer code_error : e.getListErrorCodes()) 
        request.setAttribute("errors", errors);
    }
    /**
     * Treat a BLLException errors message and them to an ArrayList
     * Send also a custom attribute to the jsp
     * @param e The BLLException
     * @param errors The ArrayList
     * @param request The instance of the HTTP request
     */
    public static void DALExceptionsCatcher(DALException e, List<String> errors, HttpServletRequest request) {
        request.setAttribute("error_name", "Erreur avec la base de données : ");
        for (Integer code_error : e.getListErrorCodes()) 
        request.setAttribute("errors", errors);
    }

}
