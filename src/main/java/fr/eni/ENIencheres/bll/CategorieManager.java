package fr.eni.ENIencheres.bll;

import java.util.List;

import fr.eni.ENIencheres.bo.Categorie;
import fr.eni.ENIencheres.dal.CategorieDAO;
import fr.eni.ENIencheres.dal.DAOFactory;

public class CategorieManager {
	private CategorieDAO categorieDAO;
	
	public CategorieManager() {
		this.categorieDAO = DAOFactory.getCategorieDAO();
	}
	
	public List<Categorie> selectAll(){
		List <Categorie> listeCategories = null;

		listeCategories = categorieDAO.selectAll();
			
		return listeCategories;
	}
}
