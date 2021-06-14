<%@page import="br.com.luiza.db.User"%>
<%@page import="br.com.luiza.db.Disciplinas"%>
<%@page import="java.util.ArrayList"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        if(request.getParameter("session.login") != null){
            String login = request.getParameter("user.login");
            String password = request.getParameter("user.password");
            User user = User.getUser(login, password);
            session.setAttribute("user.login", user.getLogin());
            session.setAttribute("user.name", user.getName());
            session.setAttribute("user.role", user.getRole());
            response.sendRedirect(request.getRequestURI());
        }    
    %>
    <%
        String erro = null;
        ArrayList<Disciplinas> list = new ArrayList<>();
        try{
            if(request.getParameter("nota")!= null){
                String name = request.getParameter("name");
                String p1 = request.getParameter("p1");
                String p2 = request.getParameter("p2");
                Disciplinas.update(p1, p2, name);
                response.sendRedirect(request.getRequestURI());
            }
            list = Disciplinas.getList();
        }catch(Exception ex){
            erro = ex.getMessage();
        }
    %>
    <head>
        <link href="style/style.css" rel="stylesheet" />
        <%@include file="WEB-INF/jspf/links.jsp"%>
    </head>
    <body>
        <%if (session.getAttribute("user.login") == null) { %>
        <%@include file="WEB-INF/jspf/header.jsp"%>
        <%} else { %>
        <%@include file="WEB-INF/jspf/headerLogout.jsp"%>
        <%}%>
        <div class="container">
            <section class="section" id="home">
                <br>
                <div class="row mb-5" id="about1">
                    <div class="col-lg-5 col-md-6 align-self-center about-content"
                         data-anime="um">
                        <h2>
                            Quem Sou Eu
                        </h2>
                        <br>
                        <p>Oie! Eu me chamo Maria Luiza, estou no 4º ciclo de Análise e Desenvolvimento De Sistemas na Fatec de Praia Grande e meu número de matrícula é 1290482013029. Ah, eu entrei lá em agosto de 2019.</p>
                        <p>Vou deixar aqui meu <a href="https://www.linkedin.com/in/marialuizaaugusto/" id="link">LinkedIn</a> e meu <a href="https://github.com/IMaluz" id="git">Github</a> para conhecerem um pouco mais sobre mim o e sobre o que já fiz. Qualquer coisa pode chamar, viu?</p>
                    </div>
                    <div class="col-lg-7 col-md-6 mb-4 mb-md-0">
                        <div class="about-lado1" data-anime="um-dois">
                            <img class="img-fluid" src="img/img1.svg" alt="">
                        </div>
                    </div>
                </div>
            </section>

            <br><br><br>

            <h2>Notas</h2>

            <table class="table">
                <thead class="table table">
                    <tr>
                        <th scope="col">Matéria</th>
                        <th scope="col">p1</th>
                        <th scope="col">p2</th>
                        <th scope="col"> Média </th>
                    </tr>
                </thead>
                <%for (Disciplinas dcp : list) {%>
                <tbody>
                    <tr>
                        <td><%= dcp.getName()%></td>
                        <td><%= dcp.getP1()%></td>
                        <td><%= dcp.getP2()%></td>
                        <%int media = (Integer.parseInt(dcp.getP1()) + Integer.parseInt(dcp.getP2())) / 2;%>
                        <td><%= media%></td> 
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <br><br><br>
        </div> 

        <%@include file="WEB-INF/jspf/linksJS.jsp"%>
        <script type="text/javascript" src="script/script.js"></script>
    </body>
</html>
