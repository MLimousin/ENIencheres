/**
 * 
 */
package fr.eni.ENIencheres.dal;

import java.util.List;

import fr.eni.ENIencheres.bo.ArticleVendu;

/**
 * @author mariedebroise
 *
 */
public interface ArticleVenduDAO {
	
	public void insert(ArticleVendu articleVendu);
	public List<ArticleVendu> selectAll();
	public ArticleVendu selectbyName(String nomArticle);
	public void update(ArticleVendu articleVendu);
	public void delete(int noArticle);

}
