<html>
<head>
    <!--
    <%
        String message = "", millis = "", userId = "", usuario = "";
        Object attr = session.getAttribute("message");
        if (attr != null)
            message = attr.toString();
        pageContext.setAttribute("message", message);

        attr = session.getAttribute("millis");
        if (attr != null)
            millis = attr.toString();
        pageContext.setAttribute("millis", millis);

        attr = session.getAttribute("userId");
        if (attr != null)
            userId = attr.toString();
        pageContext.setAttribute("userId", userId);
        session.removeAttribute("message");

        attr = session.getAttribute("usuario");
        if (attr != null)
            usuario = attr.toString();
        pageContext.setAttribute("usuario", usuario);
        session.removeAttribute("message");



    %>
    -->
    <title>SISAS</title>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/cosmos.min.css">
    <link rel="stylesheet" href="../css/estiloMisCursos.css">
    <script src="/SISAS/login/js/transiciones.js"></script>
    <script src="/SISAS/login/js/funcionesMisCursos.js"></script>
    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>


</head>
<body>
<input type="hidden" id="millis" name="millis" value="${millis}">
<input type="hidden" id="message" name="message" value="${message}">
<div class="primary-data-content">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <img src="../imagenes/logoBlanco.png" class="img-fluid logo">
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0" action="/weblogin?tipo=SALIR">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">
                    <span class="align-top">Salir</span>
                    <i class="material-icons">exit_to_app</i>
                </button>
            </form>
        </div>
    </nav>

    <div class="wrapper">
        <div class="card bg-light mb-3 rounded-lg shadow">
            <div class="card-body" style="display: block; width: 400px; max-height: 400px;">
                <h2 class="card-title mx-auto" style="text-align: center"><b>Mis cursos</b></h2>
                <h3 style="text-align:center"> Usuario: ${usuario} </h3> <!-- este --->
                <br>
                <div class="table-responsive" style="max-height: 280px;overflow-y: scroll;">
                    <table class="table table-hover">
                        <tbody>
                        <jsp:include page="/getCursos">
                            <jsp:param name="tipo" value="LISTA"/>
                            <jsp:param name="userId" value="${userId}"/>
                        </jsp:include>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
<%@ include file="/loadingPage/loadingWrapper.jsp" %>
</html>
