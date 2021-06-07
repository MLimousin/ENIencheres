package fr.eni.ENIencheres.message;

public abstract class CodeErreur {
	
	//ERREURS FORMULAIRE NOUVELLE VENTE
	/**
	 * Format article incorrect ou vide
	 */
	public static final int ERREUR_ARTICLE=30001;
	/**
	 * Format description incorrect ou vide
	 */
	public static final int ERREUR_DESCRIPTION=30002;
	/**
	 * Format catégorie incorrect ou vide
	 */
	public static final int ERREUR_CATEGORIE=30003;
	/**
	 * Format prix incorrect ou vide
	 */
	public static final int ERREUR_PRIX=30004;
	/**
	 * Format date de début enchère incorrect ou vide
	 */
	public static final int ERREUR_FORMAT_DATE_DEBUT=30005;
	/**
	 * Format date de fin enchères incorrect ou vide
	 */
	public static final int ERREUR_FORMAT_DATE_FIN=30006;
	
	
	//ERREURS BLL
	/**
	 * Date début incohérente
	 */
	public static final int ERREUR_DATE_DEBUT=20001;
	/**
	 * Date fin incohérente
	 */
	public static final int ERREUR_DATE_FIN=20002;
}
