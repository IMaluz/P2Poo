<%@page import="br.com.luiza.db.Disciplinas"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <%
        String erro = null;
        ArrayList<Disciplinas> list = new ArrayList<>();
        try {
            if (request.getParameter("Inserir") != null) {
                String name = request.getParameter("name");
                String dia = request.getParameter("dia");
                String horario = request.getParameter("horario");
                String aulas = request.getParameter("aulas");
                Disciplinas.insert(name, horario, dia, aulas);
                response.sendRedirect(request.getRequestURI());
            } else if (request.getParameter("delete") != null) {
                String name = request.getParameter("name");
                Disciplinas.delete(name);
                response.sendRedirect(request.getRequestURI());
            } else if (request.getParameter("nota") != null) {
                String name = request.getParameter("name");
                String p1 = request.getParameter("p1");
                String p2 = request.getParameter("p2");
                Disciplinas.update(p1, p2, name);
                response.sendRedirect(request.getRequestURI());
            }
            list = Disciplinas.getList();
        } catch (Exception ex) {
            erro = ex.getMessage();
        }
    %>
    <head>
        <link href="style/style.css" rel="stylesheet" />
        <%@include file="WEB-INF/jspf/links.jsp"%>
    </head>

    <body>
        <%if (erro != null) {%>
        <p><%=erro%></p>
        <%}%>
        <%
            if (session.getAttribute("user.login") == null) {
        %>
        <%@include file="WEB-INF/jspf/header.jsp"%>
        <script>
            alert("Desculpa, infelizmente você não tem acesso a essa página :(");
            location = './index.jsp';
        </script>
        <%
        } else {
        %>
        <%@include file="WEB-INF/jspf/headerLogout.jsp"%>
        <br><br><br><br><br><br>
        <div class="container">
            <form method="post">
                <div class="row">
                    <div class="col-sm">
                        Nome da disciplina: <input type="text" name="name"/>
                    </div>
                    <div class="col-sm">
                        Dia da semana:  <select name="dia">
                            <option value="Segunda">Segunda-Feira</option>
                            <option value="Terca">Terça-Feira</option>
                            <option value="Quarta">Quarta-Feira</option>
                            <option value="Quinta">Quinta-Feira</option>
                            <option value="Sexta">Sexta-Feira</option>
                            <option value="Sabado">Sábado</option>
                        </select>
                    </div>
                    <div class="col-sm">           
                        Horário: <input type="time" name="horario"/>
                    </div>
                    <div class="col-sm">
                        Quantidade de Aulas: <input type="number" name="aulas"/>
                    </div>
                    <div class="col-sm">
                        <br>
                        <input type="submit" name="Inserir" value="Inserir"/>
                    </div>
                </div>
            </form>
            <br><br>
            <table class="table">
                <thead class="table table">
                    <tr>
                        <th scope="col">Nome</th>
                        <th scope="col">Dia da Semana</th>
                        <th scope="col">Horario</th>
                        <th scope="col">Quantidade de aulas</th>
                        <th scope="col">p1</th>
                        <th scope="col">p2</th>
                        <th scope="col">Ação</th>
                    </tr>
                </thead>
                <%for (Disciplinas dcp : list) {%>
                <tbody>   
                    <tr>
                        <td><%= dcp.getName()%></td>
                        <td><%= dcp.getDia()%></td>
                        <td><%= dcp.getHorario()%></td>
                        <td><%= dcp.getAulas()%></td>
                        <%if (dcp.getP1() != null) {%>
                        <td><%= dcp.getP1()%></td>
                        <%} else { %>
                        <td></td>
                        <%}%>
                        <%if (dcp.getP1() != null) {%>
                        <td><%= dcp.getP2()%></td>
                        <%} else { %>
                        <td></td>
                        <%}%>
                        <td>
                            <form method="post">

                                <input type="hidden" name="name" value="<%= dcp.getName()%>"/>
                                <input type="submit" name="delete" value="Excluir"/>
                            </form>
                        </td>
                    </tr>
                </tbody>
                <%}%>
            </table>

            <br><br>

            <h1>Atualizar Notas</h1>

            <table class="table">
                <thead class="table table">
                    <tr>
                        <th scope="col">Materia</th>
                        <th scope="col">p1</th>
                        <th scope="col">p2</th>
                    </tr>
                </thead>
            </table>
        </div>
        <br><br>
        <%}%>


        <%@include file="WEB-INF/jspf/linksJS.jsp"%>
        <script type="text/javascript" src="script/script.js"></script>
    </body>
</html>