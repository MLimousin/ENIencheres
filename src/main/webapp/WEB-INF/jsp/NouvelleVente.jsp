<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="fr.eni.ENIencheres.message.LecteurMessage"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nouvelle vente</title>
</head>
<body>
<!-- 	création de la variable "categorie" pour filtrer l'affichage des articles en fonction de la sélection -->
	<jsp:useBean id="cat" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty categorie}">
			<c:set var="cat" value="${categorie}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="cat" value="Toutes" scope="session" />
		</c:otherwise>
	</c:choose>
<!-- 	affichage des messages d'erreur en cas de mauvaise saisie -->	
<c:if test="${not empty listeCodeErreur}">
	<p>L'article n'a pas pu être ajouté</p>
	<c:forEach var="code" items="${listeCodeErreur}">
		<p>${LecteurMessage.getMessageErreur(code)}</p>
	</c:forEach>
</c:if>


<!-- 	début du formulaire -->
<form action="ServletNouvelleVente" method="post">
	<label for="article">Article : </label>
	<input type="text" name="article" id="article" required value=${param.article} >
	<br>
	<label for="description">Description</label>
	<textarea name="description" id="description" rows="3" cols="20" required>${param.description}</textarea>
	<br>
	<label for="categorie">Filtres</label>
	<select name="categorie" id="categorie" required>
   		<c:forEach var="categorieDispo" items="${categories}">
			<option value=${categorieDispo.libelleCategorie} ${categorieDispo.libelleCategorie==cat?"selected":""}>${categorieDispo.libelleCategorie}</option>				
		</c:forEach>
	</select>
	<br>
	<label for="photo">Photo de l'article : </label>
	<input type="file" id="photo" name="photo" accept="image/*">
	<br>
	<label for="prix">Mise à prix : </label>
	<input type="number" name="prix" step="10" required value=${param.prix}>
	<br>
	<label for="debut">Début de l'enchère : </label>
	<input type="date" name="debut" id="debut" placeholder="aaaa-mm-jj" required value=${param.debut}>
	<br>
	<label for="fin">Fin de l'enchère : </label>
	<input type="date" name="fin" id="fin" placeholder="aaaa-mm-jj" required value=${param.fin}>
	<br>
	<fieldset>
		<legend>Retrait</legend>
		
		<label for="rue">Rue : </label>
		<input type="text" name="rue" id="rue" value=${param.rue}>
		<br>
		<label for="cp">Code postal : </label>
		<input type="text" name="cp" id="cp" value=${param.cp}>
		<br>
		<label for="ville">Ville : </label>
		<input type="text" name="ville" id="ville" value=${param.ville}>
	</fieldset>
	<br>
	<input type="submit" name="enregistrer" id="enregistrer" value="Enregistrer">
	<input type="button" name="annuler" id="annuler" value="Annuler">
</form>

</body>
</html>