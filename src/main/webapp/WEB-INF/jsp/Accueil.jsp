<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		</div>
	</form>
	
</body>
</html>