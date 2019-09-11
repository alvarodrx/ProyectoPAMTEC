<html>
<head>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/selectize.js/0.8.5/js/standalone/selectize.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://bootswatch.com/4/cerulean/bootstrap.min.css">
    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <title>Iniciar Sesi&oacute;n</title>

    <%
        String message = "", millis = "";
        Object attr = session.getAttribute("message");
        if (attr != null)
            message = attr.toString();
        pageContext.setAttribute("message", message);
        session.removeAttribute("message");

    %>
    <style>

        body {
            background-image: url("https://storage.googleapis.com/recursos-pamtec/recusos-web/login/portadaFacebook.jpg");
            background-color: #cccccc;
            background-repeat: no-repeat;
            background-size: cover;
        }

        body, html {
            height: 100%;
            width: 100%;
            margin: 0px;
            font-family: Arial, serif;
        }

        /*    OTROS    */

        @keyframes spinner {
            0% {
                transform: rotateZ(0deg);
            }
            100% {
                transform: rotateZ(359deg);
            }
        }

        * {
            box-sizing: border-box;
        }

        .wrapper {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            width: 500px;
            height: 100%;
            position: absolute;
            right: 0;
            background: #7171B787;
        }

        .login {
            border-radius: 2px 2px 5px 5px;
            padding: 30px;
            width: 400px;
            position: relative;
            box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.3);
            height: 80%;
            background: #2F3042A6;
        }

        .login.loading button {
            max-height: 100%;
            padding-top: 50px;
            position: absolute;
        }

        .login.loading button .spinner {
            opacity: 1;
            top: 40%;
        }

        .login.ok button {
            background-color: #8bc34a;
        }
        .login.notok button {
            background-color: #c36312;
        }

        .login.ok button .spinner {
            border-radius: 0;
            border-top-color: transparent;
            border-right-color: transparent;
            height: 20px;
            animation: none;
            transform: rotateZ(-45deg);
        }

        .login input {
            display: block;
            padding: 15px 10px;
            margin-bottom: 10px;
            width: 100%;
            border: 1px solid #ddd;
            transition: border-width 0.2s ease;
            border-radius: 2px;
            color: #005c9a;
        }

        .login input + i.fa {
            color: #fff;
            font-size: 1em;
            position: absolute;
            margin-top: -42px;
            opacity: 0;
            right: 0px;
            transition: all 0.1s ease-in;
        }

        .login input + i.fa {
            opacity: 1;
            right: 40px;
            transition: all 0.25s ease-out;
        }

        .fa {
            display: inline-block;
            font: normal normal normal 14px/1 FontAwesome;
            font-size: inherit;
            text-rendering: auto;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            transform: translate(0, 0);
        }

        .ico {
            width: 20px;
        }

        .fa-user:before {
            content: "\f007";
        }

        .login a {
            font-size: 0.8em;
            color: rgb(21, 118, 255);
            text-decoration: none;
        }

        .login .title {
            color: #ffffff;
            font-size: 2em;
            text-align: center;
            margin: 10px 0 30px 0;
            /*border-bottom: 1px solid #eee;*/
            padding: 20px;
        }

        .login .title2 {
            color: #ffffff;
            font-size: 1.4em;
            text-align: left;
            /*border-bottom: 1px solid #eee;*/
        }

        .login button {
            width: 100%;
            height: 100%;
            padding: 10px 10px;
            background: rgb(21, 118, 255);
            color: #fff;
            display: block;
            left: 0;
            bottom: 0;
            max-height: 50px;
            border: 0px solid rgba(0, 0, 0, 0.1);
            border-radius: 0 0 2px 2px;
            transform: rotateZ(0deg);
            transition: all 0.1s ease-out;
        }

        .login button .spinner {
            display: block;
            width: 40px;
            height: 40px;
            position: absolute;
            border: 4px solid #ffffff;
            border-top-color: rgba(255, 255, 255, 0.3);
            border-radius: 100%;
            left: 50%;
            top: 0;
            opacity: 0;
            margin-left: -20px;
            margin-top: -20px;
            animation: spinner 0.6s infinite linear;
            transition: top 0.3s 0.3s ease, opacity 0.3s 0.3s ease, border-radius 0.3s ease;
            box-shadow: 0px 1px 0px rgba(0, 0, 0, 0.4);
        }

        .login:not(.loading) button:hover {
            box-shadow: 0px 1px 3px #2196F3;
        }

        .login:not(.loading) button:focus {
            border-bottom-width: 4px;
        }

        footer {
            display: block;
            padding-top: 50px;
            text-align: center;
            color: #ddd;
            font-weight: normal;
            text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.2);
            font-size: 0.8em;
        }

        footer a, footer a:link {
            color: #fff;
            text-decoration: none;
        }

        .state {
            background: border-box;
        }


    </style>
</head>
<body>
<div class="wrapper">
    <form method="post" action="/weblogin" class="login">
        <p class="title">SISAS PAMTEC</p>
        <div>
            <p class="title2">Iniciar sesi&oacute;n</p>
            <div class="input-group mb-3">
                <input type="text" class="form-control" name="username" placeholder="Usuario" aria-label="Username"
                       required aria-describedby="basic-addon1">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1">
                        <img class="responsive ico"
                             src="https://storage.googleapis.com/recursos-pamtec/recusos-web/login/user_male.png">
                    </span>
                </div>
            </div>
            <br>
            <div class="input-group mb-3">
                <input type="password" class="form-control" name="password" placeholder="Contrase&ntilde;a"
                       required aria-label="Username" aria-describedby="basic-addon2">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon2">
                        <img class="responsive ico"
                             src="https://storage.googleapis.com/recursos-pamtec/recusos-web/login/password.png">
                    </span>
                </div>
            </div>
            <p class="text-warning text-center">${message}</p>
            <br>
            <button>
                <i class="spinner"></i>
                <span class="state" type="submit" name="commit" style="-webkit-appearance: none !important;">Ingresar</span>
            </button>
        </div>
    </form>
    </p>
</div>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>


<script src="js/index.js"></script>
</body>
</html>
