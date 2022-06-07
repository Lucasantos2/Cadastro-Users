<%-- 
    Document   : Cadastrar
    Created on : 21 de mai. de 2022, 18:25:44
    Author     : Greville
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style-cad.css" rel="stylesheet" type="text/css"/>
        <title>Controle de operações JSP</title>
    </head>
    <body>
        <%
            Connection conexao;
            PreparedStatement st;
            
            if(request.getParameter("hdn_operacao").equalsIgnoreCase("")){
                out.print("Erro ao captar o código de operação. Contate o administador do sistema!");
                return;
            }
            else {
                String vstr_nome, vstr_email, vstr_celular, vstr_senha, vstr_genero, vstr_flag;
                int vint_idUsuario;
                
                vstr_flag           = request.getParameter("hdn_operacao");
                vstr_nome           = request.getParameter("txt_nome");
                vstr_email          = request.getParameter("txt_email");
                vstr_celular        = request.getParameter("txt_celular");
                vstr_senha          = request.getParameter("txt_senha");
                vstr_genero         = request.getParameter("rad_genero");
                
                
                // ------------------------ COMEÇO DAS OPERAÇÕES ------------------------------
                
                if(vstr_flag.equalsIgnoreCase("CADASTRAR")){
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_projeto", "root", "1234");

                        st = conexao.prepareStatement("INSERT INTO new_tb_usuario (ds_nome, ds_email, nr_celular, ds_senha, ds_genero) VALUES(?, ?, ?, ?, ?)");

                        st.setString(1, vstr_nome);
                        st.setString(2, vstr_email);
                        st.setString(3, vstr_celular);
                        st.setString(4, vstr_senha);
                        st.setString(5, vstr_genero);
                        st.executeUpdate();

                        out.print("<p>Dados salvos com sucesso!</p>");
                        response.sendRedirect("Entrar.jsp");


                        conexao.close();
                    } 
                    catch (ClassNotFoundException x) {
                        out.print("Erro na conexão com o banco de dados " + x.getMessage());
                    } 

                    catch (SQLException x){
                        out.print("Erro de SQL " + x.getMessage());
                    }
                }

                else if(vstr_flag.equalsIgnoreCase("ENTRAR")){
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_projeto","root","1234");


                        st = conexao.prepareStatement("SELECT *FROM new_tb_usuario WHERE ds_email = ? AND ds_senha = ?");
                        st.setString(1, vstr_email);
                        st.setString(2, vstr_senha);
                        ResultSet vobj_rs = st.executeQuery();

                        if (vobj_rs.next()) {
                            response.sendRedirect("../painelOperacoes.html");
                        }
                        else {
                            response.sendRedirect("Entrar.jsp?msg=E-mail e/ou senha incorretos");
                        }

                        conexao.close();
                    } 
                    catch (ClassNotFoundException x) {
                        out.print("Erro na conexão com o banco de dados " + x.getMessage());
                    } 
                    catch (SQLException x){
                        out.print("Erro de SQL " + x.getMessage());
                    }
                }
                
                else if(vstr_flag.equalsIgnoreCase("CONSULTAR")){
                    // ficou na tela de consulta
                }
                
                else if(vstr_flag.equalsIgnoreCase("ALTERAR")){
                    vint_idUsuario = Integer.parseInt(request.getParameter("hdn_idUsuario"));
                    
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_projeto", "root", "1234");

                        st = conexao.prepareStatement("UPDATE new_tb_usuario SET ds_nome = ?, ds_email = ?, nr_celular = ?, ds_senha = ?, ds_genero = ? WHERE id_usuario = ?");


                        st.setString(1, vstr_nome);
                        st.setString(2, vstr_email);
                        st.setString(3, vstr_celular);
                        st.setString(4, vstr_senha);
                        st.setString(5, vstr_genero);
                        st.setInt(6, vint_idUsuario);
                        st.executeUpdate();

                        response.sendRedirect("Alterar.jsp?hdn_hashCode=" + vint_idUsuario + "&msg=Dados alterados com sucesso!");
                        
                        conexao.close();
                    } 
                    catch (ClassNotFoundException x) {
                            out.print("Erro na conexão com o banco de dados " + x.getMessage());
                    } 
                    catch (SQLException x){
                        out.print("Erro de SQL " + x.getMessage());
                    }
                }
                
                else if(vstr_flag.equalsIgnoreCase("EXCLUIR")){
                    vint_idUsuario = Integer.parseInt(request.getParameter("hdn_idUsuario"));

                    try {
                        // 2) conectar com o banco
                        Class.forName("com.mysql.jdbc.Driver");
                        conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_projeto", "root", "1234");


                        // 3) enviar o parametro para exclusão dos dados correspondentes
                        st = conexao.prepareStatement("DELETE FROM new_tb_usuario WHERE id_usuario = ?");
                        st.setInt(1, vint_idUsuario);
                        int vint_confirmaExclusao = st.executeUpdate();

                        if (vint_confirmaExclusao == 1) {
                            response.sendRedirect("Excluir.jsp?hdn_hashCode=" + vint_idUsuario + "&msg=Dados excluidos com sucesso!");
                        }
                        else{
                            response.sendRedirect("Excluir.jsp?hdn_hashCode=" + vint_idUsuario + "&msg=Algo deu errado! Entre em contato com o administrador do sistema.");
                        }

                        conexao.close();
                    } 
                    catch (ClassNotFoundException x) {
                        out.print("Erro na conexão com o banco de dados " + x.getMessage());
                    } 
                    catch (SQLException x){
                        out.print("Erro de SQL " + x.getMessage());
                    }
                }
            }
            
        %>
    </body>
</html>

