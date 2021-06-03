/**
 * 
 */
package fr.eni.ENIencheres.dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import fr.eni.ENIencheres.bo.ArticleVendu;


/**
 * @author mariedebroise
 *
 */
public class ArticleVenduDAOJdbcImpl implements ArticleVenduDAO{

	private static final String INSERT="INSERT INTO ARTICLES_VENDUS(nom_article, description, date_debut_encheres, date_fin_encheres, prix_initial, no_utilisateur, no_categorie) "
			+ "									VALUES(?, ?, ?, ?, ?, ?, ?);";
	private static final String SELECTALL="SELECT * FROM ARTICLES_VENDUS;";
	private static final String SELECTBYNAME="SELECT * FROM ARTICLES_VENDUS WHERE nomArticle=?;";
	private static final String DELETE="DELETE FROM ARTICLES_VENDUS WHERE noArticle=?;";

	
	public ArticleVenduDAOJdbcImpl() {
		
	}
	
	@Override
	public void insert(ArticleVendu articleVendu) {
		try(Connection cnx = ConnectionProvider.getConnection())
		{
			PreparedStatement pstmt = cnx.prepareStatement(INSERT, PreparedStatement.RETURN_GENERATED_KEYS);
			
			
			String nomArticle = articleVendu.getNomArticle(); 
			String description = articleVendu.getDescription();
			Date dateDebutEncheres = articleVendu.getDateDebutEncheres();
			Date dateFinEncheres = articleVendu.getDateFinEncheres();
			int miseAPrix = articleVendu.getMiseAPrix();
			int noUtilisateur = articleVendu.getNoUtilisateur();
			int noCategorie = articleVendu.getNoCategorie();
			
			pstmt.setString(1, nomArticle);
			pstmt.setString(2, description);
			pstmt.setDate(3,(java.sql.Date) dateDebutEncheres);
			pstmt.setDate(4, (java.sql.Date) dateFinEncheres);
			pstmt.setInt(5, miseAPrix);
			pstmt.setInt(6, noUtilisateur);
			pstmt.setInt(7, noCategorie);
			
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next())
			{
				articleVendu.setNoArticle(rs.getInt(1));
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
	}

	@Override
	public List<ArticleVendu> selectAll() {
		List<ArticleVendu> listeEncheres = new ArrayList<ArticleVendu>();
		
		try(Connection cnx = ConnectionProvider.getConnection())
		{
			Statement stmt = cnx.createStatement();
			
			ResultSet rs = stmt.executeQuery(SELECTALL);
			
			ArticleVendu articleVendu = null;
			while(rs.next()){
				articleVendu = new ArticleVendu(rs.getInt("no_article"), rs.getString("nom_article"), rs.getString("description"), rs.getDate("date_debut_encheres"), rs.getDate("date_fin_encheres"), rs.getInt("prix_initial"), rs.getInt("prix_vente"), rs.getInt("no_utilisateur"), rs.getInt("no_categorie"));
				listeEncheres.add(articleVendu);
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
		
		return listeEncheres;
	}

	@Override
	public ArticleVendu selectbyName(String nomArticle) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(ArticleVendu articleVendu) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int noArticle) {
		// TODO Auto-generated method stub
		
	}

}
