package fr.eni.ENIencheres.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import fr.eni.ENIencheres.bll.ArticleVenduManager;
import fr.eni.ENIencheres.bll.CategorieManager;
import fr.eni.ENIencheres.bll.UtilisateurManager;
import fr.eni.ENIencheres.bo.Categorie;
import fr.eni.ENIencheres.bo.Utilisateur;
import fr.eni.ENIencheres.dal.DALException;
import fr.eni.ENIencheres.message.BusinessException;
import fr.eni.ENIencheres.message.CodeErreur;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServletNouvelleVente
 */
@WebServlet("/ServletNouvelleVente")
public class ServletNouvelleVente extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/NouvelleVente.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Lecture des paramètres
		List<Integer> listeCodeErreur = new ArrayList<>();
		
		String nomArticle = request.getParameter("article");
			if(nomArticle==null || nomArticle.trim().isEmpty())
			{
				listeCodeErreur.add(CodeErreur.ERREUR_ARTICLE);
			}
		String description = request.getParameter("description");
			if(description==null || description.trim().isEmpty())
			{
				listeCodeErreur.add(CodeErreur.ERREUR_DESCRIPTION);
			}
		Date debut = null;
			try {
				debut = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("debut"));
			} catch (ParseException e) {
				e.printStackTrace();
				listeCodeErreur.add(CodeErreur.ERREUR_FORMAT_DATE_DEBUT);
			}
		Date fin = null;
			try {
				fin = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fin"));
			} catch (ParseException e) {
				e.printStackTrace();
				listeCodeErreur.add(CodeErreur.ERREUR_FORMAT_DATE_FIN);
			}
		int prix = Integer.parseInt(request.getParameter("prix"));
			if(prix<=0)
				{
					listeCodeErreur.add(CodeErreur.ERREUR_PRIX);
				}
		
		int noUtilisateur=1;
			/*
			 * Récupérer le numéro de l'utilisateur depuis la page précédente pas encore créée
			 */
			
		String rue = request.getParameter("rue");
		String cp = request.getParameter("cp");
		String ville = request.getParameter("ville");
			if(rue.equals("") || cp.equals("") || ville.equals(""))
			{
				listeCodeErreur.add(CodeErreur.ERREUR_ADRESSE);
			}
			
		int noCategorie = 0;
			CategorieManager categorieMgr = new CategorieManager();
			List<Categorie> listeCategorie = categorieMgr.selectAll();
			for (Categorie c : listeCategorie) {
				if(c.getLibelleCategorie().equals(request.getParameter("categorie"))) {
					noCategorie = c.getNoCategorie();
				}
			}
			if(noCategorie==0)
			{
				listeCodeErreur.add(CodeErreur.ERREUR_CATEGORIE);
			}
		
		//Traitement de l'ajout
		if(listeCodeErreur.size()>0) {
			request.setAttribute("listeCodeErreur", listeCodeErreur);
			request.getSession().setAttribute("categorie", request.getParameter("categorie"));
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/NouvelleVente.jsp");
			rd.forward(request, response);
		} else {
			ArticleVenduManager articleVenduMgr = new ArticleVenduManager();
			try {
				articleVenduMgr.insert(nomArticle, description, debut,fin,prix,noUtilisateur,noCategorie);
				//Si tout se passe bien, je vais vers la page de consultation:
				request.getSession().setAttribute("categorie", "Toutes");
				RequestDispatcher rd = request.getRequestDispatcher("/ListeEncheres");
				rd.forward(request, response);
			} catch (BusinessException e) {
				//Sinon je retourne à la page d'ajout pour indiquer les problèmes:
				e.printStackTrace();
				request.getSession().setAttribute("categorie", request.getParameter("categorie"));
				request.setAttribute("listeCodeErreur",e.getListeCodeErreur());
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/NouvelleVente.jsp");
				rd.forward(request, response);
			}
		}
	}
	
	

}
