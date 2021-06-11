<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/inscription.css">
    <link rel="preconnect" href="https://fonts.gstatic.com"> 
    <link href="https://fonts.googleapis.com/css2?family=Hachi+Maru+Pop&family=Open+Sans&display=swap" rel="stylesheet">
    <title>Inscription</title>
</head>

<body>
    <header>
        	<nav>
        	<a href="ServletRechercher"><img src="img/logo ENI.jpg" alt="ENI école informatique"></a>
        	</nav>
        	<div class="text-box">
        		<h1>ENI enchères</h1>
        		<p>Page de connexion</p>
        	</div>
    	</header>
    
    <div class="identity-box"> 
        	<img class="avatar" src="img/avatarpng.png">
        	<h1>Mon Profil</h1>

    <!-- Création formulaire -->
    <form action="createLogin" method="post">

       <table>
        			<tr>
        				<td><label for="pseudo">Pseudo :</label></td>
        				<td><input id="pseudo" name="pseudo" type="text" required></td>
        			</tr>
        			<tr>
        				<td><label for="nom">Nom :</label></td>
        				<td><input id="nom" name="nom" type="text" required></td>
        			</tr>
        			<tr>
        				<td><label for="prenom">Prénom :</label></td>
        				<td><input id="prenom" name="prenom"type="text" required></td>
        			</tr>
        			<tr>
        				<td><label for="email">Email :</label></td>
        				<td><input id="email" type="text" name="email" required></td>
        			</tr>
        			<tr>
        				<td><label for="telephone">Téléphone :</label></td>
        				<td><input id="telephone" type="text" name="telephone" required></td>
        			</tr>
        			<tr>
        				<td><label for="rue">Rue :</label></td>
        				<td><input id="rue" type="text" name="rue"required></td>
        			</tr>
        			<tr>
        				<td><label for="code_postal">Code Postal :</label></td>
        				<td><input id="code_postal" type="text" name="code_postal" required></td>
        			</tr>
        			<tr>
        				<td><label for="ville">Ville :</label></td>
        				<td><input id="ville" type="text" name="ville" required></td>
        			</tr>
        			<tr>
        				<td><label for="password">Password :</label></td>
        				<td><input id="password" type="password" name="password" required></td>
        			</tr>
        		
        		
        		
        		</table>
        		<div>
						<input type="submit" class="btn-validate" name="valider" value="valider"> 
						<a href="ServletRechercher"><button type="button">Annuler</button></a>
				</div>
      
    </form>
    </div>
</body>
</html>