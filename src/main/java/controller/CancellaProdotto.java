package controller;

import model.Prodotto;
import model.ProdottoDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/CancellaProdotto")
public class CancellaProdotto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProdotto = Integer.parseInt(request.getParameter("prodotto"));
        ProdottoDAO filter = new ProdottoDAO();
        filter.doDeleteByID(idProdotto);
        String address;
        String referrer = request.getHeader("referer");
        System.out.println(referrer);
        address="WEB-INF/result/listaProdotti.jsp";
        ArrayList<Prodotto> prodotti = filter.doRetriveAll();
        request.setAttribute("prodotti",prodotti);
        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request,response);
    }
}
