package fr.eni.ENIencheres.dal;

import java.util.List;

import fr.eni.ENIencheres.bo.Categorie;


public interface CategorieDAO {
	public void insert(Categorie categorie);
	public List<Categorie> selectAll();
	public Categorie selectbyName(String libelleCategorie);
	public void delete(int noCategorie);
}
