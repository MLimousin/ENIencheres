package fr.eni.ENIencheres.bo;

import java.io.Serializable;

public class Utilisateur implements Serializable {
	
    private int     noUtilisateur;
    private String  pseudo;
    private String  nom;
    private String  prenom;
    private String  email;
    private String  telephone;
    private String  rue;
    private String  codePostal;
    private String  ville;
    private String  motDePasse;
    private int     credit;
    private boolean administrateur;

    /**
     * constructor sans paramètres
     */
    public Utilisateur() {
    }

    /**
     * Constructeur avec paramètres sans noUtilisateur
     * @param pseudo String must not exceed 30 chars
     * @param nom String must not exceed 30 chars
     * @param prenom String must not exceed 30 chars
     * @param email String must not exceed 20 chars
     * @param telephone String must not exceed 15 chars
     * @param rue String must not exceed 30 chars
     * @param codePostal String must not exceed 10 chars
     * @param ville String must not exceed 30 chars
     * @param motDePasse String must not exceed 30 chars
     * @param credit integer
     * @param administrateur boolean
     */
    public Utilisateur(String pseudo,
                       String nom,
                       String prenom,
                       String email,
                       String telephone,
                       String rue,
                       String codePostal,
                       String ville,
                       String motDePasse,
                       int credit,
                       boolean administrateur) {
        this.pseudo = pseudo;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.telephone = telephone;
        this.rue = rue;
        this.codePostal = codePostal;
        this.ville = ville;
        this.motDePasse = motDePasse;
        this.credit = credit;
        this.administrateur = administrateur;
    }

    /**
     * Constructeur avec paramètres
     * @param noUtilisateur int The id of the user in database
     * @param pseudo String must not exceed 30 chars
     * @param nom String must not exceed 30 chars
     * @param prenom String must not exceed 30 chars
     * @param email String must not exceed 20 chars
     * @param telephone String must not exceed 15 chars
     * @param rue String must not exceed 30 chars
     * @param codePostal String must not exceed 10 chars
     * @param ville String must not exceed 30 chars
     * @param motDePasse String must not exceed 30 chars
     * @param credit int
     * @param administrateur boolean
     */
    public Utilisateur(int noUtilisateur,
                       String pseudo,
                       String nom,
                       String prenom,
                       String email,
                       String telephone,
                       String rue,
                       String codePostal,
                       String ville,
                       String motDePasse,
                       int credit,
                       boolean administrateur) {
        this.noUtilisateur = noUtilisateur;
        this.pseudo = pseudo;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.telephone = telephone;
        this.rue = rue;
        this.codePostal = codePostal;
        this.ville = ville;
        this.motDePasse = motDePasse;
        this.credit = credit;
        this.administrateur = administrateur;
    }

    // Getters and setters
    public int getNoUtilisateur() {
        return noUtilisateur;
    }

    public void setNoUtilisateur(int noUtilisateur) {
        this.noUtilisateur = noUtilisateur;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getRue() {
        return rue;
    }

    public void setRue(String rue) {
        this.rue = rue;
    }

    public String getCodePostal() {
        return codePostal;
    }

    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public boolean isAdministrateur() {
        return administrateur;
    }

    public void setAdministrateur(boolean administrateur) {
        this.administrateur = administrateur;
    }

    @Override
    public String toString() {
        return "Utilisateur{" +
                "noUtilisateur=" + noUtilisateur +
                ", pseudo='" + pseudo + '\'' +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                ", rue='" + rue + '\'' +
                ", codePostal='" + codePostal + '\'' +
                ", ville='" + ville + '\'' +
                ", motDePasse='" + motDePasse + '\'' +
                ", credit=" + credit +
                ", administrateur=" + administrateur +
                '}';
    }
}