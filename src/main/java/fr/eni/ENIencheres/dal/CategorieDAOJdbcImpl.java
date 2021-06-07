/**
 * 
 */
package fr.eni.ENIencheres.dal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import fr.eni.ENIencheres.bo.ArticleVendu;
import fr.eni.ENIencheres.bo.Categorie;

/**
 * @author mariedebroise
 *
 */
public class CategorieDAOJdbcImpl implements CategorieDAO{

	private static final String INSERT="INSERT INTO CATEGORIES(libelle) VALUES(?);";
	private static final String SELECTALL="SELECT * FROM CATEGORIES;";
	private static final String SELECTBYNAME="SELECT * FROM CATEGORIES WHERE libelle=?;";
	private static final String DELETE="DELETE FROM CATEGORIES WHERE no_categorie=?;";
	
	public CategorieDAOJdbcImpl() {
		
	}

	@Override
	public void insert(Categorie categorie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Categorie> selectAll() {
		List<Categorie> listeCategories = new ArrayList<Categorie>();
		
		try(Connection cnx = ConnectionProvider.getConnection())
		{
			Statement stmt = cnx.createStatement();
			
			ResultSet rs = stmt.executeQuery(SELECTALL);
			
			Categorie categorie = null;
			while(rs.next()){
				categorie = new Categorie(rs.getInt("no_categorie"), rs.getString("libelle"));
				listeCategories.add(categorie);
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
		
		return listeCategories;
	}

	@Override
	public Categorie selectbyName(String libelleCategorie) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(int noCategorie) {
		// TODO Auto-generated method stub
		
	}
	
	
}
