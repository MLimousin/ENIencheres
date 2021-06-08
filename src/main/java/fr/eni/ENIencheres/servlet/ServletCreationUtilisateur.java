package fr.eni.ENIencheres.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import fr.eni.ENIencheres.bll.BLLException;
import fr.eni.ENIencheres.bll.UtilisateurManager;
import fr.eni.ENIencheres.bo.Utilisateur;
import fr.eni.ENIencheres.dal.DALException;
import fr.eni.ENIencheres.ihm.ErrorsManagement;
import fr.eni.ENIencheres.ihm.ManagementTools.PasswordManagement;
import fr.eni.ENIencheres.ihm.ManagementTools.RequestManagement;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/createLogin")
public class ServletCreationUtilisateur extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        UtilisateurManager um = new UtilisateurManager();
        List<String> errors = new ArrayList<>();
        // Hash password
        String password = request.getParameter("password");
        String generatedPassword = PasswordManagement.hashPassword(password);
        // New user
        Utilisateur utilisateur = new Utilisateur(
                request.getParameter("pseudo"),
                request.getParameter("name"),
                request.getParameter("first_name"),
                request.getParameter("mail"),
                request.getParameter("phone"),
                request.getParameter("street"),
                request.getParameter("post_code"),
                request.getParameter("city"),
                generatedPassword,
                0,
                false
        );
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/index.jsp");
        try {
            um.creationUtilisateur(utilisateur);
        } catch (BLLException e) {
            ErrorsManagement.BLLExceptionsCatcher(e, errors, request);
        } catch (DALException e) {
            ErrorsManagement.DALExceptionsCatcher(e, errors, request);
        }
        if (errors.isEmpty()) {
            try {
                RequestManagement.processHomePageAttributes(request);
            } catch (DALException e) {
                ErrorsManagement.DALExceptionsCatcher(e, errors, request);
            } catch (BLLException e) {
                ErrorsManagement.BLLExceptionsCatcher(e, errors, request);
            }
            request.setAttribute("loginCreated", "true");
            request.setAttribute("page", "home");
        } else {
            request.setAttribute("page", "createLogin");
            request.setAttribute("utilisateurError", utilisateur);
        }
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/index.jsp");
        request.setAttribute("page", "createLogin");
        rd.forward(request, response);
    }
}
