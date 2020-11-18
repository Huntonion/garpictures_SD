<%--
  Created by IntelliJ IDEA.
  User: Antonio
  Date: 10/29/2020
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="model.Tag" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
    <title>Garpictures</title>
    <link rel="stylesheet" href="./css/nav.css", type="text/css">
    <link rel="stylesheet" href="./css/style.css", type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <jsp:useBean id="beanUtente" class="model.Utente" scope="session" />
    <jsp:useBean id="carrello" class="model.Carrello" scope="session" />
</head>
<body>
<header>
    <div id="spazio_logo">
        <a href="IndexServlet"><img src="./sitimg/garpiclogo.png" width="50px" height="50px" alt="logo garpictures"></a>
    </div>
    <div id="spazio_ricerca">
        <form action="RicercaPerTag" method="post" id="inviaTags">
            <input type="text" placeholder="Cerca per tag..." id="tags" name="tag" class="searchTag">
            <button type="submit" class="searchTagButton">C</button>
        </form>
    </div>
    <nav id="spazio_menu">
        <ul class="menu">
            <c:if test="${beanUtente.visitatore == true}">
                <li class="item"><a href="registrazione.jsp">Registrati</a></li>
                <li class="item"><a href="login.jsp">Login</a></li>
            </c:if>
            <c:if test="${beanUtente.visitatore == false}">
                <li class="item"><a href="ChiamaModificaInformazioni">${beanUtente.nomeUtente}</a></li>
                <li class="item"><a href=LogoutController>Logout</a></li>
            </c:if>
            <c:if test="${beanUtente.amministratore==true}">
                <li class="item"><a href="ChiamaPannelloAdmin">pannello admin</a></li>
            </c:if>
        </ul>
    </nav>
    <div id="spazio_carrello">
        <a href="/"><img src="https://via.placeholder.com/50x50" alt="logo garpictures"></a>
    </div>
    <div id="spazio_hamburger">
        <button id="hamburger" onclick="apriMenu()" aria-label="menu"><img src="https://via.placeholder.com/30x30" alt="menu" width="30" height="30"></button>
    </div>
</header>

<nav id="menu_mobile">
    <ul class="menu">
        <c:if test="${beanUtente.visitatore == true}">
            <li class="item"><a href="registrazione.jsp">Registrati</a></li>
            <li class="item"><a href="login.jsp">Login</a></li>
        </c:if>
        <c:if test="${beanUtente.visitatore == false}">
            <li class="item"><a href="ChiamaModificaInformazioni">${beanUtente.nomeUtente}</a></li>
            <li class="item"><a href=LogoutController>Logout</a></li>

        </c:if>
        <c:if test="${beanUtente.amministratore==true}">
            <li class="item"><a href="ChiamaPannelloAdmin">pannello admin</a></li>
        </c:if>
    </ul>
</nav>

<script>
    var tags = [];
    var tags2 = [];
    $(document).on("click", "#tags", function() {
        $.post("AutocompleteAJAX", {  },
            function(responseJson){
                tags = JSON.parse(responseJson);
                $( "#tags" ).autocomplete({
                    source: tags
                });
            });
    });
    document.addEventListener("DOMContentLoaded", function() {
        $("#inviaTags").submit(function(e){
            tags.forEach(function (item, index) {
                tags2.push(item.substring(1));
            });
            var contenuto = $("#tags").val();
            if(!contenuto || jQuery.inArray(contenuto, tags2) == -1){
                if(jQuery.inArray(contenuto, tags) == -1){
                    e.preventDefault();
                }
            }
        })
    });
    $(function () {
        $(".toggle").on("click",function () {
            if($(".item").hasClass("active")){
                $(".item").removeClass("active");
            }else{
                $(".item").addClass("active");
            }
        })

    })
    function apriMenu() {
        if (document.getElementById("menu_mobile").classList.contains('aperto')) {
            document.getElementById("menu_mobile").classList.remove('aperto');
            document.getElementById('menu_mobile').style.height = '0';
        } else {
            document.getElementById("menu_mobile").classList.add('aperto');
            var numItems = $('.item').length;
            var numItems = numItems * 3;
            document.getElementById('menu_mobile').style.height = numItems+'%';
        }
    }
</script>

