<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <title>Accueil ENI Enchères</title>
    <link type ="text/css" rel="stylesheet" href="css/AccEniEnch.css">
    <link rel="preconnect" href="https://fonts.gstatic.com"> 
    <link href="https://fonts.googleapis.com/css2?family=Hachi+Maru+Pop&family=Open+Sans&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
	<header>
        <nav>
            <a href=ServletRechercher><img src="img/logo ENI.jpg" alt="ENI école informatique"></a>
            <div class="nav-links" id="navLinks">
                <i class="fa fa-times" onclick="hideMenu()"></i>
                <ul>
                    <li><a href="ServletConnexionUtilisateur">Se connecter</a></li>  <!-- !!!!! mettre lien jsp quand elle sera créée -->
                    <li><a href="createLogin">S'inscrire</a></li>  <!-- !!!!! mettre lien jsp quand elle sera créée -->
                </ul>
            </div>
            <i class="fa fa-bars" onclick="showMenu()"></i>
        </nav>
        <div class="text-box">
            <h1>ENI enchères</h1>
            <p>Liste des enchères</p>
        </div>
    </header>
    
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
	
<!-- 	début du formulaire -->	
	
	<form action="ServletRechercher" method="post">
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
    </script>
        
</body>
</html>