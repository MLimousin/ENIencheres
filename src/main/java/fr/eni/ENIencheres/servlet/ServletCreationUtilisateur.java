package fr.eni.ENIencheres.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import fr.eni.ENIencheres.bll.ArticleVenduManager;
import fr.eni.ENIencheres.bll.BLLException;
import fr.eni.ENIencheres.bll.UtilisateurManager;
import fr.eni.ENIencheres.bo.Utilisateur;
import fr.eni.ENIencheres.dal.DALException;
import fr.eni.ENIencheres.ihm.ErrorsManagement;
import fr.eni.ENIencheres.message.BusinessException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/createLogin")
public class ServletCreationUtilisateur extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        // Hash password
        String password = request.getParameter("password");
        // New user
        Utilisateur utilisateur = new Utilisateur(
                request.getParameter("pseudo"),
                request.getParameter("nom"),
                request.getParameter("prenom"),
                request.getParameter("email"),
                request.getParameter("telephone"),
                request.getParameter("rue"),
                request.getParameter("code_postal"),
                request.getParameter("ville"),
                password,
                0,
                false
        );
        
        UtilisateurManager utilisateurMgr = new UtilisateurManager();
		try {
			//enregistrement dans la base de données
			utilisateurMgr.creationUtilisateur(utilisateur);
			//Si tout se passe bien, je vais vers la page de Liste enchères mode connecté:
			request.getSession().setAttribute("categorie", "Toutes");
			RequestDispatcher rd = request.getRequestDispatcher("/ListeEncheres");
			rd.forward(request, response);
		} catch (BLLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/jsp/Inscription.jsp");
		     rd.forward(request, response);
		} catch (DALException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/jsp/Inscription.jsp");
		    rd.forward(request, response);
		}
        
       
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/jsp/Inscription.jsp");
        request.setAttribute("page", "createLogin");
        rd.forward(request, response);
    }
}
