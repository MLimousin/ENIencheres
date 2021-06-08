package fr.eni.ENIencheres.dal;

import java.util.HashMap;
import java.util.List;

import fr.eni.ENIencheres.bo.Utilisateur;
import fr.eni.ENIencheres.dal.DALException;

public interface UtilisateurDAO {
	boolean checkForUniquePseudoAndMail(String pseudo, String mail) throws DALException;
    boolean checkForUniquePseudo(String pseudo) throws DALException;
    boolean checkForUniqueMail(String mail) throws DALException;
    Utilisateur selectUtilisateurByPseudo(String pseudo) throws DALException;
    HashMap<Integer, String> selectUtilisateursWithCurrentAuction() throws DALException;
    void updateCredit(int noUtilisateur, int newCredit) throws DALException;
	/**
	 * Extract data from the DB by id
	 * @param id int The id of the utilisateur to extract from the DB
	 * @return utilisateur An instance of the utilisateur
	 * @throws DALException if the SQL SELECT request is wrong
	 */
	Utilisateur selectById(int id) throws DALException;
	void insert(Utilisateur utilisateur) throws DALException;
	List<Utilisateur> selectAll() throws DALException;
	void delete(Utilisateur utilisateur) throws DALException;
	void update(Utilisateur utilisateur) throws DALException;
	
	 
}


