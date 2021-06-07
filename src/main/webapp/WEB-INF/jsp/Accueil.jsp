<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="fr.eni.ENIencheres.bo.ArticleVendu" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accueil</title>
</head>
<body>
	<a href="">S'inscrire - Se connecter</a>
	
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
	<c:out  value="ma recherche : ${saisie}"/>
	
<!-- 	début du formulaire -->	
	<form action="ServletRechercher" method="post">
		<div >
		    <label for="filtre">Filtres</label>
		    <br>
		    <input type="text" name="filtre" id="filtre" size="40" placeholder="Le nom de l'article contient...">
		    <br>
		    <label for="categorieChoisie">Catégories</label>
		    <select name="categorieChoisie" id="categorieChoisie">
		   		<c:forEach var="categorieDispo" items="${categories}">
					<option value=${categorieDispo.libelleCategorie} ${categorieDispo.libelleCategorie==categorie?"selected":""}>${categorieDispo.libelleCategorie}</option>
					<%int numeroCategorie;%>
					<c:if test="${categorieDispo.libelleCategorie==categorie}">
						${numeroCategorie=categorieDispo.noCategorie}
					</c:if>
				</c:forEach>
			</select>
			<c:out value="${numeroCategorie}"></c:out>
			<br>
			<input type="submit" value="Rechercher">
			<br><br><br>
			<c:choose>
				<c:when test="${not empty listeEncheres && listeEncheres.size()>0}">
					<c:forEach var="articleVendu" items="${listeEncheres}">
						<c:if test="${articleVendu.dateDebutEncheres<dateDuJour && articleVendu.dateFinEncheres>dateDuJour}">
							<c:choose>
								<c:when test="${saisie==''}">
									<c:choose>
										<c:when test="${categorie=='Toutes'}">
											<ul>
												<li>${articleVendu.nomArticle}</li>
												<li>Prix : ${articleVendu.miseAPrix} points</li>
												<li>Fin de l'enchere : ${articleVendu.dateFinEncheres}</li>
												<li> Vendeur : ${articleVendu.noUtilisateur}</li>	
											</ul>								
										</c:when >
										<c:when test="${articleVendu.noCategorie==numeroCategorie}">
											<ul>
												<li>${articleVendu.nomArticle}</li>
												<li>Prix : ${articleVendu.miseAPrix} points</li>
												<li>Fin de l'enchere : ${articleVendu.dateFinEncheres}</li>
												<li> Vendeur : ${articleVendu.noUtilisateur}</li>								
											</ul>
										</c:when>	
									</c:choose>
								</c:when>	
								<c:when test="${saisie!=''}">
									<c:if test="${fn:containsIgnoreCase(articleVendu.nomArticle, saisie)}">
										<c:choose>
											<c:when test="${categorie=='Toutes'}">
												<ul>
													<li>${articleVendu.nomArticle}</li>
													<li>Prix : ${articleVendu.miseAPrix} points</li>
													<li>Fin de l'enchere : ${articleVendu.dateFinEncheres}</li>
													<li> Vendeur : ${articleVendu.noUtilisateur}</li>	
												</ul>								
											</c:when >
											<c:when test="${articleVendu.noCategorie==numeroCategorie}">
												<ul>
													<li>${articleVendu.nomArticle}</li>
													<li>Prix : ${articleVendu.miseAPrix} points</li>
													<li>Fin de l'enchere : ${articleVendu.dateFinEncheres}</li>
													<li> Vendeur : ${articleVendu.noUtilisateur}</li>								
												</ul>
											</c:when>	
										</c:choose>
									</c:if>
								</c:when>
							</c:choose>
						</c:if>				
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>Il n'y a aucun article en vente actuellement</p>
				</c:otherwise>
			</c:choose>				
		</div>
	</form>
	
</body>
</html>