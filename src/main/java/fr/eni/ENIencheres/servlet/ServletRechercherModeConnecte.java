package fr.eni.ENIencheres.servlet;

import java.io.IOException;
import java.util.List;

import fr.eni.ENIencheres.bll.ArticleVenduManager;
import fr.eni.ENIencheres.bll.CategorieManager;
import fr.eni.ENIencheres.bll.UtilisateurManager;
import fr.eni.ENIencheres.bo.ArticleVendu;
import fr.eni.ENIencheres.bo.Categorie;
import fr.eni.ENIencheres.bo.Utilisateur;
import fr.eni.ENIencheres.dal.DALException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServletRechercherModeConnecte
 */
@WebServlet("/ServletRechercherModeConnecte")
public class ServletRechercherModeConnecte extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
			
		/*liste de catégories dans la base de données : table CATEGORIES*/
		CategorieManager categorieMgr = new CategorieManager();
		List<Categorie> categories = categorieMgr.selectAll();
		
		this.getServletContext().setAttribute("categories", categories);
		super.init();
	}
   
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArticleVenduManager articleVenduMgr = new ArticleVenduManager();
		List<ArticleVendu> listeEncheres = articleVenduMgr.selectAll();		
		
		UtilisateurManager utilisateurMgr = new UtilisateurManager();
		List<Utilisateur> listeUtilisateurs = null;
		try {
			listeUtilisateurs = utilisateurMgr.getAllUtilisateurs();
		} catch (DALException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String identifiant = (String) request.getSession().getAttribute("identifiant");
		Utilisateur utilisateurConnecte = new Utilisateur();
		for (Utilisateur u : listeUtilisateurs) {
			if (u.getPseudo().equals(identifiant)) {
				utilisateurConnecte = u;
			}
		}
		
		request.setAttribute("listeEncheres", listeEncheres);
		request.setAttribute("listeUtilisateurs", listeUtilisateurs);
		request.setAttribute("utilisateurConnecte", utilisateurConnecte);

		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/ListeEncheres.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().setAttribute("categorieChoisie", request.getParameter("categorieChoisie"));
		request.getSession().setAttribute("filtreSaisie", request.getParameter("filtre"));
		request.getSession().setAttribute("achatsEtVentes", request.getParameter("achatsEtVentes"));
		request.getSession().setAttribute("achats", request.getParameter("achats"));
		request.getSession().setAttribute("ventes", request.getParameter("ventes"));

		doGet(request,response);
	}

}
