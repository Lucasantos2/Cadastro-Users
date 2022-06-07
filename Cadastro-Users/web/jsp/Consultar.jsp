<%-- 
    Document   : consultar
    Created on : 22 de mai. de 2022, 18:52:33
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
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="../css/style-cad.css" rel="stylesheet" type="text/css"/>
        <title>Consultar usuários</title>
    </head>
    <body>
        <style>
            table{
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            td, th{
                padding: 8px;
                border: 1px solid black;
            }

            th {
                background-color: lightgray;
                font-weight: 700;
                height: 10px !important;
            }
            td {
                background-color: white;
            }
            
        </style>
        
        <div class="container" style="background-color: rgb(0, 110, 255); overflow-y: auto">
            <form action="Controle.jsp" method="post" name="frm_excluir" style="width: 100%;">
                <input type="hidden" name="hdn_operacao" value="EXCLUIR"/>
                
                <h2 style="margin: 10px 0px -9px 5px; color: white; font-weight: 600">Consutar usuários</h2>
                
                <table border="0" style="text-align: center">
                    <tr>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th>Celular</th>
                        <th>Senha</th>
                        <th>Gênero</th>
                        <th>Alterar</th>
                        <th>Excluir</th>
                    </tr>
                    <%
                        Connection conexao;
                        PreparedStatement st;

                        String vstr_nome, vstr_email, vstr_celular, vstr_senha, vstr_genero, vstr_flag;

                        vstr_flag       = request.getParameter("hdn_operacaoCON");
                        vstr_nome       = request.getParameter("txt_nomeCON");
                        vstr_email      = request.getParameter("txt_emailCON");

                        // ------------- OPERAÇÃO DE CONSULTA ---------------

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_projeto", "root", "1234");

                            // 3) enviar os dados para a tabela correspondente
                            st = conexao.prepareStatement("SELECT * FROM new_tb_usuario WHERE ds_nome LIKE ? AND ds_email LIKE ? ");
                            st.setString(1, "%" + vstr_nome + "%");
                            st.setString(2, "%" + vstr_email + "%");
                            ResultSet vobj_rs = st.executeQuery();

                            // 4) Se o produto for encontrado, mostrar na tela
                            while (vobj_rs.next()){
            %>
                                <tr>
                                    <input type="hidden" name="hdn_idUsuario" value="<% out.print(vobj_rs.getInt("id_usuario")); %>" />
                                    <td><% out.print(vobj_rs.getString("ds_nome")); %></td>
                                    <td><% out.print(vobj_rs.getString("ds_email")); %></td>
                                    <td><% out.print(vobj_rs.getString("nr_celular")); %></td>
                                    <td><% out.print(vobj_rs.getString("ds_senha")); %></td>
                                    <td><% out.print(vobj_rs.getString("ds_genero")); %></td>
                                    <td><a style="color: initial" href="Alterar.jsp?hdn_hashCode=<% out.print(vobj_rs.getInt("id_usuario")); %>&msg"><i class="fas fa-edit fa-lg"></i></a></td>
                                    <td><a style="color: initial" href="Excluir.jsp?hdn_hashCode=<% out.print(vobj_rs.getInt("id_usuario")); %>&msg"><i class="fas fa-user-times fa-lg"></i></a></td>
                                </tr>
            <%
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
                </table>
            </form>
        </div>
    </body>
</html>
