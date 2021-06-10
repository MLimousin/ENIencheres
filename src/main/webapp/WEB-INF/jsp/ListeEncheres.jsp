<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@page import="fr.eni.ENIencheres.bo.ArticleVendu" %>
<%@page import="fr.eni.ENIencheres.bo.Utilisateur" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>

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
    <link type ="text/css" rel="stylesheet" href="css/accueil.css">
    <link rel="preconnect" href="https://fonts.gstatic.com"> 
    <link href="https://fonts.googleapis.com/css2?family=Hachi+Maru+Pop&family=Open+Sans&display=swap" rel="stylesheet">
</head>

<body>
    
    <!-- En-tête -->
    <header>
    	<nav>
            <a href=ServletRechercher><img src="img/logo ENI.jpg" alt="ENI école informatique"></a>
            <div class="nav-links" id="navLinks">
                <i class="fa fa-times" onclick="hideMenu()"></i>
                <ul>
                    <li><a href="ServletRechercher">Déconnexion</a></li>  <!-- !!!!! mettre lien jsp quand elle sera créée -->
                    <li><a href="http://google.com">Mon profil</a></li>  <!-- !!!!! mettre lien jsp quand elle sera créée -->
                    <li><a href="ServletNouvelleVente">Vendre un article</a></li> 
                    <li><a href="http://google.com">Enchères</a></li>  <!-- !!!!! mettre lien jsp quand elle sera créée -->
                </ul>
            </div>
            <i class="fa fa-bars" onclick="showMenu()"></i>
        </nav>
        <div class="text-box">
            <h1>ENI enchères</h1>
            <p>Liste des enchères</p>
        </div>        
    </header>
   	
   	<!-- 	création de la variable "utilisateur" pour filtrer l'affichage des articles en fonction de la personne connectée -->
    <jsp:useBean id="pseudo" class="java.lang.String" scope="session"/>
    <jsp:useBean id="utilisateurConnecte" class="fr.eni.ENIencheres.bo.Utilisateur" scope="session"/>
	<c:choose>
		<c:when test="${not empty identifiant}">
			<c:set var="pseduo" value="${identifiant}" scope="session" />
			<c:forEach var="u" items="listeUtilisateurs">
				<c:if test="${u.pseudo == pseudo}">
					<c:set var="utilisateurConnecte" value="${u}" scope="session" />
				</c:if>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:set var="pseudo" value="" scope="session" />
		</c:otherwise>
	</c:choose>	
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
	
	<!-- 	création de la variable "radio" pour filtrer l'affichage des articles en fonction du radio bouton achat/vente -->
	<jsp:useBean id="radio" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty achatsEtVentes}">
			<c:set var="radio" value="${achatsEtVentes}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="radio" value="Achats" scope="session" />
		</c:otherwise>
	</c:choose>	
	
	<!-- 	création de la variable "ckAchats" pour filtrer l'affichage des articles en fonction du checkbox achats -->
	<jsp:useBean id="ckAchats" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty achats}">
			<c:set var="ckAchats" value="${achats}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${empty ventes}"><c:set var="ckAchats" value="EncheresOuvertes" scope="session" /></c:when>
				<c:otherwise><c:set var="ckAchats" value="" scope="session" /></c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>	
	
	<!-- 	création de la variable "ckVentes" pour filtrer l'affichage des articles en fonction du checkbox ventes -->
	<jsp:useBean id="ckVentes" class="java.lang.String" scope="session"/>
	<c:choose>
		<c:when test="${not empty ventes}">
			<c:set var="ckVentes" value="${ventes}" scope="session" />
		</c:when>
		<c:otherwise>
			<c:set var="ckVentes" value="" scope="session" />
		</c:otherwise>
	</c:choose>	
	
<!-- 	début du formulaire -->	
	
	<form action="ServletRechercherModeConnecte" method="post">
		<input type="hidden" name="pseudo" value="${utilisateurConnecte.pseudo}">
		<input type="hidden" name="numeroUtilisateur" value="${utilisateurConnecte.noUtilisateur}">
	
		<div >
		<section class="auction">
		    <h1><label for="filtre">Filtres : </label></h1>

		    <section class="choice">
			    <label for="categorieChoisie">Catégories : </label>
			    <select name="categorieChoisie" id="categorieChoisie">
			   		<c:forEach var="categorieDispo" items="${categories}">
						<option value=${categorieDispo.libelleCategorie} ${categorieDispo.libelleCategorie==categorie?"selected":""}>${categorieDispo.libelleCategorie}</option>
						<%int numeroCategorie;%>
						<c:if test="${categorieDispo.libelleCategorie==categorie}">
							${numeroCategorie=categorieDispo.noCategorie}
						</c:if>
					</c:forEach>
				</select>
				<br>
				<input class="search-text" type="search" name="filtre" id="filtre" size="40" placeholder="Le nom de l'article contient...">
		    	<input class="search-btn" type="submit" value="Rechercher">
				<table>
				<!-- Choix unique "radio button" -->
				<tr>
		            <td>
		            	<label class="containerRadio" for="Achats">Achats
		            		<input type="radio" name="achatsEtVentes" id="Achats" onchange="masquerSelectionVentes(this)" Value="Achats" ${radio=='Achats'?"checked":""} />
		            		<span class="checkmarkRadio"></span>
		            	</label>
		            </td>
		            <td>
		            	<label class="containerRadio" for="Ventes">Ventes
		            		<input type="radio" name="achatsEtVentes" id="Ventes" onchange="masquerSelectionAchats(this)" Value="Ventes" ${radio=='Ventes'?"checked":""}/>
	            			<span class="checkmarkRadio"></span>
	            		</label>
	            	</td>
        		</tr>
        		<!-- Choix unique "checkbox" -->
        		<tr>      		
		            <td class="checkbox">
		            	<label class="container">Enchères ouvertes
				            <input type="checkbox" name="achats" id="EncheresOuvertes" Value="EncheresOuvertes" ${ckAchats=='EncheresOuvertes'?"checked":""} ${radio=='Ventes'?"disabled":""}/>
				            <span class="checkmark"></span>
				        </label>
				        <label class="container">Mes enchères en cours
				        	<input type="checkbox" name="achats" id="MesEncheresEnCours" Value="MesEncheresEnCours" ${ckAchats=='MesEncheresEnCours'?"checked":""} ${radio=='Ventes'?"disabled":""}/>
				            <span class="checkmark"></span>
				        </label>
				        <label class="container">Mes enchères remportées
				            <input type="checkbox" name="achats" id="MesEncheresRemportees" Value="MesEncheresRemportees" ${ckAchats=='MesEncheresRemportees'?"checked":""} ${radio=='Ventes'?"disabled":""}/>
				            <span class="checkmark"></span>
				        </label>
		            </td>
		            <td class="checkbox">
						<label class="container">Mes ventes en cours
				            <input type="checkbox" name="ventes" id="MesVentesEnCours" Value="MesVentesEnCours" ${ckVentes=='MesVentesEnCours'?"checked":""} ${radio=='Achats'?"disabled":""}/>
				            <span class="checkmark"></span>
				        </label>
				        <label class="container">Ventes non débutées
				            <input type="checkbox" name="ventes" id="VentesNonDebutees" Value="VentesNonDebutees" ${ckVentes=='VentesNonDebutees'?"checked":""} ${radio=='Achats'?"disabled":""}/>
				            <span class="checkmark"></span>
				        </label>
				        <label  class="container">Ventes terminées
				            <input type="checkbox" name="ventes" id="VentesTerminees" Value="VentesTerminees" ${ckVentes=='VentesTerminees'?"checked":""} ${radio=='Achats'?"disabled":""}/>
				            <span class="checkmark"></span>
				        </label>
				   	</td>
        		</tr>
			</table>
			</section>
        
		</section>
		
		<section class="liveAuction">
			<h1>
				${ckAchats=='EncheresOuvertes'?"Enchères ouvertes :":""} 
				${ckAchats=='MesEncheresEnCours'?"Mes enchères en cours :":""}
				${ckAchats=='MesEncheresRemportees'?"Mes enchères remportées :":""} 
				${ckVentes=='MesVentesEnCours'?"Mes ventes en cours :":""} 
				${ckVentes=='VentesNonDebutees'?"Ventes non débutées :":""}  
				${ckVentes=='VentesTerminees'?"Ventes terminées :":""} 
			</h1>	
		
			<c:choose>
				<c:when test="${not empty listeEncheres && listeEncheres.size()>0}">
				<div class="row">	
					<c:forEach var="articleVendu" items="${listeEncheres}">
						<c:choose>
							
							<c:when test="${ckAchats=='EncheresOuvertes'}">
								<c:if test="${articleVendu.dateDebutEncheres<=dateDuJour && articleVendu.dateFinEncheres>dateDuJour}">
									<c:choose>
										<c:when test="${saisie==''}">
											<c:choose>
												<c:when test="${categorie=='Toutes'}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p> Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>	
															</p>	
														</td>
													</tr>
												</table>
												</div>									
												</c:when >
												<c:when test="${articleVendu.noCategorie==numeroCategorie}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p>Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>
															</p>
														</td>
													</tr>
												</table>	
												</div>							
												</c:when>	
											</c:choose>
										</c:when>	
										<c:when test="${saisie!=''}">
											<c:if test="${fn:containsIgnoreCase(articleVendu.nomArticle, saisie)}">
												<c:choose>
													<c:when test="${categorie=='Toutes'}">
													<div class="liveAuction-col">
													<table>
														<tr>
															<td>
																<img src="${articleVendu.photo}"/>
															</td>
															<td>
																<h5>${articleVendu.nomArticle}</h5>
																<p>Prix : ${articleVendu.miseAPrix} points</p>
																<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																<p> Vendeur : 
																	<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																		<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																			${utilisateur.pseudo}
																		</c:if>
																	</c:forEach>
																</p>	
															</td>
														</tr>
													</table>
													</div>
													</c:when >
													<c:when test="${articleVendu.noCategorie==numeroCategorie}">
													<div class="liveAuction-col">
														<table>
															<tr>
																<td>
																	<img src="${articleVendu.photo}"/>
																</td>
																<td>
																	<h5>${articleVendu.nomArticle}</h5>
																	<p>Prix : ${articleVendu.miseAPrix} points</p>
																	<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																	<p> Vendeur : 
																		<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																			<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																				${utilisateur.pseudo}
																			</c:if>
																		</c:forEach>
																	</p>
																</td>
															</tr>
														</table>
													</div>								
													</c:when>	
												</c:choose>
											</c:if>
										</c:when>
									</c:choose>
								</c:if>	
							</c:when>


							<c:when test="${ckAchats=='MesEncheresEnCours'}">
							</c:when>


							<c:when test="${ckAchats=='MesEncheresRemportees'}">
							</c:when>


							<c:when test="${ckVentes=='MesVentesEnCours'}">
								<c:if test="${articleVendu.dateDebutEncheres<dateDuJour && articleVendu.dateFinEncheres>dateDuJour && articleVendu.noUtilisateur==utilisateurConnecte.noUtilisateur}">
									<c:choose>
										<c:when test="${saisie==''}">
											<c:choose>
												<c:when test="${categorie=='Toutes'}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p> Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>	
															</p>
														</td>
													</tr>
												</table>	
												</div>									
												</c:when >
												<c:when test="${articleVendu.noCategorie==numeroCategorie}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p>Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>
															</p>
														</td>
													</tr>
												</table>	
												</div>							
												</c:when>	
											</c:choose>
										</c:when>	
										<c:when test="${saisie!=''}">
											<c:if test="${fn:containsIgnoreCase(articleVendu.nomArticle, saisie)}">
												<c:choose>
													<c:when test="${categorie=='Toutes'}">
													<div class="liveAuction-col">
													<table>
														<tr>
															<td>
																<img src="${articleVendu.photo}"/>
															</td>
															<td>
																<h5>${articleVendu.nomArticle}</h5>
																<p>Prix : ${articleVendu.miseAPrix} points</p>
																<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																<p> Vendeur : 
																	<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																		<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																			${utilisateur.pseudo}
																		</c:if>
																	</c:forEach>
																</p>	
															</td>
														</tr>
													</table>
													</div>
													</c:when >
													<c:when test="${articleVendu.noCategorie==numeroCategorie}">
													<div class="liveAuction-col">
														<table>
															<tr>
																<td>
																	<img src="${articleVendu.photo}"/>
																</td>
																<td>
																	<h5>${articleVendu.nomArticle}</h5>
																	<p>Prix : ${articleVendu.miseAPrix} points</p>
																	<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																	<p> Vendeur : 
																		<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																			<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																				${utilisateur.pseudo}
																			</c:if>
																		</c:forEach>
																	</p>
																</td>
															</tr>
														</table>
													</div>								
													</c:when>	
												</c:choose>
											</c:if>
										</c:when>
									</c:choose>
								</c:if>
							</c:when>


							<c:when test="${ckVentes=='VentesNonDebutees'}">
								<c:if test="${articleVendu.dateDebutEncheres>dateDuJour}">
									<c:choose>
										<c:when test="${saisie==''}">
											<c:choose>
												<c:when test="${categorie=='Toutes'}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p> Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>	
															</p>
														</td>
													</tr>
												</table>	
												</div>									
												</c:when >
												<c:when test="${articleVendu.noCategorie==numeroCategorie}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p>Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>
															</p>
														</td>
													</tr>
												</table>	
												</div>							
												</c:when>	
											</c:choose>
										</c:when>	
										<c:when test="${saisie!=''}">
											<c:if test="${fn:containsIgnoreCase(articleVendu.nomArticle, saisie)}">
												<c:choose>
													<c:when test="${categorie=='Toutes'}">
													<div class="liveAuction-col">
													<table>
														<tr>
															<td>
																<img src="${articleVendu.photo}"/>
															</td>
															<td>
																<h5>${articleVendu.nomArticle}</h5>
																<p>Prix : ${articleVendu.miseAPrix} points</p>
																<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																<p> Vendeur : 
																	<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																		<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																			${utilisateur.pseudo}
																		</c:if>
																	</c:forEach>
																</p>	
															</td>
														</tr>
													</table>
													</div>
													</c:when >
													<c:when test="${articleVendu.noCategorie==numeroCategorie}">
													<div class="liveAuction-col">
														<table>
															<tr>
																<td>
																	<img src="${articleVendu.photo}"/>
																</td>
																<td>
																	<h5>${articleVendu.nomArticle}</h5>
																	<p>Prix : ${articleVendu.miseAPrix} points</p>
																	<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																	<p> Vendeur : 
																		<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																			<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																				${utilisateur.pseudo}
																			</c:if>
																		</c:forEach>
																	</p>
																</td>
															</tr>
														</table>
													</div>								
													</c:when>	
												</c:choose>
											</c:if>
										</c:when>
									</c:choose>
								</c:if>	
							</c:when>
							

							<c:when test="${ckVentes=='VentesTerminees'}">
								<c:if test="${articleVendu.dateFinEncheres<dateDuJour}">
									<c:choose>
										<c:when test="${saisie==''}">
											<c:choose>
												<c:when test="${categorie=='Toutes'}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p> Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>	
															</p>
														</td>
													</tr>
												</table>	
												</div>									
												</c:when >
												<c:when test="${articleVendu.noCategorie==numeroCategorie}">
												<div class="liveAuction-col">
												<table>
													<tr>
														<td>
															<img src="${articleVendu.photo}"/>
														</td>
														<td>
															<h5>${articleVendu.nomArticle}</h5>
															<p>Prix : ${articleVendu.miseAPrix} points</p>
															<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
															<p>Vendeur : 
																<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																	<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																		${utilisateur.pseudo}
																	</c:if>
																</c:forEach>
															</p>
														</td>
													</tr>
												</table>	
												</div>							
												</c:when>	
											</c:choose>
										</c:when>	
										<c:when test="${saisie!=''}">
											<c:if test="${fn:containsIgnoreCase(articleVendu.nomArticle, saisie)}">
												<c:choose>
													<c:when test="${categorie=='Toutes'}">
													<div class="liveAuction-col">
													<table>
														<tr>
															<td>
																<img src="${articleVendu.photo}"/>
															</td>
															<td>
																<h5>${articleVendu.nomArticle}</h5>
																<p>Prix : ${articleVendu.miseAPrix} points</p>
																<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																<p> Vendeur : 
																	<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																		<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																			${utilisateur.pseudo}
																		</c:if>
																	</c:forEach>
																</p>	
															</td>
														</tr>
													</table>
													</div>
													</c:when >
													<c:when test="${articleVendu.noCategorie==numeroCategorie}">
													<div class="liveAuction-col">
														<table>
															<tr>
																<td>
																	<img src="${articleVendu.photo}"/>
																</td>
																<td>
																	<h5>${articleVendu.nomArticle}</h5>
																	<p>Prix : ${articleVendu.miseAPrix} points</p>
																	<p>Fin de l'enchere : ${articleVendu.dateFinEncheres}</p>
																	<p> Vendeur : 
																		<c:forEach var="utilisateur" items="${listeUtilisateurs}">
																			<c:if test="${articleVendu.noUtilisateur == utilisateur.noUtilisateur}">
																				${utilisateur.pseudo}
																			</c:if>
																		</c:forEach>
																	</p>
																</td>
															</tr>
														</table>
													</div>								
													</c:when>	
												</c:choose>
											</c:if>
										</c:when>
									</c:choose>
								</c:if>	
							</c:when>
							
						</c:choose>		
					</c:forEach>
				</div>
				</c:when>
				<c:otherwise>
					<p>Il n'y a aucun article en vente actuellement</p>
				</c:otherwise>
			</c:choose>		
		</section>		
		</div>
	</form>
	
	<!-- JAVASCRIPT pour menu/x version smartphone -->
    <script>
        var navLinks = document.getElementById("navLinks");
        function showMenu() {
            navLinks.style.right = "0";
        }
        function hideMenu() {
            navLinks.style.right = "-200px";
        }
 
    <!-- JavaScript pour rendre sélectionnable/non sélectionnable les checkbox en fonction du radio button -->
 
		function masquerSelectionVentes(BtnRadio)
		{
			 if(BtnRadio.checked==true)
			 {
				 document.getElementById("EncheresOuvertes").removeAttribute("disabled");
				 document.getElementById("MesEncheresEnCours").removeAttribute("disabled");
				 document.getElementById("MesEncheresRemportees").removeAttribute("disabled");
				 document.getElementById("MesVentesEnCours").checked=false;
				 document.getElementById("VentesNonDebutees").checked=false;
				 document.getElementById("VentesTerminees").checked=false;
				 document.getElementById("MesVentesEnCours").disabled = true;
				 document.getElementById("VentesNonDebutees").disabled = true;
				 document.getElementById("VentesTerminees").disabled = true;
				 
				 
			 }else{
				 document.getElementById("EncheresOuvertes").checked=false;
				 document.getElementById("MesEncheresEnCours").checked=false;
				 document.getElementById("MesEncheresRemportees").checked=false;
				 document.getElementById("EncheresOuvertes").disabled = true;
				 document.getElementById("MesEncheresEnCours").disabled = true;
				 document.getElementById("MesEncheresRemportees").disabled = true; 
				 document.getElementById("MesVentesEnCours").removeAttribute("disabled");
				 document.getElementById("VentesNonDebutees").removeAttribute("disabled");
				 document.getElementById("VentesTerminees").removeAttribute("disabled");
			 }
			 
		}
		function masquerSelectionAchats(BtnRadio)
		{	
			 if(BtnRadio.checked==true)
			 {
				 document.getElementById("MesVentesEnCours").removeAttribute("disabled");
				 document.getElementById("VentesNonDebutees").removeAttribute("disabled");
				 document.getElementById("VentesTerminees").removeAttribute("disabled");
				 document.getElementById("EncheresOuvertes").checked=false;
				 document.getElementById("MesEncheresEnCours").checked=false;
				 document.getElementById("MesEncheresRemportees").checked=false;
				 document.getElementById("EncheresOuvertes").disabled = true;
				 document.getElementById("MesEncheresEnCours").disabled = true;
				 document.getElementById("MesEncheresRemportees").disabled = true;
			 }else{
				 document.getElementById("MesVentesEnCours").checked=false;
				 document.getElementById("VentesNonDebutees").checked=false;
				 document.getElementById("VentesTerminees").checked=false;
				 document.getElementById("MesVentesEnCours").disabled = true;
				 document.getElementById("VentesNonDebutees").disabled = true;
				 document.getElementById("VentesTerminees").disabled = true; 
				 document.getElementById("EncheresOuvertes").removeAttribute("disabled");
				 document.getElementById("MesEncheresEnCours").removeAttribute("disabled");
				 document.getElementById("MesEncheresRemportees").removeAttribute("disabled");
			 }	 
		}
		
	</script>    
	 
	<!-- JAVASCRIPT pour menu/x version smartphone -->
    <script>
        var navLinks = document.getElementById("navLinks");
        function showMenu() {
            navLinks.style.right = "0";
        }
        function hideMenu() {
            navLinks.style.right = "-200px";
        }
    </script>


</body>
</html>