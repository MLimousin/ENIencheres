/**
 * 
 */
package fr.eni.ENIencheres.bll;

import java.util.List;

import fr.eni.ENIencheres.bo.ArticleVendu;
import fr.eni.ENIencheres.dal.ArticleVenduDAO;
import fr.eni.ENIencheres.dal.DAOFactory;

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
	
}
