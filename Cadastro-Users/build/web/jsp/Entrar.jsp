<%-- 
    Document   : Entrar
    Created on : 21 de mai. de 2022, 22:53:22
    Author     : Greville
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="PT-BR">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../css/style-cad.css" rel="stylesheet" type="text/css"/>
        <title>Fazer login</title>
    </head>

    <body>
        <div class="container">
            <div class="form-image">
                <img src="../img/undraw_access_account_re_8spm.svg" style="width: 90%" />
            </div>
            <div class="form">
                <form action="Controle.jsp" method="post" name="frm_entrar" autocomplete="off">
                    <input type="hidden" name="hdn_operacao" value="ENTRAR" />
                    
                    <div class="form-header">
                        <div class="title">
                            <h1>Entrar</h1>
                        </div>
                        <div class="login-button">
                            <button><a href="../cadastro.html">Cadastrar</a></button>
                        </div>
                    </div>
                    
                    <div style="text-align: center; padding:10px">
                        <%
                            if(request.getParameter("msg") != null){
                                out.print("<p>" + request.getParameter("msg") + "</p>");
                            }
                        %>
                    </div>

                    <div class="input-group">
                        <div class="input-box">
                            <label  for="email">Email</label>
                            <input id="email" type="email" name="txt_email" placeholder="Digite seu Email" maxlength="100" required />
                        </div>
                        <div class="input-box">
                            <label  for="password">Senha</label>
                            <input id="txt_senha" type="password" name="txt_senha" placeholder="Digite uma Senha" maxlength="100" required />
                        </div>
                    </div>

                    <div class="continue-button">
                        <button type="submit" style="color:white;">ENTRAR</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>