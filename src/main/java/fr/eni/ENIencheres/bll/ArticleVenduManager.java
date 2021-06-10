/**
 * 
 */
package fr.eni.ENIencheres.bll;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import fr.eni.ENIencheres.bo.ArticleVendu;
import fr.eni.ENIencheres.dal.ArticleVenduDAO;
import fr.eni.ENIencheres.dal.DAOFactory;
import fr.eni.ENIencheres.message.BusinessException;
import fr.eni.ENIencheres.message.CodeErreur;

/**
 * @author mariedebroise
 *
 */
public class ArticleVenduManager {
	
	private ArticleVenduDAO articleVenduDAO;
	
	public ArticleVenduManager() {
		this.articleVenduDAO = DAOFactory.getArticleVenduDAO();
	}
	
	public List<ArticleVendu> selectAll(){
		List <ArticleVendu> listeEncheres = null;

		listeEncheres = articleVenduDAO.selectAll();
			
		return listeEncheres;
	}
	
	public ArticleVendu insert(String nomArticle, String description, Date dateDebutEncheres,Date dateFinEncheres, int miseAPrix, int noUtilisateur, int noCategorie, String photo) throws BusinessException {
		BusinessException businessException = new BusinessException();
		this.validerDateDebut(dateDebutEncheres, businessException);
		this.validerDateFin(dateFinEncheres, businessException);
		
		ArticleVendu articleVendu = null; 
		if(!businessException.hasErreurs()) {
			articleVendu = new ArticleVendu();
			articleVendu.setNomArticle(nomArticle);
			articleVendu.setDescription(description);
			articleVendu.setDateDebutEncheres(dateDebutEncheres);
			articleVendu.setDateFinEncheres(dateFinEncheres);
			articleVendu.setMiseAPrix(miseAPrix);
			articleVendu.setNoUtilisateur(noUtilisateur);
			articleVendu.setNoCategorie(noCategorie);
			articleVendu.setPhoto(photo);
			
			this.articleVenduDAO.insert(articleVendu);
		}else {
			throw businessException;
		}		
		return articleVendu;
	}
	
	private void validerDateDebut(Date date, BusinessException businessException) {
		Date now = new Date();
		
		if(date==null || date.before(now))
		{
			businessException.ajouterErreur(CodeErreur.ERREUR_DATE_DEBUT);
		}
		
	}
	private void validerDateFin(Date date, BusinessException businessException) {
		Date now = new Date();
		
		if(date==null || date.before(now))
		{
			businessException.ajouterErreur(CodeErreur.ERREUR_DATE_FIN);
		}
		
	}
}
