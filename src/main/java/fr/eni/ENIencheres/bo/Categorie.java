/**
 * 
 */
package fr.eni.ENIencheres.bo;

import java.io.Serializable;

/**
 * @author mariedebroise
 *
 */
public class Categorie implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int noCategorie;
	private String libelleCategorie;
	
	/**
	 * 
	 */
	public Categorie() {

	}
	/**
	 * @param libelleCategorie
	 */
	public Categorie(String libelleCategorie) {
		this.libelleCategorie = libelleCategorie;
	}
	/**
	 * @param noCategorie
	 * @param libelleCategorie
	 */
	public Categorie(int noCategorie, String libelleCategorie) {
		this.noCategorie = noCategorie;
		this.libelleCategorie = libelleCategorie;
	}
	
	/**
	 * GETTER et SETTER
	 */
	public int getNoCategorie() {
		return noCategorie;
	}
	public void setNoCategorie(int noCategorie) {
		this.noCategorie = noCategorie;
	}
	public String getLibelleCategorie() {
		return libelleCategorie;
	}
	public void setLibelleCategorie(String libelleCategorie) {
		this.libelleCategorie = libelleCategorie;
	}
	
	
	
}
