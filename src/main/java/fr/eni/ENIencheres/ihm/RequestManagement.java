package fr.eni.ENIencheres.ihm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import fr.eni.ENIencheres.bll.ArticleVenduManager;
import fr.eni.ENIencheres.bll.BLLException;
import fr.eni.ENIencheres.bll.CategorieManager;
import fr.eni.ENIencheres.bll.EnchereManager;
import fr.eni.ENIencheres.bll.RetraitManager;
import fr.eni.ENIencheres.bll.UtilisateurManager;
import fr.eni.ENIencheres.bo.ArticleVendu;
import fr.eni.ENIencheres.dal.DALException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RequestManagement {
	public static void processHomePageAttributes(HttpServletRequest request) throws DALException, BLLException {
        request.setAttribute("current_auctions", new ArticleVenduManager().getAllArticlesVendus());
        request.setAttribute("categories", new CategorieManager().getAllCategories());
        request.setAttribute("pseudos", new UtilisateurManager().getPseudosUtilisateursWithCurrentAuctions());
    }
    public static void processInsertOrUpdateAuctionPageAttributes(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            CategorieManager cm = new CategorieManager();
            request.setAttribute("categories", cm.getAllCategories());
        } catch (DALException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    public static void processUpdateAuctionPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idAuctionToUpdate = Integer.valueOf(request.getParameter("id"));
        ArticleVenduManager avm = new ArticleVenduManager();
        List<String> errors = new ArrayList<>();
        try {
            ArticleVendu auctionToUpdate = avm.getArticleById(idAuctionToUpdate);
            request.setAttribute("auctionToUpdate", auctionToUpdate);
            RequestManagement.processInsertOrUpdateAuctionPageAttributes(request, response);
        } catch (DALException e) {
            ErrorsManagement.DALExceptionsCatcher(e, errors, request);
        } catch (BLLException e) {
            ErrorsManagement.BLLExceptionsCatcher(e, errors, request);
        }
    }

    public static void processSeeAuctionPage(HttpServletRequest request, int idAuction) throws DALException, BLLException {
        ArticleVenduManager avm = new ArticleVenduManager();
        CategorieManager cm = new CategorieManager();
        EnchereManager em = new EnchereManager();
        RetraitManager rm = new RetraitManager();
        UtilisateurManager um = new UtilisateurManager();
        ArticleVendu articleVendu = avm.getArticleById(idAuction);
        request.setAttribute("auction", articleVendu);
        request.setAttribute("category", cm.getCategorieById(articleVendu.getNoCategorie()));
        if (em.getAmountAndPseudoOfBestOffer(articleVendu) != null) {
            HashMap<Integer, Integer> bestOffer = em.getAmountAndPseudoOfBestOffer(articleVendu);
            request.setAttribute("user_best_offer", um.getUtilisateurById(bestOffer.get(articleVendu.getPrixVente())).getPseudo());
        }
        request.setAttribute("withdrawal", rm.getRetraitByNoArticle(articleVendu.getNoArticle()));
        request.setAttribute("seller", um.getUtilisateurById(articleVendu.getNoUtilisateur()));
    }

}
