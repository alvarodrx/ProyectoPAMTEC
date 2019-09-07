<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 2019-08-26
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Loading</title>

    <style>
        #primary-data-content {
            display: none;
        }

        #loading-wrapper {
            position: fixed;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
        }

        #loading-text {
            display: block;
            position: absolute;
            top: 50%;
            left: 50%;
            color: #999;
            width: 100px;
            height: 30px;
            margin: -7px 0 0 -45px;
            text-align: center;
            font-family: 'PT Sans Narrow', sans-serif;
            font-size: 20px;
        }

        #loading-content {
            display: block;
            position: relative;
            left: 50%;
            top: 50%;
            width: 170px;
            height: 170px;
            margin: -85px 0 0 -85px;
            border: 3px solid #2666ff;
        }

        #loading-content:after {
            content: "";
            position: absolute;
            border: 3px solid #46b8ff;
            left: 15px;
            right: 15px;
            top: 15px;
            bottom: 15px;
        }

        #loading-content:before {
            content: "";
            position: absolute;
            border: 3px solid #00F;
            left: 5px;
            right: 5px;
            top: 5px;
            bottom: 5px;
        }

        #loading-content {
            border: 3px solid transparent;
            border-top-color: #0079d6;
            border-bottom-color: #0079d6;
            border-radius: 50%;
            -webkit-animation: loader 2s linear infinite;
            -moz-animation: loader 2s linear infinite;
            -o-animation: loader 2s linear infinite;
            animation: loader 2s linear infinite;
        }

        #loading-content:before {
            border: 3px solid transparent;
            border-top-color: #23acec;
            border-bottom-color: #23acec;
            border-radius: 50%;
            -webkit-animation: loader 3s linear infinite;
            -moz-animation: loader 2s linear infinite;
            -o-animation: loader 2s linear infinite;
            animation: loader 3s linear infinite;
        }

        #loading-content:after {
            border: 3px solid transparent;
            border-top-color: #025084;
            border-bottom-color: #025084;
            border-radius: 50%;
            -webkit-animation: loader 1.5s linear infinite;
            animation: loader 1.5s linear infinite;
            -moz-animation: loader 2s linear infinite;
            -o-animation: loader 2s linear infinite;
        }

        @-webkit-keyframes loaders {
            0% {
                -webkit-transform: rotate(0deg);
                -ms-transform: rotate(0deg);
                transform: rotate(0deg);
            }
            100% {
                -webkit-transform: rotate(360deg);
                -ms-transform: rotate(360deg);
                transform: rotate(360deg);
            }
        }

        @keyframes loader {
            0% {
                -webkit-transform: rotate(0deg);
                -ms-transform: rotate(0deg);
                transform: rotate(0deg);
            }
            100% {
                -webkit-transform: rotate(360deg);
                -ms-transform: rotate(360deg);
                transform: rotate(360deg);
            }
        }

        #content-wrapper {
            color: #FFF;
            position: fixed;
            left: 0;
            top: 20px;
            width: 100%;
            height: 100%;
        }

        #header
        {
            width: 800px;
            margin: 0 auto;
            text-align: center;
            height: 100px;
            background-color: #666;
        }

        #content
        {
            width: 800px;
            height: 1000px;
            margin: 0 auto;
            text-align: center;
            background-color: #888;
        }

        #loading-content-panel {
            background: #e8efff;
            height: inherit;
        }
    </style>
</head>
<body>
<div id="loading-content-panel" >
    <div id="loading-wrapper">
        <div id="loading-text">Cargando...</div>
        <div id="loading-content"></div>
    </div>
</div>
</body>
</html>
