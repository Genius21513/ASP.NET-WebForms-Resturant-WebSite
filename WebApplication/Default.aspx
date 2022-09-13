<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication._Default" %>

<style>
    @font-face {
        font-family: 'OpenSans';
        font-style: normal;
        src: url(../fonts/OpenSans-Regular.ttf) format('truetype');
        font-display: fallback;
    }

    .campo {
        --pos-layout-primary-color: #027491;
        --pos-layout-secondary-color: #2190ac;
        --pos-layout-font-color: #fff;
        --pos-font-color: #555;
        --pos-secondary-color: #fff;
        --pos-grey-background: #f8f8f8;
        --pos-layout-font-size: 14px;
        box-sizing: border-box;
        font-family: "OpenSans", sans-serif;
        color: #027491;
        border: solid 1px #027491;
        appearance: none;
        outline: 0;
        width: 280px;
        border-radius: 3px;
        padding: 10px 15px;
        margin: 0 auto 10px auto;
        display: block;
        text-align: center;
        font-size: 18px;
        transition-duration: 0.25s;
        font-weight: 300;
        background-color: rgba(255, 255, 255, 0.4);
    }

    #cmdLogin {
        --pos-layout-primary-color: #027491;
        --pos-layout-secondary-color: #2190ac;
        --pos-layout-font-color: #fff;
        --pos-font-color: #555;
        --pos-secondary-color: #fff;
        --pos-grey-background: #f8f8f8;
        --pos-layout-font-size: 14px;
        box-sizing: border-box;
        margin: 0;
        font-family: "OpenSans", sans-serif;
        background-color: #027491;
        color: #fff;
        appearance: none;
        outline: 0;
        border: 0;
        padding: 10px 15px;
        border-radius: 3px;
        width: 280px;
        cursor: pointer;
        font-size: 18px;
        transition-duration: 0.25s;
        font-weight: 900;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "OpenSans", sans-serif;
    }

    .ddwcpos-login-wrapper {
        position: fixed;
        display: grid;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.4);
        text-align: center;
        margin: 0 auto;
        place-content: center;
        align-items: center;
    }

    .ddwcpos-login-container {
        background-color: #fefefe;
        padding: 65px 80px;
        position: relative;
        z-index: 1;
        box-shadow: 0 0 10px;
    }

        .ddwcpos-login-container h1 {
            font-size: 42px;
            transition-duration: 10s;
            transition-timing-function: ease-in-out;
            font-weight: 600;
        }

    .ddwcpos-login-error {
        background: #f55050;
        padding: 10px;
        border-radius: 3px;
    }

        .ddwcpos-login-error p {
            color: #fff;
        }

    form#ddwcpos-login-form {
        padding: 20px 0;
        position: relative;
        font-size: 15px;
    }

        form#ddwcpos-login-form label {
            font-weight: 900;
        }

        form#ddwcpos-login-form p.login-forgot-password, form#ddwcpos-login-form p.login-remember {
            width: fit-content;
            display: inline-block;
            margin: 0px 18px 10px;
        }

        form#ddwcpos-login-form input:not([type='checkbox']):not([type='submit']) {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: 0;
            background-color: rgba(255, 255, 255, 0.2);
            width: 280px;
            border-radius: 3px;
            padding: 10px 15px;
            margin: 0 auto 10px auto;
            display: block;
            text-align: center;
            font-size: 18px;
            transition-duration: 0.25s;
            font-weight: 300;
        }

            form#ddwcpos-login-form input:not([type='checkbox']):not([type='submit']):hover {
                background-color: rgba(255, 255, 255, 0.4);
            }

            form#ddwcpos-login-form input:not([type='checkbox']):not([type='submit']):focus {
                background-color: white;
                width: 300px;
                color: #53e3a6;
            }

        form#ddwcpos-login-form input[type="submit"] {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: 0;
            border: 0;
            padding: 10px 15px;
            border-radius: 3px;
            width: 280px;
            cursor: pointer;
            font-size: 18px;
            transition-duration: 0.25s;
            font-weight: 900;
        }

            form#ddwcpos-login-form input[type="submit"]:hover {
                box-shadow: inset 0 0 100px 100px rgba(0,0,0,.07);
            }

    .ddwcpos-bubbles li {
        position: absolute;
        list-style: none;
        display: block;
        width: 40px;
        height: 40px;
        background-color: rgba(255, 255, 255, 0.15);
        bottom: 0px;
        -webkit-animation: square 25s infinite;
        animation: square 25s infinite;
        transition-timing-function: linear;
    }

        .ddwcpos-bubbles li:nth-child(1) {
            left: 10%;
        }

        .ddwcpos-bubbles li:nth-child(2) {
            left: 20%;
            width: 80px;
            height: 80px;
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            -webkit-animation-duration: 17s;
            animation-duration: 17s;
        }

        .ddwcpos-bubbles li:nth-child(3) {
            left: 25%;
            -webkit-animation-delay: 4s;
            animation-delay: 4s;
        }

        .ddwcpos-bubbles li:nth-child(4) {
            left: 40%;
            width: 60px;
            height: 60px;
            -webkit-animation-duration: 22s;
            animation-duration: 22s;
            background-color: rgba(255, 255, 255, 0.25);
        }

        .ddwcpos-bubbles li:nth-child(5) {
            left: 70%;
        }

        .ddwcpos-bubbles li:nth-child(6) {
            left: 80%;
            width: 120px;
            height: 120px;
            -webkit-animation-delay: 3s;
            animation-delay: 3s;
            background-color: rgba(255, 255, 255, 0.2);
        }

        .ddwcpos-bubbles li:nth-child(7) {
            left: 32%;
            width: 160px;
            height: 160px;
            -webkit-animation-delay: 7s;
            animation-delay: 7s;
        }

        .ddwcpos-bubbles li:nth-child(8) {
            left: 55%;
            width: 20px;
            height: 20px;
            -webkit-animation-delay: 15s;
            animation-delay: 15s;
            -webkit-animation-duration: 40s;
            animation-duration: 40s;
        }

        .ddwcpos-bubbles li:nth-child(9) {
            left: 25%;
            width: 10px;
            height: 10px;
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            -webkit-animation-duration: 40s;
            animation-duration: 40s;
            background-color: rgba(255, 255, 255, 0.3);
        }

        .ddwcpos-bubbles li:nth-child(10) {
            left: 83%;
            width: 160px;
            height: 160px;
            -webkit-animation-delay: 11s;
            animation-delay: 11s;
        }

    @-webkit-keyframes square {
        0% {
            transform: translateY(0);
        }

        100% {
            transform: translateY(-700px) rotate(600deg);
        }
    }

    @keyframes square {
        0% {
            transform: translateY(0);
        }

        100% {
            transform: translateY(-700px) rotate(600deg);
        }
    }

    h1 {
        font-size: 42px;
        transition-duration: 10s;
        transition-timing-function: ease-in-out;
        font-weight: 600;
    }

    form#login-form input:not([type='checkbox']):not([type='submit']) {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        outline: 0;
        background-color: rgba(255, 255, 255, 0.2);
        width: 280px;
        border-radius: 3px;
        padding: 10px 15px;
        margin: 0 auto 10px auto;
        display: block;
        text-align: center;
        font-size: 18px;
        transition-duration: 0.25s;
        font-weight: 300;
    }

    form input:not([type='checkbox']):not([type='submit']):focus {
        background-color: #027491;
        color: #2190ac;
    }

    form input:not([type='checkbox']):not([type='submit']) {
        color: #027491;
        border: solid 1px #027491;
    }

    #loginsubmit {
        padding: 20px 0;
        position: relative;
        font-size: 15px;
    }

    p {
        display: block;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
    }

    * {
        box-sizing: border-box;
        font-family: "OpenSans", sans-serif;
    }

    .login-container {
        background-color: #fefefe;
        padding: 65px 80px;
        position: relative;
        z-index: 1;
        box-shadow: 0 0 10px;
    }

    h3 {
        display: block;
        font-size: 1.17em;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        font-weight: bold;
    }

    .login-wrapper {
        position: fixed;
        display: grid;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.4);
        text-align: center;
        margin: 0 auto;
        place-content: center;
        align-items: center;
    }

    label {
        --pos-layout-primary-color: #027491;
        --pos-layout-secondary-color: #2190ac;
        --pos-layout-font-color: #fff;
        --pos-font-color: #555;
        --pos-secondary-color: #fff;
        --pos-grey-background: #f8f8f8;
        --pos-layout-font-size: 14px;
        text-align: center;
        color: #027491;
        font-size: 15px;
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "OpenSans", sans-serif;
        font-weight: 900;
    }
</style>
<div class="login-wrapper" style="background-image: linear-gradient(#2190ac 0%,#027491 100%); color: #027491;">
    <div class="login-container">
        <form id="loginsubmit" runat="server">

            <h1>
                <font face="Verdana">Welcome to Point of Sale</font>
            </h1>
            <p>
                <label>Username or email</label>
                <input id="txtUserName" type="text" runat="server" class="campo" />
                <asp:RequiredFieldValidator ControlToValidate="txtUserName"
                    Display="Static" ErrorMessage="*" runat="server"
                    ID="UserName" />
            </p>
            <p>
                <label>Password</label>
                <input id="txtUserPass" type="password" runat="server" class="campo" />
                <asp:RequiredFieldValidator ControlToValidate="txtUserPass"
                    Display="Static" ErrorMessage="*" runat="server"
                    ID="vUserPass" />
            </p>
            <p>
                <a href="#">Forgot Password</a>
            </p>
            <p>
                <label>Remember Me</label>
                <asp:CheckBox id="CheckBox" runat="server" autopostback="false" />
            </p>
            <p>
                <input type="submit" value="Login" runat="server" id="cmdLogin" />
                <label id="lblMsg" forecolor="red" font-name="Verdana" font-size="10" runat="server" />
            </p>
        </form>
        <h3>Thanks for using the Point of Sale</h3>
        <ul class="ddwcpos-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
