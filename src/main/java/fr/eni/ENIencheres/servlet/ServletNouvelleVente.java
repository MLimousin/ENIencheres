package fr.eni.ENIencheres.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import fr.eni.ENIencheres.bll.ArticleVenduManager;
import fr.eni.ENIencheres.bll.CategorieManager;
import fr.eni.ENIencheres.bo.Categorie;
import fr.eni.ENIencheres.message.BusinessException;
import fr.eni.ENIencheres.message.CodeErreur;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


public class ServletNouvelleVente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public static final int TAILLE_TAMPON = 10240; // 10 ko

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
		Part recupDebut = request.getPart("debut");
		String valeurDebut = getValeur(recupDebut);
		Date debut = null;
			try {
				debut = new SimpleDateFormat("yyyy-MM-dd").parse(valeurDebut);
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
		//Récupération de la zone de stockage des photos mise en parametre d'initialisation dans la déclaration de la servlet dans le web.xml 
		String chemin = this.getServletConfig().getInitParameter("chemin");
		//Récupération du fichier photo et du nom de la photo
		Part fichier = request.getPart("photo");
		String nomFichier = getNomFichier(fichier);
		//Création du chemin de la photo à enregistrer dans la bdd
		String photo = "";
			if(nomFichier != null && !nomFichier.isEmpty())
			{
				/*
			     * Antibug pour Internet Explorer, qui transmet pour une raison
			     * mystique le chemin du fichier local à la machine du client...
			     * 
			     * Ex : C:/dossier/sous-dossier/fichier.ext
			     * 
			     * On doit donc faire en sorte de ne sélectionner que le nom et
			     * l'extension du fichier, et de se débarrasser du superflu.
			     */
			    nomFichier = nomFichier.substring( nomFichier.lastIndexOf( '/' ) + 1 ).substring( nomFichier.lastIndexOf( '\\' ) + 1 );
			    request.setAttribute("nomPhoto", nomFichier);
			    photo="img/articles/"+nomFichier;
			}else {
				listeCodeErreur.add(CodeErreur.ERREUR_PHOTO);
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
				//enregistrement dans la base de données
				articleVenduMgr.insert(nomArticle, description, debut,fin,prix,noUtilisateur,noCategorie,photo);
				//enregistrement de l'image dans le dossier webapp/img/articles/
				ecrireFichier(fichier,nomFichier,chemin);
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
	

	/* 
	 * Méthode utilitaire qui a pour unique but d'analyser l'en-tête "content-disposition",
	 * et de vérifier si le paramètre "filename"  y est présent. Si oui, alors le champ traité
	 * est de type File et la méthode retourne son nom, sinon il s'agit d'un champ de formulaire 
	 * classique et la méthode retourne null. 
	 */
	private static String getNomFichier(Part part) {
	    /* Boucle sur chacun des paramètres de l'en-tête "content-disposition". */
	    for (String contentDisposition : part.getHeader("content-disposition").split(";")) {
	    	/* Recherche de l'éventuelle présence du paramètre "filename". */
	        if (contentDisposition.trim().startsWith("filename")) {
	            /* Si "filename" est présent, alors renvoi de sa valeur, c'est-à-dire du nom de fichier. */
	            return contentDisposition.substring(contentDisposition.indexOf('=')+1).trim().replace("\"","");
	        }
	    }
	    /* Et pour terminer, si rien n'a été trouvé... */
	    return null;
	}
	/*
	 * Méthode utilitaire qui a pour but d'écrire le fichier passé en paramètre
	 * sur le disque, dans le répertoire donné et avec le nom donné.
	 */
	private void ecrireFichier(Part part,String nomFichier,String chemin) throws IOException {
	    /* Prépare les flux. */
	    BufferedInputStream entree = null;
	    BufferedOutputStream sortie = null;
	    try {
	        /* Ouvre les flux. */
	        entree = new BufferedInputStream(part.getInputStream(),TAILLE_TAMPON);
	        sortie = new BufferedOutputStream(new FileOutputStream (new File(getServletContext().getRealPath(chemin+nomFichier))),TAILLE_TAMPON);
	        
	        System.out.println(getServletContext().getRealPath(chemin+nomFichier));
	        /*
	         * Lit le fichier reçu et écrit son contenu dans un fichier sur le disque.
	         */
	        byte[] tampon = new byte[TAILLE_TAMPON];
	        int longueur;
	        while ((longueur = entree.read(tampon)) != -1 ) {
	            sortie.write(tampon,0,longueur);
	        }
	 
	    } finally {
	        if(sortie!=null) {
	            sortie.close();
	        } 
	        if(entree!=null) {
	            entree.close();
	        } 
	    }
	}
	/*
	 * Méthode utilitaire qui a pour unique but de lire l'InputStream contenu
	 * dans l'objet part, et de le convertir en une banale chaîne de caractères.
	 */
	private String getValeur(Part part) throws IOException {
	    BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8" ) );
	    StringBuilder valeur = new StringBuilder();
	    char[] buffer = new char[1024];
	    int longueur = 0;
	    while ((longueur = reader.read(buffer)) > 0) {
	        valeur.append(buffer,0,longueur);
	    }
	    return valeur.toString();
	}
	

}
