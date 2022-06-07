<%-- 
    Document   : Alterar
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
        <title>Alterar dados do usuário</title>
    </head>
    <body>
        <div class="container">
            <div class="form-image">
                <img src="../img/undraw_editable_re_4l94.svg" style="width: 70%" />
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
                            <form action="Controle.jsp" method="post" name="frm_alteracao" autocomplete="off">
                                <input type="hidden" name="hdn_operacao" value="ALTERAR" />
                                <input type="hidden" name="hdn_idUsuario" value="<%=vstr_idUsuario%>" />

                                <div class="form-header">
                                    <div class="title">
                                        <h1>Alterar</h1>
                                    </div>
                                </div>
                                
                                <div style="text-align: center; padding:10px">
                                    <%
                                        if(request.getParameter("msg") != null){
                                            if(request.getParameter("msg").length() > 0){
                                                out.print("<p>" + request.getParameter("msg") + "</p>");
                                                out.print("<a href='../painelOperacoes.html'>Voltar</a>");
                                            }
                                        }
                                    %>
                                </div>

                                <div class="input-group">
                                    <div class="input-box">
                                        <label for="firstname">Nome</label>
                                        <input id="username" type="text" name="txt_nome" value="<%=vobj_rs.getString("ds_nome")%>" placeholder="Digite seu Nome" maxlength="100" required />
                                    </div>
                                    
                                    <div class="input-box">
                                        <label  for="email">Email</label>
                                        <input id="email" type="email" name="txt_email" value="<%=vobj_rs.getString("ds_email")%>" placeholder="Digite seu Email" maxlength="100" required />
                                    </div>
                                    
                                    <div class="input-box">
                                        <label  for="number">Celular</label>
                                        <input id="number" type="tel" name="txt_celular" value="<%=vobj_rs.getString("nr_celular")%>" maxlength="11" required />
                                    </div>
                                    
                                    <div class="input-box">
                                        <label  for="password">Senha</label>
                                        <input id="txt_senha" type="password" name="txt_senha" value="<%=vobj_rs.getString("ds_senha")%>" placeholder="Digite uma Senha" maxlength="100" required />
                                    </div>
                                </div>

                                <div class="gender-inputs">
                                    <div class="gender-title">
                                        <h6>Gênero</h6>
                                    </div>

                                    <div class="gender-group">
                                        <div class="gender-input">
                                            <input type="radio" id="female" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Feminino")){out.print("checked");}%> name="rad_genero" value="Feminino">
                                            <label for="female">Feminino</label>
                                        </div>
                                        
                                        <div class="gender-input">
                                            <input type="radio" id="male" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Masculino")){out.print("checked");}%> name="rad_genero" value="Masculino">
                                            <label for="male">Masculino</label>
                                        </div>
                                        
                                        <div class="gender-input">
                                            <input type="radio" id="others" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Outros")){out.print("checked");}%> name="rad_genero" value="Outros">
                                            <label for="others">Outros</label>
                                        </div>
                                        
                                        <div class="gender-input">
                                            <input type="radio" id="none" <% if (vobj_rs.getString("ds_genero").equalsIgnoreCase("Indefinido")){out.print("checked");}%> name="rad_genero" value="Indefinido">
                                            <label for="none">Prefiro não dizer</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="continue-button">
                                    <button type="submit" style="color:white;">Alterar</button>
                                </div>
                            </form>
                <%
                        }
                        else {
                            out.print("<h1>Usuário não encontrado!</h1");
                        }
                        // 5) fecha a conexao com o banco
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
