<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
</head>
<body>
    
    <!-- En-tête -->
    <header>

        <!-- Titre -->
        <h1>ENI Enchères</h1>

        <!-- Sous-titre -->
        <h2>Se connecter</h1>

    </header>

    <!-- Création formulaire -->
    <form>

        <!-- Boxes de connexion -->
        <form>
            <div>
                <label for="identifiant">Identifiant :</label>
                <input id="identifiant" type="text" name="identifiant">
            </div>
            <div>
                <label for="password">Mot de passe :</label>
                <input id="password" type="text" name="password">
            </div>
        </form>

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
        </div>
    </form>


</body>
</html>