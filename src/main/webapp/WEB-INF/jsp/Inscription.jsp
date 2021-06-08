<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
</head>

<body>
  
  <%--@elvariable id="page" type="string"--%>
  <c:if test="${page == 'login'}">
    
  </c:if>
  <c:if test="${page == 'createLogin'}">
    
  </c:if>
  <c:if test="${page == 'home'}">
    
  </c:if>
  <c:if test="${page == 'profile'}">
    
  </c:if>
  <c:if test="${page == 'updateProfile'}">
    
  </c:if>
  <c:if test="${page == 'postAuction'}">
    
  </c:if>
  <c:if test="${page == 'seeAuction'}">
    
  </c:if>
  <c:if test="${page == 'updateAuction'}">
    
  </c:if>
  
  <!-- En-tête -->
    <header>

        <!-- Titre -->
        <h1>ENI Enchères</h1>

        <!-- Sous-titre -->
        <h2>Mon profil</h2>

    </header>

    <!-- Création formulaire -->
    <form action="createLogin" method="post">

        <!-- Boxes à renseigner -->
        <div>
            <label for="pseudo">Pseudo :</label>
            <input id="pseudo" type="text" pattern="">
        </div>
        <div>
            <label for="nom">Nom :</label>
            <input id="nom" type="text" pattern="">
        </div>
        <div>
            <label for="prenom">Prénom :</label>
            <input id="prenom" type="text" pattern="">
        </div>
        <div>
            <label for="email">Email :</label>
            <input id="email" type="email" pattern="">
        </div>
        <div>
            <label for="telephone">Téléphone :</label>
            <input id="telephone" type="text" pattern="">
        </div>
        <div>
            <label for="rue">Rue :</label>
            <input id="rue" type="text" pattern="">
        </div>
        <div>
            <label for="codepostal">Code Postal :</label>
            <input id="codepostal" type="text" pattern="">
        </div>
        <div>
            <label for="ville">Ville :</label>
            <input id="ville" type="text" pattern="">
        </div>
        <div>
            <label for="mdp">Mot de passe :</label>
            <input id="mdp" type="text" pattern="">
        </div>
        <div>
            <label for="confmdp">Confirmation mot de passe :</label>
            <input id="confmdp" type="text" pattern="">
        </div>

        <!-- Valider pour créer le profil -->
        <div>
            <button type="submit">Créer</button>
        </div>
        
        <!-- Annuler la création de profil -->
        <div>
            <a href="ServletRechercher"><button type="button">Annuler</button></a>
        </div>
        
    </form>
    
</body>
</html>