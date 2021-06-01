<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="fr.eni.ENIencheres.bo.ArticleVendu" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accueil</title>
</head>
<body>
	<a href="">S'inscrire - Se connecter</a>
	<form action="/ServletRechercher" method="get">
		<div >
		    <label for="filtre">Filtres</label>
		    <br>
		    <input type="text" name="filtre" id="filtre" size="40" placeholder="Le nom de l'article contient...">
		    <br>
		    <label for="categories">Catégories</label>
		    <select name="categories" id="categories">
			    <option value="toutes" selected="selected">Toutes</option>
			    <option value="informatique">Informatique</option>
			    <option value="ameublement">Ameublement</option>
			    <option value="vetement">Vêtement</option>
			    <option value="sportloisir">Sport&Loisirs</option>
			</select>
			<br>
			<input type="submit" value="Rechercher">
			<br><br><br>
			

			<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
				<c:choose>
					<c:when test="${not empty listeEncheres && listeEncheres.size()>0}">
						<c:forEach var="articleVendu" items="${listeEncheres}">
							<ul>
								<li>${articleVendu.nomArticle}</li>
							
								<li>Prix : ${articleVendu.miseAPrix} points</li>
								<li>Fin de l'enchere : ${articleVendu.dateFinEncheres}</li>
								<li> Vendeur : ${articleVendu.noUtilisateur}</li>								
							</ul>
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