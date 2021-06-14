<%@page import="br.com.luiza.db.User"%>
<%@page import="br.com.luiza.config.DbListener"%>
<%@ page pageEncoding="UTF-8"%>

<%
String erro = null;
if(request.getParameter("session.login")!=null){
    String login = request.getParameter("user.login");
    String password = request.getParameter("user.password");
    try{
        User user = User.getUser(login, password);
        if(user == null){
            erro = "Usuário / senha não encontrado";
        }else{
            session.setAttribute("user.login", user.getLogin());
            session.setAttribute("user.name", user.getName());
            session.setAttribute("user.role", user.getRole());
            response.sendRedirect(request.getRequestURI());
        }
    }catch(Exception ex){
        erro = ex.getMessage();
    }
}else if(request.getParameter("session.logout")!=null){
    session.removeAttribute("user.login");
    session.removeAttribute("user.name");
    session.removeAttribute("user.role");
    response.sendRedirect(request.getRequestURI());
}
%>
<%
	if (session.getAttribute("user.login") == null) {
%>
<div class="container d-flex justify-content-center">
	<div class="row">
		<div class="card"></div>
		<div class="card">
			<h1 class="title">Login</h1>
			<form class="container center-align" method="post" action="index.jsp">
				<div class="input-container">
					<input type="text" id="Username" required="required"
				 		name="user.login" /> <label for="Username">Usuário</label>
					<div class="bar"></div>
				</div>
				<div class="input-container">
					<input type="password" id="Password" required="required"
						name="user.password" /> <label for="Password">Senha</label>
					<div class="bar"></div>
				</div>
				<div class="button-container">
					<button name="session.login">
						<span>Entrar</span>
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%
	} else {
%>
<div class="container d-flex justify-content-center">
	<div class="row">
		<div class="card"></div>
		<div class="card">
			<h1 class="title">Logout</h1>
			<form class="container center-align" method="post">
				<div class="input-container">
					<h3>Você Realmente Deseja Sair?</h3>
				</div>
				<div class="button-container">
					<button type="button" class="botao"
						onclick="location.href='http://localhost:8080/ProvaPoo/index.jsp';">
						<span>Retornar</span>
					</button>
					<button type="submit" class="botao" name="session.logout">
						<span>Sair</span>
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%}%>