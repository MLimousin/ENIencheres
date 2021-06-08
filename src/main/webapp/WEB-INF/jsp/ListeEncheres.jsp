<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@page import="fr.eni.ENIencheres.bo.ArticleVendu" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AccueilConnect</title>
</head>

<body>
    
    <!-- En-tête -->
    <header>

        <!-- Titre -->
        <h1>ENI Enchères</h1>
    
        <!-- Sous-titre -->
        <h2>Liste des enchères</h2>

        <!-- Lien déconnexion -->
        <a href="ServletRechercher">
            Déconnexion
        </a>

        <!-- Lien mon profil -->
        <a href="http://google.com">
            Mon profil
        </a>

        <!-- Lien vendre un article -->
        <a href="ServletNouvelleVente">
            Vendre un article
        </a>
    
        <!-- Lien enchères -->
        <a href="http://google.com">
            Enchères
        </a>
        
    </header>
   	
   	<!-- 	création de la variable "utilisateur" pour filtrer l'affichage des articles en fonction de la personne connectée -->
    <jsp:useBean id="utilisateur" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty utilisateurConnecte}">
			<c:set var="utilisateur" value="${utilisateurConnecte}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="utilisateur" value="" scope="session" />
		</c:otherwise>
	</c:choose>	
    <!-- 	création de la variable "categorie" pour filtrer l'affichage des articles en fonction de la sélection -->
	<jsp:useBean id="categorie" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty categorieChoisie}">
			<c:set var="categorie" value="${categorieChoisie}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="categorie" value="Toutes" scope="session" />
		</c:otherwise>
	</c:choose>	
	
	<!-- 	création de la variable "aujourdhui" pour filtrer l'affichage des articles en cours de vente -->	
	<jsp:useBean id="aujourdhui" class="java.util.Date" />
	<fmt:formatDate var="dateDuJour" value="${aujourdhui}" pattern="yyyy-MM-dd" />
	
	
	<!-- 	création de la variable "saisie" pour filtrer l'affichage des articles en fonction de la recherche saisie -->
	<jsp:useBean id="saisie" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty filtreSaisie}">
			<c:set var="saisie" value="${filtreSaisie}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="saisie" value="" scope="session" />
		</c:otherwise>
	</c:choose>
	
	<!-- 	création de la variable "radio" pour filtrer l'affichage des articles en fonction du radio bouton achat/vente -->
	<jsp:useBean id="radio" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty achatsEtVentes}">
			<c:set var="radio" value="${achatsEtVentes}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="radio" value="Achats" scope="session" />
		</c:otherwise>
	</c:choose>	
	
	<!-- 	création de la variable "ckAchats" pour filtrer l'affichage des articles en fonction du checkbox achats -->
	<jsp:useBean id="ckAchats" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty achats}">
			<c:set var="ckAchats" value="${achats}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="ckAchats" value="EncheresOuvertes" scope="session" />
		</c:otherwise>
	</c:choose>	
	
	<!-- 	création de la variable "ckVentes" pour filtrer l'affichage des articles en fonction du checkbox ventes -->
	<jsp:useBean id="ckVentes" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty ventes}">
			<c:set var="ckVentes" value="${ventes}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="ckVentes" value="" scope="session" />
		</c:otherwise>
	</c:choose>	
	
<!-- 	début du formulaire -->	
	
	<form action="ServletRechercherModeConnecte" method="post">
		<div >
		<section class="auction">
		    <h1><label for="filtre">Filtres : </label></h1>
		 
		    <input type="search" name="filtre" id="filtre" size="40" placeholder="Le nom de l'article contient...">
		    <input class="search-btn" type="submit" value="Rechercher">
		    
		    <section class="choice">
			    <label for="categorieChoisie">Catégories : </label>
			    <select name="categorieChoisie" id="categorieChoisie">
			   		<c:forEach var="categorieDispo" items="${categories}">
						<option value=${categorieDispo.libelleCategorie} ${categorieDispo.libelleCategorie==categorie?"selected":""}>${categorieDispo.libelleCategorie}</option>
						<%int numeroCategorie;%>
						<c:if test="${categorieDispo.libelleCategorie==categorie}">
							${numeroCategorie=categorieDispo.noCategorie}
						</c:if>
					</c:forEach>
				</select>
			</section>
			
			<input type="hidden" name="pseudo" value="${utilisateur}">
			<table>
				<!-- Choix unique "radio button" -->
				<tr>
		            <td>
		            	<label for="Achats">Achats</label>
		            	<input type="radio" name="achatsEtVentes" id="Achats" onchange="masquerSelectionVentes(this)" ${radio=='Achats'?"checked":""} />
		            </td>
		            <td>
		            	<label for="Ventes">Ventes</label>
	            		<input type="radio" name="achatsEtVentes" id="Ventes" onchange="masquerSelectionAchats(this)" ${radio=='Ventes'?"checked":""}/>
	            	</td>
        		</tr>
        		<!-- Choix unique "checkbox" -->
        		<tr>
        		<div id="AchatOuVente"></div>
        		        		<c:out value="${radio}"/>
        		
		            <td>
		            	<div>
				            <input type="checkbox" name="achats" id="EncheresOuvertes" ${ckAchats=='EncheresOuvertes'?"checked":""} ${radio=='Ventes'?"disabled":""}/>
				            <label for="EncheresOuvertes">Enchères ouvertes</label>
				        </div>
				        <div>
				        	<input type="checkbox" name="achats" id="MesEncheresEnCours" ${ckAchats=='MesEncheresEnCours'?"checked":""} ${radio=='Ventes'?"disabled":""}/>
				            <label for="MesEncheresEnCours">Mes enchères en cours</label>
				        </div>
				        <div>
				            <input type="checkbox" name="achats" id="MesEncheresRemportees" ${ckAchats=='MesEncheresRemportees'?"checked":""} ${radio=='Ventes'?"disabled":""}/>
				            <label for="MesEncheresRemportees">Mes enchères remportées</label>
				        </div>
		            </td>
		            <td>
						<div>
				            <input type="checkbox" name="ventes" id="MesVentesEnCours" ${ckVentes=='MesVentesEnCours'?"checked":""} ${radio=='Achats'?"disabled":""}/>
				            <label for="MesVentesEnCours">Mes ventes en cours</label>
				        </div>
				        <div>
				            <input type="checkbox" name="ventes" id="VentesNonDebutees" ${ckVentes=='VentesNonDebutees'?"checked":""} ${radio=='Achats'?"disabled":""}/>
				            <label for="VentesNonDebutees">Ventes non débutées</label>
				        </div>
				        <div>
				            <input type="checkbox" name="ventes" id="VentesTerminees" ${ckVentes=='VentesTerminees'?"checked":""} ${radio=='Achats'?"disabled":""}/>
				            <label for="VentesTerminees">Ventes terminées</label>
				        </div>
				   	</td>
				   	
        		</tr>
        		
			</table>       
	        
		</section>
		
		<section class="liveAuction">
			<h1>Enchères en cours</h1>	
		
			<c:choose>
				<c:when test="${not empty listeEncheres && listeEncheres.size()>0}">
				<div class="row">	
					<c:forEach var="articleVendu" items="${listeEncheres}">
						<c:if test="${articleVendu.dateDebutEncheres<dateDuJour && articleVendu.dateFinEncheres>dateDuJour}">
							<c:choose>
								<c:when test="${saisie==''}">
									<c:choose>
										<c:when test="${categorie=='Toutes'}">
										<div class="liveAuction-col">
										
											<!-- !!!!! Voir pour insérer une image à partir de la bdd -->
											
											<p>${articleVendu.nomArticle}</p>
											<p>Prix : ${articleVendu.miseAPrix} points</p>
											<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
											<p> Vendeur : 
												<c:forEach var="utilisateur" items="${listeUtilisateurs}">
													<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
														${utilisateur.pseudo}
													</c:if>
												</c:forEach>	
											</p>	
										</div>									
										</c:when >
										<c:when test="${articleVendu.noCategorie==numeroCategorie}">
										<div class="liveAuction-col">
										
											<!-- !!!!! Voir pour insérer une image à partir de la bdd -->
											
											<p>${articleVendu.nomArticle}</p>
											<p>Prix : ${articleVendu.miseAPrix} points</p>
											<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
											<p>Vendeur : 
												<c:forEach var="utilisateur" items="${listeUtilisateurs}">
													<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
														${utilisateur.pseudo}
													</c:if>
												</c:forEach>
											</p>	
										</div>							
										</c:when>	
									</c:choose>
								</c:when>	
								<c:when test="${saisie!=''}">
									<c:if test="${fn:containsIgnoreCase(articleVendu.nomArticle, saisie)}">
										<c:choose>
											<c:when test="${categorie=='Toutes'}">
											<div class="liveAuction-col">
											
												<!-- !!!!! Voir pour insérer une image à partir de la bdd -->
											
												<p>${articleVendu.nomArticle}</p>
												<p>Prix : ${articleVendu.miseAPrix} points</p>
												<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
												<p> Vendeur : 
													<c:forEach var="utilisateur" items="${listeUtilisateurs}">
														<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
															${utilisateur.pseudo}
														</c:if>
													</c:forEach>
												</p>	
											</div>
											</c:when >
											<c:when test="${articleVendu.noCategorie==numeroCategorie}">
											<div class="liveAuction-col">
												
												<!-- !!!!! Voir pour insérer une image à partir de la bdd -->
											
												<p>${articleVendu.nomArticle}</p>
												<p>Prix : ${articleVendu.miseAPrix} points</p>
												<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
												<p> Vendeur : 
													<c:forEach var="utilisateur" items="${listeUtilisateurs}">
														<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
															${utilisateur.pseudo}
														</c:if>
													</c:forEach>
												</p>
											</div>								
											</c:when>	
										</c:choose>
									</c:if>
								</c:when>
							</c:choose>
						</c:if>	
								
					</c:forEach>
				</div>
				</c:when>
				<c:otherwise>
					<p>Il n'y a aucun article en vente actuellement</p>
				</c:otherwise>
			</c:choose>		
		</section>		
		</div>
	</form>
	
	<!-- JAVASCRIPT pour menu/x version smartphone -->
    <script>
        var navLinks = document.getElementById("navLinks");
        function showMenu() {
            navLinks.style.right = "0";
        }
        function hideMenu() {
            navLinks.style.right = "-200px";
        }
 
    <!-- JavaScript pour rendre sélectionnable/non sélectionnable les checkbox en fonction du radio button -->
 
		function masquerSelectionVentes(BtnRadio)
		{
			 if(BtnRadio.checked==true)
			 {
				 document.getElementById("EncheresOuvertes").removeAttribute("disabled");
				 document.getElementById("MesEncheresEnCours").removeAttribute("disabled");
				 document.getElementById("MesEncheresRemportees").removeAttribute("disabled");
				 document.getElementById("MesVentesEnCours").checked=false;
				 document.getElementById("VentesNonDebutees").checked=false;
				 document.getElementById("VentesTerminees").checked=false;
				 document.getElementById("MesVentesEnCours").disabled = true;
				 document.getElementById("VentesNonDebutees").disabled = true;
				 document.getElementById("VentesTerminees").disabled = true;
				 
				 
			 }else{
				 document.getElementById("EncheresOuvertes").checked=false;
				 document.getElementById("MesEncheresEnCours").checked=false;
				 document.getElementById("MesEncheresRemportees").checked=false;
				 document.getElementById("EncheresOuvertes").disabled = true;
				 document.getElementById("MesEncheresEnCours").disabled = true;
				 document.getElementById("MesEncheresRemportees").disabled = true; 
				 document.getElementById("MesVentesEnCours").removeAttribute("disabled");
				 document.getElementById("VentesNonDebutees").removeAttribute("disabled");
				 document.getElementById("VentesTerminees").removeAttribute("disabled");
			 }
			 
		}
		function masquerSelectionAchats(BtnRadio)
		{	
			 if(BtnRadio.checked==true)
			 {
				 document.getElementById("MesVentesEnCours").removeAttribute("disabled");
				 document.getElementById("VentesNonDebutees").removeAttribute("disabled");
				 document.getElementById("VentesTerminees").removeAttribute("disabled");
				 document.getElementById("EncheresOuvertes").checked=false;
				 document.getElementById("MesEncheresEnCours").checked=false;
				 document.getElementById("MesEncheresRemportees").checked=false;
				 document.getElementById("EncheresOuvertes").disabled = true;
				 document.getElementById("MesEncheresEnCours").disabled = true;
				 document.getElementById("MesEncheresRemportees").disabled = true;
			 }else{
				 document.getElementById("MesVentesEnCours").checked=false;
				 document.getElementById("VentesNonDebutees").checked=false;
				 document.getElementById("VentesTerminees").checked=false;
				 document.getElementById("MesVentesEnCours").disabled = true;
				 document.getElementById("VentesNonDebutees").disabled = true;
				 document.getElementById("VentesTerminees").disabled = true; 
				 document.getElementById("EncheresOuvertes").removeAttribute("disabled");
				 document.getElementById("MesEncheresEnCours").removeAttribute("disabled");
				 document.getElementById("MesEncheresRemportees").removeAttribute("disabled");
			 }	 
		}
		
	</script>     


</body>
</html>