<%-- 
    Document   : Excluir
    Created on : 28 de mai. de 2022, 10:53:22
    Author     : Greville
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="PT-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style-cad.css" rel="stylesheet" type="text/css"/>
        <title>Excluir dados do usuário</title>
    </head>
    <body>
        <style>
            input{
                background-color: #f4f4f4;
                border: 1px solid #ededed !important;
            }
        </style>
        
        <div class="container">
            <div class="form-image">
                <img src="../img/undraw_Throw_away_re_x60k.jpg" />
            </div>
            
            <div class="form">
                <%
                    Connection conexao;
                    PreparedStatement st;
                        
                    String vstr_idUsuario;

                    if (request.getParameter("hdn_hashCode").equalsIgnoreCase("")){
                        out.print("<h1>Usuário não encontrado!</h1");
                        return;
                    } 
                    else {
                        vstr_idUsuario  = request.getParameter("hdn_hashCode");
                    }

                    try{
                        // 2) conectar com o banco
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_projeto", "root", "1234");

                        // 3) enviar os dados para a tabela correspondente
                        st = conexao.prepareStatement("SELECT * FROM new_tb_usuario WHERE id_usuario = ?");
                        st.setString(1, vstr_idUsuario);
                        ResultSet vobj_rs = st.executeQuery();

                        // 4) Se o produto for encontrado,trazer os dados
                        if (vobj_rs.next()){
                %>
                            <form action="Controle.jsp" method="post" name="frm_exclusao" autocomplete="off">
                                <input type="hidden" name="hdn_operacao" value="EXCLUIR" />
                                <input type="hidden" name="hdn_idUsuario" value="<%=vstr_idUsuario%>" />

                                <div class="form-header">
                                    <div class="title">
                                        <h1>Excluir</h1>
                                    </div>
                                </div>

                                <div class="input-group">
                                    <div class="input-box">
                                        <label for="firstname">Nome</label>
                                        <input id="username" type="text" name="txt_nome" value="<%=vobj_rs.getString("ds_nome")%>" readonly maxlength="100" />
                                    </div>
                                    
                                    <div class="input-box">
                                        <label  for="email">Email</label>
                                        <input id="email" type="email" name="txt_email" value="<%=vobj_rs.getString("ds_email")%>" readonly maxlength="100" />
                                    </div>
                                    
                                    <div class="input-box">
                                        <label  for="number">Celular</label>
                                        <input id="number" type="tel" name="txt_celular" value="<%=vobj_rs.getString("nr_celular")%>" maxlength="11" readonly />
                                    </div>
                                    
                                    <div class="input-box">
                                        <label  for="password">Senha</label>
                                        <input id="txt_senha" type="password" name="txt_senha" value="<%=vobj_rs.getString("ds_senha")%>" readonly maxlength="100" />
                                    </div>
                                </div>

                                <div class="gender-inputs">
                                    <div class="gender-title">
                                        <h6>Gênero</h6>
                                    </div>

                                    <div class="gender-group">
                                        <div class="gender-input">
                                            <input type="radio" id="female" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Feminino")){out.print("checked readonly");}%> name="rad_genero" readonly value="Feminino">
                                            <label for="female">Feminino</label>
                                        </div>
                                        
                                        <div class="gender-input">
                                            <input type="radio" id="male" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Masculino")){out.print("checked readonly");}%> name="rad_genero" readonly value="Masculino">
                                            <label for="male">Masculino</label>
                                        </div>
                                        
                                        <div class="gender-input">
                                            <input type="radio" id="others" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Outros")){out.print("checked");}%> name="rad_genero" readonly value="Outros">
                                            <label for="others">Outros</label>
                                        </div>
                                        
                                        <div class="gender-input">
                                            <input type="radio" id="none" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Indefinido")){out.print("checked");}%> name="rad_genero" readonly value="Indefinido">
                                            <label for="none">Prefiro não dizer</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="continue-button">
                                    <button type="submit" style="color:white;">Excluir</button>
                                </div>
                            </form>
                <%
                        }
                        else {
                            out.print("<div style='display:flex; flex-direction: column !important'>");
                            if(request.getParameter("msg") != null){
                                if(request.getParameter("msg").length() > 0){
                                    out.println("<h2>" + request.getParameter("msg") + "</h2>");
                                }
                                else {
                                    out.println("<h2>Usuário não encontrado!</h2>");
                                }
                            }
                %>
                                    <div class='continue-button'>
                                        <a href='../painelOperacoes.html'>
                                            <button type='button' style='color:white;'>Voltar</button>
                                        </a>
                                    </div>
                <%
                            out.print("</div>");
                        }
                        conexao.close();
                    }
                    catch (ClassNotFoundException x) {
                            out.print("Erro no Driver JDBC. " + x.getMessage());
                    } 
                    catch (SQLException x){
                        out.print("Erro no comando SQL. " + x.getMessage());
                    }
                %>
            </div>
        </div>
    </body>
</html>
