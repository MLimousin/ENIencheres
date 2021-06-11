<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="fr.eni.ENIencheres.message.LecteurMessage"%>

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
    <link type ="text/css" rel="stylesheet" href="css/nouvelleVente.css">
    <link rel="preconnect" href="https://fonts.gstatic.com"> 
    <link href="https://fonts.googleapis.com/css2?family=Hachi+Maru+Pop&family=Open+Sans&display=swap" rel="stylesheet">
</head>

<body>
	<header>
    	<nav>
            <a href=ServletRechercher><img src="img/logo ENI.jpg" alt="ENI école informatique"></a>
        </nav>
        <div class="text-box">
            <h1>ENI enchères</h1>
            <p>Nouvelle vente</p>
        </div>        
    </header>
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
<form action="ServletNouvelleVente" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td><label for="article">Article : </label></td>
			<td><input type="text" name="article" id="article" required value=${param.article} ></td>
		</tr>
		<tr>
			<td><label for="description">Description : </label></td>
			<td><textarea name="description" id="description" required>${param.description}</textarea></td>
		</tr>
		<tr>
			<td><label for="categorie">Filtres : </label></td>
			<td>
				<select name="categorie" id="categorie" required>
			   		<c:forEach var="categorieDispo" items="${categories}">
						<option value=${categorieDispo.libelleCategorie} ${categorieDispo.libelleCategorie==cat?"selected":""}>${categorieDispo.libelleCategorie}</option>				
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td><label for="photo">Photo de l'article : </label></td>
			<td><input type="file" id="photo" name="photo" accept="image/*" required value=${nomPhoto}></td>
		</tr>
		<tr>
			<td><label for="prix">Mise à prix : </label></td>
			<td><input class="number" type="number" name="prix" step="10" required value=${param.prix}></td>
		</tr>
		<tr>
			<td><label for="debut">Début de l'enchère : </label></td>
			<td><input type="date" name="debut" id="debut" placeholder="aaaa-mm-jj" required value=${param.debut}></td>
		</tr>
		<tr>
			<td><label for="fin">Fin de l'enchère : </label></td>
			<td><input type="date" name="fin" id="fin" placeholder="aaaa-mm-jj" required value=${param.fin}></td>
		</tr>
	</table>
	<fieldset>
		<legend>Retrait</legend>
		<table>
			<tr>
				<td><label for="rue">Rue : </label></td>
				<td><input type="text" name="rue" id="rue" value=${param.rue}></td>
			</tr>
			<tr>
				<td><label for="cp">Code postal : </label></td>
				<td><input type="text" name="cp" id="cp" value=${param.cp}></td>
			</tr>
			<tr>
				<td><label for="ville">Ville : </label></td>
				<td><input type="text" name="ville" id="ville" value=${param.ville}></td>
			</tr>
		</table>
	</fieldset>
	<div class="bouton">
		<input class="btn" type="submit" name="enregistrer" id="enregistrer" value="Enregistrer">
		<input class="btn" type="button" name="annuler" id="annuler" value="Annuler">
	</div>
	
</form>

</body>
</html>