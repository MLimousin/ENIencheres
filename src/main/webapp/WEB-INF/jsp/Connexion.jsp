<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <link rel="stylesheet" href="css/connexion.css">
    <link rel="preconnect" href="https://fonts.gstatic.com"> 
    <link href="https://fonts.googleapis.com/css2?family=Hachi+Maru+Pop&family=Open+Sans&display=swap" rel="stylesheet">
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

	<div class="loginbox">
        <img class="avatar" src="img/connexion.png">
        <h1>Login</h1>
    <!-- Création formulaire -->
        <!-- Boxes de connexion -->
        <form action="ServletRechercherModeConnecte" method="get">
            <div>
                <label for="identifiant"><p>Identifiant :</p></label>
                <input id="identifiant" type="text" name="identifiant" placeholder="Pseudo">
            </div>
            <div>
                <label for="password"><p>Mot de passe : </p></label>
                <input id="password" type="text" name="password" placeholder="Mot de passe">
            </div>

        <!-- Case à cocher pour mémoriser les identifiants -->
        <div>
            <input type="checkbox">Se souvenir de moi</input>
        </div>

        <!-- Etablir la connexion -->
        <div>
            <a href="ServletRechercherModeConnecte"><button type="submit">Connexion</button></a>
        </div>
        
        <!-- MDP oublié -->
        <a href="">
            Mot de passe oublié
        </a>

        <!-- Renvoi vers la page d'inscription -->
        <div>
            <a href="createLogin"><button type="button">Créer un compte</button></a>
            <a href="ServletRechercher"><button type="button">Annuler</button></a>
        </div>
    </form>


</body>
</html>