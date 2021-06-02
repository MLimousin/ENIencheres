<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="fr.eni.ENIencheres.bo.ArticleVendu" %>
<%@page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accueil</title>
</head>
<body>
	<a href="">S'inscrire - Se connecter</a>
	
	<c:choose>
		<c:when test="${not empty categorieChoisie}">
			<c:set var="categorie" value="${categorieChoisie}" />
		</c:when>
		<c:otherwise>
			<c:set var="categorie" value="Toutes"  />
		</c:otherwise>
	</c:choose>	
	
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
				</c:forEach>
			</select>
			<br>
			<input type="submit" value="Rechercher">
			<br><br><br>
					
			<c:choose>
				<c:when test="${not empty listeEncheres && listeEncheres.size()>0}">
						<c:forEach var="articleVendu" items="${listeEncheres}">
							<c:if test="${categorie==Toutes}">
								<ul>
									<li>${articleVendu.nomArticle}</li>
								
									<li>Prix : ${articleVendu.miseAPrix} points</li>
									<li>Fin de l'enchere : ${articleVendu.dateFinEncheres}</li>
									<li> Vendeur : ${articleVendu.noUtilisateur}</li>								
								</ul>
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