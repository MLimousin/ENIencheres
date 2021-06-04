/**
 * 
 */
package fr.eni.ENIencheres.dal;

/**
 * @author mariedebroise
 *
 */
public abstract class DAOFactory {
	public static ArticleVenduDAO getArticleVenduDAO()
	{
		return new ArticleVenduDAOJdbcImpl();
	}
	public static UtilisateurDAO getUtilisateurDAO() 
	{
        return new UtilisateurDAOJdbcImpl();
    }
    
   
}
